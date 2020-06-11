import 'package:ProjetoPSFlutter/pages/chat_page.dart';
import 'pages/noticias_page.dart';
import 'pages/perfil_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() async {

  PageController controller = PageController(
    initialPage: 2,
  );

  runApp(
    MaterialApp(
      title: "NomeDoBot",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.purple,
          iconTheme: IconThemeData(color: Colors.purpleAccent)),
      home: PageView(controller: controller,
      children: <Widget>[
        ChatPage(),
        NoticiasPage(),
        PerfilPage(),
      ],),
    ),
  );

//inserir um doc no firestore
  Firestore.instance
      .collection("mensagens")
      .document()
      .setData({"texto": "felipe"});
//puxar documentos do firestore
  QuerySnapshot snapshot =
      await Firestore.instance.collection("mensagens").getDocuments();
//printar dados da snapshot
  snapshot.documents.forEach((d) {
    print(d.data);
  });
}
