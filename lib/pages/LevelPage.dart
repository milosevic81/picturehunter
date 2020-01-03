import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Repo.dart';
import 'TaskPage.dart';

class LevelPage extends StatelessWidget {
  static const routeName = '/level';

  Scaffold getScaffold(BuildContext context, AsyncSnapshot<List> snapshot) {
    var data = [];
    if (snapshot.hasData) {
      data = snapshot.data;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Select level'),
      ),
      body: GridView.count(
        // Create a grid with 2 columns. If you change the scrollDirection to
        // horizontal, this produces 2 rows.
          crossAxisCount: 2,
          // Generate 100 widgets that display their index in the List.
          children: data
          .map((level) => Center(
            child: RaisedButton(
              child: Text('Level: ${level["name"]}'),
              onPressed: () {
                Navigator.pushNamed(context, TaskPage.routeName,
                    arguments: TaskArgs(level["id"]));
                },
            ),
          ))
          .toList(),
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: Repo.allLevels(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        return getScaffold(context, snapshot);
      }
    );
  }
}
