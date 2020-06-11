import 'package:ProjetoPSFlutter/widgets/text_composer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PerfilPage extends StatefulWidget {
  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {

  void _sendMessage({String text}){
    Firestore.instance.collection('messages').document().setData({'text' : text});
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Perfil"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.purple,
      ),
      backgroundColor: Colors.white,
      body: TextComposer(
        _sendMessage
      ),
    );
  }
}
