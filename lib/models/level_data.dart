import 'QuestionData.dart';

/// Generated with https://javiercbk.github.io/json_to_dart/

class LevelData {
  String id;
  int order;
  String name;
  List<QuestionData> questions;
  final int requiresPct = 50;

  LevelData({this.id, this.order, this.name, this.questions});

  LevelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    order = json['order'];
    name = json['name'];
    if (json['questions'] != null) {
      questions = new List<QuestionData>();
      json['questions'].forEach((v) {
        questions.add(new QuestionData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order'] = this.order;
    data['name'] = this.name;
    if (this.questions != null) {
      data['questions'] = this.questions.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
