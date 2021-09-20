
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:izi_web/ui/utils/dialog_state.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'izi_button_colored.dart';
import 'theme_switcher.dart';

class LoginForm extends DialogState {
  final Function onLoginClicked;

  const LoginForm({required this.onLoginClicked, Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final phoneEnter = UniqueKey();
  final passwordEnter = UniqueKey();
  var phoneController = TextEditingController();
  String _mobile = "";
  var maskFormatter = MaskTextInputFormatter(
      mask: '+380 0## ###-##-##', filter: {"#": RegExp(r'[0-9]')});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 400),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(child: _getForm()),
      ),
    );
  }

  Widget _getForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: themeSwitcher(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.phone_android,
                ),
                hintText: "+380 (0",
                filled: true,
                fillColor: Theme.of(context).cardColor,
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 2, color: Theme.of(context).accentColor),
                    borderRadius: BorderRadius.circular(10)),
              ),
              keyboardType: TextInputType.phone,
              inputFormatters: [maskFormatter],
              controller: phoneController,
              validator: (value) {
                if (value!.length == 0) {
                  return 'Please enter mobile number';
                } else if (value.length != 18) {
                  return 'Please enter valid mobile number';
                }
              },
              onSaved: (String? val) {
                _mobile = val!;
              },
            ),
          ),
          IziButtonColored(
            text: "Login",
            onClick: () {
              if (_formKey.currentState!.validate()) {
                widget.onLoginClicked(phoneController.value.text);
              }
            },
          )
        ],
      ),
    );
  }
}
