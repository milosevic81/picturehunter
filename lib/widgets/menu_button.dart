import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  final String text;
  final String route;

  MenuButton({@required this.text, @required this.route});

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: 300,
      height: 60,
      child: RaisedButton(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 32),
        ),
        onPressed: () {
          Navigator.pushNamed(context, route);
        },
      ),
    );
  }
}
