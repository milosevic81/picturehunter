import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:picturehunter/screens/info_screen.dart';
import 'package:picturehunter/widgets/fancy_background.dart';
import 'package:picturehunter/widgets/menu_button.dart';

import 'level_list_screen.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          FancyBackground(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "СЛИКОЛОВАЦ",
                textScaleFactor: 3,
                style: TextStyle(color: Colors.white),
              ),
              Container(height: 20),
              MenuButton(text: "ПОЧНИ ИГРУ", route: LevelListScreen.routeName),
              Container(height: 20),
              MenuButton(text: "ИНФОРМАЦИЈЕ", route: InfoScreen.routeName),
            ],
          ),
        ],
      ),
    );
  }
}
