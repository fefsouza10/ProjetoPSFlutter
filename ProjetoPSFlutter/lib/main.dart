import 'package:ProjetoPSFlutter/pages/chat_page.dart';
import 'pages/noticias_page.dart';
import 'pages/perfil_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() async {


  PageController pcontroller = PageController(
    initialPage: 2,
  );

//Firestore.instance.collection("col").document("doc").setData({"texto": "felipe"});

  runApp(
    MaterialApp(
      title: "NomeDoBot",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.purple,
          iconTheme: IconThemeData(color: Colors.purpleAccent)),
      home: PageView(
        controller: pcontroller,
        children: <Widget>[
          PerfilPage(),
          ChatPage(),
          NoticiasPage(),
        ],
      ),
    ),
  );

//inserir um doc no firestore
  Firestore.instance
      .collection("mensagen2s")
      .document()
      .setData({"texto": "1515151"});
//puxar documentos do firestore
  QuerySnapshot snapshot =
      await Firestore.instance.collection("mensagen2s").getDocuments();
//printar dados da snapshot
  snapshot.documents.forEach((d) {
    print(d.data);
  });



}
