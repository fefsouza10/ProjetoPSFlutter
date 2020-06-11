import 'package:ProjetoPSFlutter/widgets/text_composer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NoticiasPage extends StatefulWidget {
  @override
  _NoticiasPageState createState() => _NoticiasPageState();
}

class _NoticiasPageState extends State<NoticiasPage> {

  void _sendMessage({String text}){
    Firestore.instance.collection('messages').document().setData({'text' : text});
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NomeDoBot"),
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
