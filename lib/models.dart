import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:streamlink_player/services/database.dart';

class StreamStation {
  StreamStation(this.title, this.url);

  String title;
  String url;
}

class StationsData extends ChangeNotifier {
  List<StreamStation> _streams = [];

  UnmodifiableListView<StreamStation> get streams {
    return UnmodifiableListView(_streams);
  }

  bool addStream({@required String title, @required String url}) {
    for (int i = 0; i < streamsCount; i++) {
      if (url == _streams[i].url) return false;
    }
    _streams.add(StreamStation(title, url));
    notifyListeners();
    return true;
  }

  bool delStream(String url) {
    for (int i = 0; i < streamsCount; i++) {
      if (_streams[i].url == url) {
        _streams.removeAt(i);
        notifyListeners();
        DataProvider().remove(i);
        return true;
      }
    }
    return false;
  }

  int get streamsCount => _streams.length;

  String _activeUrl;
  String get activeUrl => _activeUrl;

  set activeUrl(String url) {
    _activeUrl = url;
    notifyListeners();
  }

  String _songTitle;
  String _songAuthor;
  String get songTitle => _songTitle;
  String get songAuthor => _songAuthor;
  void setSongAttributes({@required String title, @required String author}) {
    _songTitle = title;
    _songAuthor = author;
    notifyListeners();
  }
}
