import 'package:picturehunter/models/question_state.dart';

class Question {
  String id;
  int order;
  String title;
  String image;
  String thumb;
  List<String> solutions;
  QuestionState state;

  Question(
      {this.id,
      this.order,
      this.title,
      this.image,
      this.thumb,
      this.solutions});

  Question.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    order = json['order'];
    title = json['title'];
    image = json['image'];
    thumb = json['thumb'];
    solutions = json['solutions'].cast<String>();
  }
}
