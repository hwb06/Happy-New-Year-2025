import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_newyearapp25/view_models/countdown_viewmodel.dart';
import 'package:flutter_countdown_newyearapp25/views/countdown_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_countdown_newyearapp25/view_models/countdown_viewmodel.dart';
import 'views/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CountdownViewModel(),
      child: MaterialApp(
        title: 'New Year Countdown',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SplashScreen(),
      ),
    );
  }
}