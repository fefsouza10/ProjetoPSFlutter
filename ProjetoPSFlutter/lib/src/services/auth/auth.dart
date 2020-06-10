import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class Auth {
  final _c = FirebaseAuth.instance;

  Future<bool> signWithPhone(String verificacaoId, String msgCode) async{
    final loginResult = await _c.signInWithPhoneNumber(verificationId: verificacaoId, smsCode: msgCode);
    if(loginResult?.uid != null){         ///? esse sinal e proteção coontra nulos nesse caso 
      return true;
    }else{
      return false;
    }
  }

  Future verifyPhoneNumber(String numeroDoCelular) async{
    
    await _c.verifyPhoneNumber(
      phoneNumber: numeroDoCelular,
      codeSent: (String verified, [int forceResend]) {  ///forceResend Quantidade de vezes ate ir
        print("verificado com sucesso");
        print(verified);
      },
      verificationFailed: (AuthException authException){
        print("Deu ruim");
      },
      verificationCompleted: (FirebaseUser user){
        print(user?.uid);
      },
      codeAutoRetrievalTimeout: (String timeOut){
        print(timeOut);
      },
      timeout: Duration(seconds: 40)
    );
    
  }
}