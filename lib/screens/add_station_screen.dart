import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:streamlink_player/models.dart';

class AddStationScreen extends StatefulWidget {
  @override
  _AddStationScreenState createState() => _AddStationScreenState();
}

class _AddStationScreenState extends State<AddStationScreen> {
  final titleFieldController = TextEditingController();
  final urlFieldController = TextEditingController();

  @override
  void dispose() {
    titleFieldController.dispose();
    urlFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Add Stream',
            style: TextStyle(fontSize: 25),
          ),
          SizedBox(height: 10),
          TextField(
            textAlign: TextAlign.center,
            decoration: InputDecoration(hintText: 'Stream title'),
            controller: titleFieldController,
          ),
          SizedBox(height: 7.5),
          TextField(
            textAlign: TextAlign.center,
            decoration: InputDecoration(hintText: 'Stream url'),
            controller: urlFieldController,
          ),
          SizedBox(height: 10),
          FlatButton(
              onPressed: () {
                if (titleFieldController.text != null &&
                    titleFieldController.text != '' &&
                    urlFieldController.text != null &&
                    urlFieldController.text != '') {
                  final res = Provider.of<StationsData>(context, listen: false)
                      .addStream(
                    title: titleFieldController.text,
                    url: urlFieldController.text,
                  );
                  if (res) {
                    Navigator.pop(context);
                  } else {
                    Toast.show(
                        'Stream with this url is already exist', context);
                  }
                } else {
                  Toast.show('Some fields don\'t filled', context);
                }
              },
              child: Text('Add'))
        ],
      ),
    );
  }
}
