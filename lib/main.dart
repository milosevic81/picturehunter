import 'package:flutter/material.dart';
import 'package:picturehunter/pages/HomePage.dart';
import 'package:picturehunter/pages/InfoPage.dart';
import 'package:picturehunter/pages/LevelPage.dart';
import 'package:picturehunter/pages/QuestionPage.dart';
import 'package:picturehunter/pages/TaskPage.dart';

import 'Repo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Repo.loadAsset();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Picture Hunter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        HomePage.routeName: (BuildContext context) => HomePage(),
        InfoPage.routeName: (BuildContext context) => InfoPage(),
        LevelPage.routeName: (BuildContext context) => LevelPage(),
        TaskPage.routeName: (BuildContext context) => TaskPage(),
        QuestionPage.routeName: (BuildContext context) => QuestionPage(),
      },
//      navigatorObservers: [
//        FirebaseAnalyticsObserver(analytics: analytics),
//      ],
    );
  }
}
