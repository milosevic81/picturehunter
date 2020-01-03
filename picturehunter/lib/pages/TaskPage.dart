import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:picturehunter/pages/QuestionPage.dart';

import '../Repo.dart';

class TaskPage extends StatelessWidget {
  static const routeName = '/task';

  @override
  Widget build(BuildContext context) {

    final TaskArgs args = ModalRoute.of(context).settings.arguments;
    final level = Repo.level(args.levelId);

    return Scaffold(
      appBar: AppBar(
        title: Text(level["title"]),
      ),
      body: Center(
        child: GridView.count(
          crossAxisCount: 2,
          children: (level["questions"] as List).map((question) => Center(
                    child: RaisedButton(
                      child: Text('Question: ${question["id"]}'),
                      onPressed: () {
                        Navigator.pushNamed(context, QuestionPage.routeName,
                            arguments: QuestionArgs(level["id"], question["id"]));
                      },
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}

class TaskArgs {
  final int levelId;

  TaskArgs(this.levelId);
}
