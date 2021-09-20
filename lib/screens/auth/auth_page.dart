
import 'package:flutter/material.dart';
import 'package:izi_web/data/auth_screen_state/auth_screen_states.dart';
import 'package:izi_web/screens/main/main_screen.dart';
import 'package:izi_web/ui/utils/auth_state.dart';
import 'package:izi_web/ui/widgets/login_form.dart';
import 'package:izi_web/ui/widgets/password_field.dart';
import 'package:izi_web/ui/widgets/sms_verification.dart';

class AuthPage extends AuthState {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

//TODO add auth page stets and switch between them. Add switc(State){ screen 1, screen 2,...}

class _AuthPageState extends State<AuthPage> {
  bool startCheckPhone = false;
  late String enteredPhone;
  static AuthStates _authStates = AuthStates.PHONE;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  color: Theme.of(context).backgroundColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                        child: Center(
                          child: Image.asset(
                            "images/logo_white.png",
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                        child: Center(
                            child: Text(
                          "легкий мобільний банк",
                          style: TextStyle(fontSize: 28),
                        )),
                      ),
                      Container(
                        constraints: BoxConstraints(minWidth: 400),
                        width: MediaQuery.of(context).size.width / 2,
                        child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: _getBody()),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                      color: Theme.of(context).backgroundColor,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('images/intro.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )),
                ),
              ],
            ),
          ),
          Container(
            child: Container(
              color: Colors.blue,
              child: Text('Bottom', textAlign: TextAlign.center),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getBody() {
    if (_authStates == AuthStates.PHONE)
      return Center(
        child: LoginForm(
          onLoginClicked: (v) => onLoginClicked(v),
        ),
      );
    else if (_authStates == AuthStates.PASSWORD)
      return Container(
        child: PasswordField(
          onPasswordSuccess: () => _smsReview(),
        ),
      );
    else if (_authStates == AuthStates.SMS_CODE)
      return Container(
        child: SmsVerification(onCodeSuccess: (){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MainScreen()),
          );
        },),
      );
    else if(_authStates == AuthStates.LOADING)
      return Container(
        child: CircularProgressIndicator()
      );
    else return Text("Some thing wrong");
  }

  void onLoginClicked(String phone) async{
    enteredPhone = phone;
    setState(() {
      _authStates = AuthStates.LOADING;
    });
    var phoneState = await widget.checkPhoneIfExists(phone);
    if(phoneState){
      setState(() {
        _authStates = AuthStates.PASSWORD;
      });
    }
  }


  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => MainScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
    );
  }

  void _smsReview() {
    setState(() {
      _authStates = AuthStates.SMS_CODE;
    });
  }
}

// Image.asset('images/intro.jpg')
