import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streamlink_player/widgets/streams_list.dart';
import 'package:streamlink_player/widgets/controll_bar.dart';
import 'package:streamlink_player/services/player.dart';
import 'package:streamlink_player/models.dart';
import 'package:streamlink_player/services/database.dart';

// const kUrlMP3 = 'https://stream.radioparadise.com/mp3-320';
// const kUrlAAC = '';
// const kUrlFLAC = 'https://stream.radioparadise.com/flac';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final player = Player();
  final db = DataProvider().getAll();

  @override
  void initState() {
    print('Data loading!\n$db');
    db.forEach((element) => Provider.of<StationsData>(context, listen: false)
        .addStream(title: element['title'], url: element['url']));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              Expanded(
                child: StreamsList(player),
              ),
              ControllBar(player),
            ],
          ),
        ),
      ),
    );
  }
}
