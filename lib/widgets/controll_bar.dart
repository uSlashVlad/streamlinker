import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:streamlink_player/models.dart';
import 'package:streamlink_player/screens/add_station_screen.dart';
import 'package:streamlink_player/services/player.dart';

class ControllBar extends StatelessWidget {
  const ControllBar(this.player);
  final Player player;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, StationsData value, child) {
        return Container(
          color: Colors.grey[800],
          padding: EdgeInsets.symmetric(horizontal: 7.5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  (player.state == AudioPlaybackState.paused)
                      ? Icons.play_circle_filled
                      : (player.state == AudioPlaybackState.playing)
                          ? Icons.pause_circle_filled
                          : Icons.stop,
                ),
                iconSize: 50,
                onPressed: (player.state == AudioPlaybackState.paused ||
                        player.state == AudioPlaybackState.playing)
                    ? () {
                        player.toggleSound(context, player.streamUrl);
                      }
                    : null,
              ),
              SizedBox(width: 10),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 10),
                    Text(
                      (value.songTitle != null)
                          ? value.songTitle
                          : '<No title meta>',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      (value.songAuthor != null)
                          ? value.songAuthor
                          : '<No author meta>',
                      style: TextStyle(fontSize: 13.5),
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              ),
              SizedBox(width: 15),
              IconButton(
                  icon: Icon(
                    Icons.add_circle,
                  ),
                  iconSize: 50,
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: AddStationScreen(),
                        ),
                      ),
                    );
                  })
            ],
          ),
        );
      },
    );
  }
}
