import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:picturehunter/screens/home_screen.dart';
import 'package:picturehunter/screens/info_screen.dart';
import 'package:picturehunter/screens/level_list_screen.dart';
import 'package:picturehunter/screens/question_list_screen.dart';
import 'package:picturehunter/screens/question_screen.dart';
import 'package:picturehunter/state/levels_model.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Load assets
  await LevelsModel.loadAsset();
  // Lock portrait orientation
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => LevelsModel(),
        child: MaterialApp(
          title: 'Сликоловац',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: '/',
          routes: {
            HomeScreen.routeName: (BuildContext context) => HomeScreen(),
            InfoScreen.routeName: (BuildContext context) => InfoScreen(),
            LevelListScreen.routeName: (BuildContext context) =>
                LevelListScreen(),
            QuestionListScreen.routeName: (BuildContext context) =>
                QuestionListScreen(),
            QuestionScreen.routeName: (BuildContext context) =>
                QuestionScreen(),
          },
//      navigatorObservers: [
//        FirebaseAnalyticsObserver(analytics: analytics),
//      ],
        ));
  }
}
