import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogState extends StatefulWidget {



  Future<void> showAllertDialog(BuildContext context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text('Loading...'),
            content: Text('Hey! I am Coflutter!'),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    _dismissDialog(context);
                  },
                  child: Text('Close')),
              TextButton(
                onPressed: () {
                  print('HelloWorld!');
                  _dismissDialog(context);
                },
                child: Text('HelloWorld!'),
              )
            ],
          );
        });
  }

  _dismissDialog(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  State<StatefulWidget> createState() {
    throw UnimplementedError();
  }

  const DialogState({Key? key}) : super(key: key);
}
