import 'package:ProjetoPSFlutter/src/home/home-widget.dart';
import 'package:ProjetoPSFlutter/src/services/auth/auth.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends BlocBase  {

  final _auth = new Auth();

  final _phoneController = new BehaviorSubject<String>();
  Observable<String> get phoneFux => _phoneController.stream;
  Sink<String> get phoneEvent => _phoneController.sink;
  
  final _smsController = new BehaviorSubject<String>();
  Observable<String> get smsFux => _smsController.stream;
  Sink<String> get smsEvent => _smsController.sink;

  var _controllerLoading = BehaviorSubject<bool>(seedValue: false);
  
  Stream<bool> get outLoading => _controllerLoading.stream;
  
  final BuildContext context;
  LoginBloc(this.context);

  onClickTelefone() async {
    _controllerLoading.add(!_controllerLoading.value);

    await _auth.verifyPhoneNumber(_phoneController.value);

    _controllerLoading.add(!_controllerLoading.value);

    //pushReplace não deixa voltar a tela pelo botão 
    //fazer login e não deixar voltar se não fizer logout 
    Navigator.pushReplacement(context,
     MaterialPageRoute(builder: (BuildContext context) => HomeWidget()
      )
    );
  }

  onClickFacebook(){
    
  }
  onClickGoogle(){
    
  }
  
  
  
  
  @override
  void dispose() {
    _controllerLoading.close();
    _phoneController.close();
    _smsController.close();   
  }
}