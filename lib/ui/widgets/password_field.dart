
import 'package:flutter/material.dart';
import 'package:izi_web/data/keyboard_style/keyboard_styles.dart';
import 'package:izi_web/data/password_form_state/password_state.dart';
import 'package:izi_web/ui/utils/auth_state.dart';
import 'package:lottie/lottie.dart';

import 'izi_button_colored.dart';
import 'keyboard.dart';

class PasswordField extends AuthState {
  final Function onPasswordSuccess;

  const PasswordField({required this.onPasswordSuccess, Key? key})
      : super(key: key);

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  static String password = "";
  static PasswordState _passwordState = PasswordState.WAIT;
  List<String> _keys = [
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
    return AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: _passwordState == PasswordState.LOADING
            ? CircularProgressIndicator()
            : _passwordState == PasswordState.WAIT
                ? _getBody
                : _passwordState == PasswordState.SUCCESS
                    ? Container(
                        child: Lottie.asset('anim/lot_sun_ok.json'),
                      )
                    : Container(
                        child: Column(
                          children: [
                            Lottie.asset('anim/lot_sun_error.json'),
                            Container(
                              width: 300,
                              child: IziButtonColored(text: "re try", onClick: (){
                                setState(() {
                                  _passwordState = PasswordState.WAIT;
                                });
                              }),
                            )
                          ],
                        ),
                      ));
  }

  Widget get _getBody => Container(
        margin: EdgeInsets.only(top: 40),
        child: Column(
          children: [
            SizedBox(
              width: 400,
              child: Container(
                margin: EdgeInsets.only(bottom: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _getTextField(_getTextFieldDecoration(password.length > 0)),
                    _getTextField(_getTextFieldDecoration(password.length > 1)),
                    _getTextField(_getTextFieldDecoration(password.length > 2)),
                    _getTextField(_getTextFieldDecoration(password.length > 3)),
                  ],
                ),
              ),
            ),
            Container(
              height: 600,
              width: 400,
              child: KeyBoard(keyboardStyles: KeyboardStyles.ROUND_BORDERED, onPressed: _onPressed, backSpace: _backSpace, clear: (){setState(() {
                password = "";
              });},)
            )
          ],
        ),
      );

  Widget _getTextField(BoxDecoration decoration) => Container(
      width: 35,
      height: 35,
      margin: EdgeInsets.only(left: 10, right: 10),
      decoration: decoration);

  BoxDecoration _getTextFieldDecoration(bool active) => BoxDecoration(
      color: !active
          ? Theme.of(context).backgroundColor
          : Theme.of(context).accentColor,
      shape: BoxShape.circle,
      border: Border.all(width: 3, color: Theme.of(context).accentColor));

  void _onPressed(String v) {
    if (password.length <= 4)
      setState(() {
        password += v;
      });
    if (password.length == 4)
      setState(() {
        Future.delayed(Duration(milliseconds: 5)).then((value) {
          _passwordState = PasswordState.LOADING;
          _checkPassword();
        });
      });
  }

  Future<void> _checkPassword() async {
    widget.checkPassword(password).then((value) {
      setState(() {
        password = "";
        _passwordState = value;
        if (value == PasswordState.SUCCESS) widget.onPasswordSuccess();
      });
    });
  }

  _backSpace() {
    setState(() {
      password = password.substring(0, password.length - 1);
    });
  }
}
