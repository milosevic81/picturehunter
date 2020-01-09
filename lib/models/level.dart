import 'package:picturehunter/models/level_state.dart';
import 'package:picturehunter/models/question.dart';

/// Generated with https://javiercbk.github.io/json_to_dart/

class Level {
  String id;
  int order;
  String name;
  List<Question> questions;
  final int requiresPct = 50;
  LevelState state;

  Level({this.id, this.order, this.name, this.questions});

  Level.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    order = json['order'];
    name = json['name'];
    if (json['questions'] != null) {
      questions = new List<Question>();
      json['questions'].forEach((v) {
        questions.add(new Question.fromJson(v));
      });
    }
  }
}
