import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streamlink_player/models.dart';
import 'package:streamlink_player/services/player.dart';

class StreamCard extends StatelessWidget {
  StreamCard(this.player, {this.title, this.url, this.isActive});

  final Player player;
  final String title;
  final String url;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        player.toggleSound(context, url);
      },
      onLongPress: () {
        Provider.of<StationsData>(context, listen: false).delStream(url);
      },
      child: Container(
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[700], width: 1.5),
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 30,
              ),
            ),
            Text(
              url,
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 20,
                color: (isActive) ? Colors.blue : theme.cardTheme.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
