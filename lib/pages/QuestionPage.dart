import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Repo.dart';

class QuestionPage extends StatelessWidget {
  static const routeName = '/question';

  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final QuestionArgs args = ModalRoute.of(context).settings.arguments;
    final question = Repo.question(args.levelId, args.taskId);

    return Scaffold(
      appBar: AppBar(
        title: Text(question["title"]),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: RaisedButton(
            child: Column(
              children: <Widget>[
                CachedNetworkImage(
                    placeholder: (context, url) => CircularProgressIndicator(),
                    imageUrl: question["image"]),
                TextField(
                  controller: textController,
                ),
              ],
            ),
            onPressed: () {
              // Navigate to second route when tapped.
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(textController.text),
              );
            },
          );
        },
        tooltip: 'Check answer',
        child: Icon(Icons.text_fields),
      ),
    );
  }
}

class QuestionArgs {
  final int levelId;
  final int taskId;

  QuestionArgs(this.levelId, this.taskId);
}
