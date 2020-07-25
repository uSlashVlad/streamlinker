import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter_media_notification/flutter_media_notification.dart';
import 'package:provider/provider.dart';
import 'package:streamlink_player/models.dart';

class Player {
  Player() {
    // MediaNotification.setListener('play', playSound);
    // MediaNotification.setListener('pause', pauseSound);
  }
  final audioPlayer = AudioPlayer();

  AudioPlaybackState get state {
    return audioPlayer.playbackState;
  }

  bool get isPlaying {
    return state == AudioPlaybackState.playing;
  }

  bool canBeUsed = true;
  String streamUrl;

  void printU(String url) {
    print(url);
  }

  Future<void> toggleSound(BuildContext context, String url) async {
    print('$url > $streamUrl ($isPlaying)');
    if (canBeUsed) {
      canBeUsed = false;
      if (url == streamUrl) {
        if (isPlaying) {
          print('PAUSE');
          await audioPlayer.pause();
        } else {
          print('UNPAUSE');
          audioPlayer.play();
        }
      } else if (streamUrl == null) {
        print('PLAY');
        if (!await playSound(context, url)) url = null;
      } else {
        print('REPLAY');
        await audioPlayer.stop();
        if (!await playSound(context, url)) url = null;
      }

      streamUrl = url;
      Provider.of<StationsData>(context, listen: false).activeUrl = url;
      await updateNotification();
      print('Ok');
      canBeUsed = true;
    } else {
      print('Sorry, No');
    }
  }

  Future<bool> playSound(BuildContext context, String url) async {
    try {
      await audioPlayer.setUrl(url);
      audioPlayer.play();
    } catch (e, s) {
      print('E R R O R while playing stream:\n$e\nStack:\n$s');
      return false;
    }
    audioPlayer.icyMetadataStream.listen((meta) {
      Provider.of<StationsData>(context, listen: false).setSongAttributes(
        title: meta.info.title,
        author: meta.headers.name,
      );
    });
    await updateNotification();
    return true;
  }

  Future<void> pauseSound() async {
    updateNotification();
  }

  Future<void> stopSound() async {
    updateNotification();
  }

  Future<void> updateNotification() async {
    await MediaNotification.showNotification(
      title: streamUrl,
      author: 'Streamlink',
      isPlaying: isPlaying,
    );
  }
}
