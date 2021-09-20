import 'package:flutter/material.dart';
import 'package:izi_web/data/keyboard_style/keyboard_styles.dart';


class KeyBoard extends StatefulWidget {
  final Function onPressed;
  final Function backSpace;
  final Function clear;
  final KeyboardStyles keyboardStyles;

  const KeyBoard({required this.keyboardStyles ,required this.onPressed, required this.backSpace,required this.clear, Key? key}) : super(key: key);

  @override
  _KeyBoardState createState() => _KeyBoardState();
}

class _KeyBoardState extends State<KeyBoard> {
  final List<String> _keys = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "",
    "0",
    "-"
  ];


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      width: 400,
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 3,
        children: List.generate(_keys.length, (index) {
          return Center(
            child: _getButton("${_keys[index]}"),
          );
        }),
      ),
    );
  }

  Widget _getButton(String v) => v.isNotEmpty && v != "-"
      ? Padding(
    padding: const EdgeInsets.all(16.0),
    child: ElevatedButton(
        style: _getKeyboardStyle(),
        onPressed: () => widget.onPressed(v),
        child: Text(v, style: Theme.of(context).textTheme.headline2)),
  )
      : v == "-"
      ? InkWell(
    child: Opacity(
      opacity: .7,
      child: Icon(
        Icons.backspace_sharp,
        color: Theme.of(context).textSelectionColor,
        size: 30,
      ),
    ),
    onTap: () => widget.backSpace(),
    onLongPress: () => widget.clear,
  )
      : Container();


  ButtonStyle? _getKeyboardStyle(){
    switch(widget.keyboardStyles) {
      case KeyboardStyles.ROUND_BORDERED:
        return ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                Theme.of(context).backgroundColor),
            minimumSize: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.disabled)) {
                return Size(double.infinity, double.infinity);
              }
              return Size(double.infinity, double.infinity);
            }),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100000),
                    side: BorderSide(
                        color: Theme.of(context).textSelectionColor))));
      case KeyboardStyles.NONE:
        return ButtonStyle(
            elevation: MaterialStateProperty.all<double>(0),
            backgroundColor: MaterialStateProperty.all(
                Theme.of(context).backgroundColor),
            minimumSize: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.disabled)) {
                return Size(double.infinity, double.infinity);
              }
              return Size(double.infinity, double.infinity);
            }));
      default: ButtonStyle(
          shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          minimumSize: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return Size(double.infinity, double.infinity);
            }
            return Size(double.infinity, double.infinity);
          }),
      );
    }
  }


}

