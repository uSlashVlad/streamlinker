import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streamlink_player/screens/main_screen.dart';
import 'package:streamlink_player/models.dart';
import 'package:streamlink_player/services/database.dart';

void main() async {
  await DataProvider().init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StationsData(),
      child: MaterialApp(
        title: 'Stream Linker',
        theme: ThemeData.dark(),
        home: MainScreen(),
      ),
    );
  }
}
