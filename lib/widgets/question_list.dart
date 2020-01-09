import 'package:flutter/cupertino.dart';
import 'package:picturehunter/models/question.dart';
import 'package:picturehunter/widgets/question_item.dart';

class QuestionList extends StatelessWidget {
  final List<Question> questions;

  QuestionList({@required this.questions});

  @override
  Widget build(BuildContext context) {
    return GridView.count(crossAxisCount: 3, children: getChildrenQuestions());
  }

  List<Widget> getChildrenQuestions() {
    return questions
        .map((question) => QuestionItem(question: question))
        .toList();
  }
}
