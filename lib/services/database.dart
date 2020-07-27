import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DataProvider {
  static final DataProvider _singleton = DataProvider._internal();
  factory DataProvider() {
    return _singleton;
  }
  DataProvider._internal();

  Box box;

  Future<void> init() async {
    await Hive.initFlutter();
    box = await Hive.openBox('dataBox');
  }

  List<Map> getAll() {
    if (box == null) return List();
    List<Map> res = List<Map>();
    for (int i = 0; i < box.length; i++) {
      res.add(box.getAt(i));
    }
    return res;
  }

  Future<void> remove(int index) => box.deleteAt(index);

  Future<void> add(Map data) => box.add(data);
}
