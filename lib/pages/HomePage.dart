import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:picturehunter/pages/InfoPage.dart';
import 'package:picturehunter/pages/LevelPage.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text('Start'),
              onPressed: () {
                Navigator.pushNamed(context, LevelPage.routeName);
              },
            ),
            RaisedButton(
              child: Text('Info'),
              onPressed: () {
                Navigator.pushNamed(context, InfoPage.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
