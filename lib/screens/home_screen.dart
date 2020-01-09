import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'info_screen.dart';
import 'level_list_screen.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("SLIKOLOVAC", textScaleFactor: 4),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
              child: ButtonTheme(
                minWidth: 300,
                height: 60,
                child: RaisedButton(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Text(
                    'Start',
                    style: TextStyle(color: Colors.white, fontSize: 32),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, LevelListScreen.routeName);
                  },
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: ButtonTheme(
                minWidth: 300,
                height: 60,
                child: RaisedButton(
                  child: Text(
                    'Info',
                    style: TextStyle(color: Colors.white, fontSize: 32),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, InfoScreen.routeName);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
