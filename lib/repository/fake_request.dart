



import 'package:izi_web/data/password_form_state/password_state.dart';

class FakeRequest{

  Future<bool> checkPhoneIfExists(String phone) async{
    String num = phone.replaceAll(new RegExp(r'[^\w\s\\s+]+'),'');
    print(num);
    return Future.delayed(const Duration(seconds: 5), (){
      return num == "+380 095 6920171";
    });
  }


  Future<PasswordState> checkPassword(String password) async{
    return Future.delayed(const Duration(seconds: 3), (){
      if(password == "1111"){
        return PasswordState.SUCCESS;
      }else return PasswordState.ERROR;
    });
  }

  Future<bool> checkSmsCode(String code) async{
    return Future.delayed(const Duration(seconds: 5), (){
      return code == "1111";
    });
  }

}