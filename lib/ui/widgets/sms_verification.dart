
import 'package:flutter/material.dart';
import 'package:izi_web/data/keyboard_style/keyboard_styles.dart';
import 'package:izi_web/data/sms_verify_states/sms_verify_states.dart';
import 'package:izi_web/ui/utils/auth_state.dart';
import 'package:sms_autofill/sms_autofill.dart';

import 'keyboard.dart';

class SmsVerification extends AuthState {
  final Function onCodeSuccess;
  const SmsVerification({Key? key, required this.onCodeSuccess}) : super(key: key);

  @override
  _SmsVerificationState createState() => _SmsVerificationState();
}

class _SmsVerificationState extends State<SmsVerification> {
  static String _code = "";
  static SmsVerifyStates _smsVerifyStates = SmsVerifyStates.EDIT;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40, bottom: 40),
      width: 400,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        child:
        _smsVerifyStates == SmsVerifyStates.EDIT || _smsVerifyStates == SmsVerifyStates.ERROR
        ?Column(
          children: [
            PinFieldAutoFill(
              decoration: UnderlineDecoration(
                                textStyle: Theme.of(context).textTheme.headline2,
                                colorBuilder: FixedColorBuilder(Theme.of(context).textTheme.headline2!.color!),
                              ),
              currentCode: _code,
              onCodeSubmitted:null, //code submitted callback
              onCodeChanged: (v)=>_onEdit(v!),
              codeLength:4
    ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(_smsVerifyStates == SmsVerifyStates.ERROR? "sms code error": "", style: TextStyle(color: Colors.redAccent),),
            ),
            KeyBoard(keyboardStyles: KeyboardStyles.NONE,onPressed: (v)=>_onPressed(v), backSpace: _backSpace, clear: _clear)
          ],
        ):
            _smsVerifyStates == SmsVerifyStates.LOADING

        ? Container(child: CircularProgressIndicator()):
                _smsVerifyStates == SmsVerifyStates.SUCCESS
          ? Container(child: Text("OK"),): Container(child: Text("Error"),)
      ),);
  }

  void _onEdit(String v)async{
    if(_code.length == 4){
      Future.delayed(Duration(milliseconds: 100)).then((value) => _checkSms());
    }
  }

  void _checkSms(){
    setState(() {
      _smsVerifyStates = SmsVerifyStates.LOADING;
    });
    widget.checkSmsCode(_code).then((value) {
      if(value){
        setState(() {
          _smsVerifyStates = SmsVerifyStates.SUCCESS;
          widget.onCodeSuccess();
        });
      }else {
        _clear();
        setState(() {
          _smsVerifyStates = SmsVerifyStates.ERROR;
        });
      }
    });

  }

  void _onPressed(v){
    setState(() {
      _code += v;
    });
  }

  void _backSpace(){
    setState(() {
      _code = _code.substring(0, _code.length - 1);
    });
  }

  void _clear(){
    setState(() {
      _code = "";
    });
  }

}
