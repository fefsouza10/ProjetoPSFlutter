import 'package:ProjetoPSFlutter/src/login/login-widget.dart';
import 'package:flutter/material.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  _logout(){
    
    Navigator.pushReplacement(context,
     MaterialPageRoute(builder: (BuildContext context) => LoginWidget()
      )
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
         title: Text("Tela inicial"),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: _logout, 
        child: Icon(Icons.exit_to_app),
      ),
      
    );
  }
}