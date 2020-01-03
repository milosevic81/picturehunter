class Repo {
  static const List _levels = [
    {
      "id": 1,
      "name": "Voce",
      "title": "Pogodi voce",
      "questions": [
        {
          "id": 1,
          "title": "Koje je voce na slici",
          "image":
              "https://trello-attachments.s3.amazonaws.com/5e08a8e77b177712fb6fbf40/460x360/8d5d2e5467a784e80d28ad05581f9183/slika.png",
          "solutions": ["jagode"]
        },
        {
          "id": 2,
          "title": "Koje je voce na slici",
          "image":
              "https://trello-attachments.s3.amazonaws.com/5e08a84f4faf0c7154736597/5e08a9052260492d4978b61a/02bc1b6280b38f76e7aa5097e3107acb/slika.png",
          "solutions": ["lubenica"]
        },
        {
          "id": 3,
          "title": "Koje je voce na slici",
          "image":
          "https://trello-attachments.s3.amazonaws.com/5e08a84f4faf0c7154736597/5e0f3dfe98812f84270d5462/ce4e034837df78179de0ac5aa5cfdb3b/image.png",
          "solutions": ["grozdje"]
        }
      ]
    },
    {
      "id": 2,
      "name": "Povrce",
      "title": "Pogodi povrce",
      "questions": [
        {
          "id": 1,
          "title": "Koje je povrce na slici",
          "image":
              "https://trello-attachments.s3.amazonaws.com/5e08a84f4faf0c7154736597/5e0e4268fedc8208cea6fa40/8348b1f00bc2a053cf49f7566902c627/paradajz.jpg",
          "solutions": ["paradajz"]
        },
        {
          "id": 2,
          "title": "Koje je povrce na slici",
          "image":
              "https://trello-attachments.s3.amazonaws.com/5e08a84f4faf0c7154736597/5e0f49428fd2d68ee58463dd/0dd542f2cdfb277bffaa4e70cdd3f38c/image.png",
          "solutions": ["paprika"]
        }
      ]
    }
  ];

  static List allLevels() => _levels;

  static Map level(int id) => _levels.firstWhere((x) => x["id"] == id);

  static question(int levelId, int questionId) =>
      level(levelId)["questions"].firstWhere((x) => x["id"] == questionId);
}