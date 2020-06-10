import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:ProjetoPSFlutter/src/login/login-bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
       bloc: LoginBloc(), 
       child: _LoginContent(),
      
    );
  }
}

class _LoginContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    _botao(){
      return Column(
        
        children: <Widget>[
          RaisedButton.icon(
            color: Colors.green,
            textColor: Colors.white,
            icon: Icon(Icons.phone),
            label: Text("Login Telefone  "),
            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
            onPressed: (){},),
            
          RaisedButton.icon(
            color: Colors.blue ,
            textColor: Colors.white,
            icon: Icon(FontAwesomeIcons.facebookF),
            label: Text("Login Facebook"),
            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
            onPressed: (){},),
            
          RaisedButton.icon(
            color: Colors.red,
            textColor: Colors.white,
            icon: Icon(FontAwesomeIcons.google),
            label: Text("Login Google     "),
            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
            onPressed: (){},)
        ],
      );
    }

    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlutterLogo(size: 72,),
          Container(height: 150,),
          AnimatedCrossFade(
            firstChild: _botao(),
            secondChild: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ), 
            crossFadeState: CrossFadeState.showFirst, 
            duration: Duration(milliseconds: 500)
          ),  
        ],
      ),
    );
  }
}
