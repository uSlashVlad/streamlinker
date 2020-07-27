import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'stream_card.dart';
import 'package:streamlink_player/models.dart';
import 'package:streamlink_player/services/player.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StreamsList extends StatelessWidget {
  StreamsList(this.player);
  final Player player;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, StationsData value, child) {
        if (value.streamsCount != 0)
          return ListView.builder(
            itemBuilder: (context, i) {
              return StreamCard(
                player,
                title: value.streams[i].title,
                url: value.streams[i].url,
                isActive: (value.streams[i].url == value.activeUrl) &
                    player.isPlaying,
              );
            },
            itemCount: value.streamsCount,
          );
        else
          return Column(
            children: <Widget>[
              SizedBox(height: 20),
              Icon(
                FontAwesomeIcons.frown,
                size: 85,
                color: Colors.grey[600],
              ),
              SizedBox(height: 15),
              Text(
                'Oh, there is no streams\nAdd them using button below',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 20,
                ),
              )
            ],
          );
      },
    );
  }
}
