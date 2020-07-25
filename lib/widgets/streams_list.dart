import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'stream_card.dart';
import 'package:streamlink_player/models.dart';
import 'package:streamlink_player/services/player.dart';

class StreamsList extends StatelessWidget {
  StreamsList(this.player);
  final Player player;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, StationsData value, child) {
        return ListView.builder(
          itemBuilder: (context, i) {
            return StreamCard(
              player,
              title: value.streams[i].title,
              url: value.streams[i].url,
              isActive: (value.streams[i].url == value.activeUrl) & player.isPlaying,
            );
          },
          itemCount: value.streamsCount,
        );
      },
    );
  }
}
