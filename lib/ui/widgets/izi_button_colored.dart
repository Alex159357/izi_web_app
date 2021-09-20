import 'package:flutter/material.dart';

class IziButtonColored extends StatefulWidget {
  final String text;
  final Function onClick;

  const IziButtonColored({Key? key, required this.text, required this.onClick})
      : super(key: key);

  @override
  _IxState createState() => _IxState(onClick);
}

class _IxState extends State<IziButtonColored> {

  final Function onClick;


  _IxState(this.onClick);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Theme.of(context).accentColor),
              minimumSize: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.disabled)) {
                  return Size(double.infinity, 50);
                }
                return Size(double.infinity, 50);
              }),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Theme.of(context).accentColor)))),
          onPressed: (){
            onClick();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.text,
              style: TextStyle(fontSize: 28),
            ),
          )),
    );
  }
}
