import 'package:ProjetoPSFlutter/pages/chat_page.dart';
import 'package:ProjetoPSFlutter/pages/editarperfil_page.dart';
import 'package:ProjetoPSFlutter/pages/pandemic_page.dart';
import 'pages/noticias_page.dart';
import 'pages/perfil_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() async {
//Firestore.instance.collection("col").document("doc").setData({"texto": "felipe"});

  runApp(TabBarDemo());

  Firestore.instance
      .collection("col")
      .document("doc")
      .setData({"texto": "felipe"});
//inserir um doc no firestore
  Firestore.instance
      .collection("mensagens")
      .document()
      .setData({"texto": "1515151"});
//puxar documentos do firestore
  QuerySnapshot snapshot =
      await Firestore.instance.collection("mensagens").getDocuments();
//printar dados da snapshot
  snapshot.documents.forEach((d) {
    print(d.data);
  });
}

class TabBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    home: DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: TabBar(
            labelColor: Colors.deepPurpleAccent,
            unselectedLabelColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                color: Colors.white
            ),
            tabs: [
              Tab(icon: Icon(Icons.account_circle),),
              Tab(icon: Icon(Icons.adb),),
              Tab(icon: Icon(Icons.public),),
              Tab(icon: ImageIcon(AssetImage("assets/plague.png")),),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            PerfilPage(),
            ChatPage(),
            NewsPage(DemoRequester()),
            PandemicPage(),
          ],
        ),
      ),
    ),
  );
}

