# -*- coding: utf-8 -*-

import argparse
import hashlib
import json
import logging
import logging.handlers
import os.path
from typing import List, Dict, Tuple

import dateutil.parser
import requests
from PIL import Image
from trello import TrelloApi

# ID of our Trello list "nivoi"
LIST_ID = 'XskvwsLP'

serbian_to_ascii = {
    'А': 'A', 'Б': 'B', 'В': 'V', 'Г': 'G', 'Д': 'D', 'Е': 'E',
    'Ж': 'Z', 'З': 'Z', 'И': 'I', 'Ј': 'J', 'К': 'K', 'Л': 'L',
    'М': 'M', 'Н': 'N', 'Њ': 'Nj', 'О': 'O', 'П': 'P', 'Р': 'R',
    'С': 'S', 'Т': 'T', 'Ћ': 'C', 'У': 'U', 'Ф': 'F', 'Х': 'H',
    'Ц': 'C', 'Ч': 'Č', 'Џ': 'Dz', 'Ш': 'S', 'Ђ': 'Dj', 'Љ': 'Lj',
    'Ć': 'C', 'Ž': 'Z', 'Č': 'C', 'Đ': 'DJ', 'Š': 'S'}


def setup_logger(logging_level=logging.INFO):
    """
    Simple logger used throughout whole code - logs both to file and console
    """
    logger_setup = logging.getLogger('level-assembler')
    logger_setup.setLevel(logging.DEBUG)
    formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')

    ch = logging.handlers.TimedRotatingFileHandler(
        filename='level-assembler.log', when='midnight', interval=1, encoding='utf-8')
    ch.setLevel(logging.DEBUG)
    ch.setFormatter(formatter)
    logger_setup.addHandler(ch)

    ch = logging.StreamHandler()
    ch.setLevel(logging_level)
    ch.setFormatter(formatter)
    logger_setup.addHandler(ch)

    return logger_setup


logger = setup_logger()


def normalize(text: str):
    """
    Takes any serbian (cyrilic, latin) and converts it to lower-case ASCII.
    This is what user input will be checked against.
    """
    out = ''
    for c in text:
        if c.upper() in serbian_to_ascii:
            out += serbian_to_ascii[c.upper()]
        else:
            out += c
    return out.lower()


def get_solutions(trello: TrelloApi, trello_question: Dict) -> List[str]:
    """
    Gets set of solutions for a given question
    """
    # Solutions are set of questions name plus all entries in optional Trello checklist
    solutions = {trello_question['name']}
    if len(trello_question['idChecklists']) == 1:
        trello_checklist = trello.checklists.get(trello_question['idChecklists'][0])
        solutions = solutions.union([s['name'] for s in trello_checklist['checkItems']])
    return [normalize(s) for s in solutions]


def get_image(trello: TrelloApi, trello_list: Dict, trello_question: Dict,
              assets_dir: str, force_overwrite: bool) -> Tuple[str, str]:
    """
    Gets image for a given questions and persist it to disk
    """
    # Find attachment and figure out what it should be named
    trello_attachment = trello.cards.get_attachment_idAttachment(
        trello_question['idAttachmentCover'], trello_question['id'])
    logger.info(f"\tFetching image for question {trello_question['name']}")
    attachment_url = trello_attachment['url']
    image_filename = '{0}-{1}.{2}'.format(
        normalize(trello_list['name']),
        hashlib.md5(trello_question['name'].encode('utf-8')).hexdigest(),
        attachment_url[attachment_url.rindex('.') + 1:])
    image_path = assets_dir + 'images' + os.path.sep + image_filename

    # Download attachment image only if it doesn't exist, size do not match or
    # it is newer than the one in filesystem (due to git, this will be partially valid, but this is best effort)
    if force_overwrite or not os.path.exists(image_path) or \
            os.path.getsize(image_path) != trello_attachment['bytes'] or \
            os.path.getmtime(image_path) < dateutil.parser.parse(trello_attachment['date']).timestamp():
        response = requests.get(attachment_url, stream=True)
        if response.status_code != 200:
            raise Exception(f"Failure fetching attachment for card {trello_question['name']}")
        with open(image_path, 'wb') as fd:
            for chunk in response.iter_content(chunk_size=1024):
                fd.write(chunk)
    return image_path, image_filename


def process_image(trello_question: Dict, image_path: str):
    """
    Currently, just spits any warnings on image~`~~~~
    """
    # Print some warning about image quality
    image = Image.open(image_path)

    if image.width < 720:
        logger.warning(f"Image for questions {trello_question['name']} has too small width")
    if image.height < 720:
        logger.warning(f"Image for questions {trello_question['name']} has too small height")
    if image.width / image.height > 2 or image.height / image.width > 2:
        logger.warning(f"Image for questions {trello_question['name']} has too narrow aspect ratio")
    # TODO: optimize images here, otherwise storage will explode
    # TODO: should we remove EXIF here too?
    return

def optimize_image(trello_question: Dict, image_path: str):
    """
    Resize, optimize and generate thumbnail, than delete original. Returns path to new image and thumbnail
    """
    size = (720, 720)
    thumb_size = (300, 300)
    out_file = image_path.replace(".png", ".jpg")
    out_thumb = out_file.replace(".jpg", ".thumb.jpg")

    image = Image.open(image_path)
    rgb = image.convert('RGB')
    rgb.thumbnail(size, Image.ANTIALIAS)
    rgb.save(out_file, optimize=True, quality=95)
    rgb.thumbnail(thumb_size, Image.ANTIALIAS)
    rgb.save(out_thumb, optimize=True, quality=95)
    os.remove(image_path)
    return out_file, out_thumb


def populate_questions(trello: TrelloApi, trello_list: Dict, assets_dir: str, force_overwrite: bool) -> List:
    """
    Given one list, populate all questions from that list, save images and return list of all questions
    """
    trello_questions = trello.lists.get_card(trello_list['id'])
    logger.info(f"\tFound {len(trello_questions)} questions for this list")
    trello_questions = [q for q in trello_questions if not q['closed']]
    questions = []

    # Some basic checks of returned questions
    level_colors = {'Lako': 0, 'Srednje': 1, 'Teško': 2, 'Najteže': 3}
    if any(q for q in trello_questions if len(q['idLabels']) == 0):
        raise Exception(f"Some card from list {trello_list['name']} do not have label")
    if any(q for q in trello_questions if len(q['idLabels']) > 1):
        raise Exception(f"Some card from list {trello_list['name']} have more than one label")
    if any(q for q in trello_questions if q['labels'][0]['name'] not in level_colors):
        raise Exception(f"Some card from list {trello_list['name']} have label that is not known difficulty label")
    if any(q for q in trello_questions if q['idAttachmentCover'] is None):
        raise Exception(f"Some card from list {trello_list['name']} do not have cover image")
    if any(q for q in trello_questions if len(q['idChecklists']) > 1):
        raise Exception(f"Some card from list {trello_list['name']} have multiple checklists, not supported")
    # Stable sort of questions inside list
    # (keep Trello order, but first sort by difficulty, in case it is not sorted by difficulty in Trello itself)
    sorted(trello_questions, key=lambda q: (level_colors[q['labels'][0]['name']], q['pos']))

    for question_id, trello_question in enumerate(trello_questions):
        solutions = get_solutions(trello, trello_question)
        image_path, image_filename = get_image(trello, trello_list, trello_question, assets_dir, force_overwrite)
        process_image(trello_question, image_path)
        image_path, image_thumb = optimize_image(trello_question, image_path)

        questions.append({
            # ID should be "stable", it should not be incremental
            'id': hashlib.md5(normalize(trello_question['name']).encode('utf-8')).hexdigest(),
            'order': question_id + 1,
            'title': '',  # TODO: should be removed, no need for this?
            'image':  image_path,
            'thumb': image_thumb,
            'solutions': solutions
        })

    return questions


def populate_levels(trello: TrelloApi, assets_dir: str, force_overwrite: bool) -> List[Dict]:
    """
    Iterate for all levels are returns list of all levels populated with questions
    """
    output_json = []
    trello_lists = trello.boards.get_list(LIST_ID)
    sorted(trello_lists, key=lambda k: k['pos'])
    for list_id, trello_list in enumerate(trello_lists):
        logger.info(f"Processing list {trello_list['name']}")
        if trello_list['closed']:
            continue
        list_json = {
            'id': trello_list['id'],
            'order': list_id + 1,
            'name': trello_list['name'],
            'questions': populate_questions(trello, trello_list, assets_dir, force_overwrite)}
        output_json.append(list_json)
    return output_json


def main():
    parser = argparse.ArgumentParser(
        description='Level assembler - assembles levels from Trello')
    parser.add_argument('--assets-dir', default='assets',
                        help='Directory to place assets. Default value is "assets"')
    parser.add_argument('--trello-auth-file', default='TRELLO_AUTH',
                        help='Name of file containing auth for Trello. Default value is "TRELLO_AUTH"')
    parser.add_argument('-f', '--force-overwrite', action='store_true',
                        help='Force overwrite of levels.json and all images, even though they are present.')
    args = parser.parse_args()

    # Check for quick bailout
    if not args.assets_dir.endswith(os.path.sep):
        args.assets_dir = args.assets_dir + os.path.sep
    output_json_path = args.assets_dir + 'levels.json'
    if os.path.exists("../" + output_json_path) and not args.force_overwrite:
        logger.info('File levels.json already exists, bailing out')
        return

    if not os.path.exists(args.trello_auth_file):
        logger.error(f"""
        Missing {args.trello_auth_file} file. Create it and place api key obtained from https://trello.com/app-key
        on first line. Then go to
        https://trello.com/1/authorize?expiration=1day&name=MyPersonalToken&scope=read&response_type=token&key={{YourAPIKey}}
        and place token in second line""")
        raise Exception('Missing Trello auth file, check above for details')
    with open(args.trello_auth_file) as trello_auth_file:
        api_key = trello_auth_file.readline().strip()
        token = trello_auth_file.readline().strip()
    trello = TrelloApi(api_key, token)

    # Go project root
    os.chdir("../")

    output_json = populate_levels(trello, args.assets_dir, args.force_overwrite)

    with open(output_json_path, 'w', encoding='utf-8') as output_json_file:
        json.dump(output_json, output_json_file, indent=2, ensure_ascii=False)


if __name__ == '__main__':
    main()
