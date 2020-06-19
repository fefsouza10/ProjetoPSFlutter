//  - Integrantes do grupo:
// Bruno Garcia Caitano - RM81449
// Felipe Ferreira de Souza - RM81474
// Lucas Tomaz Cantuária - RM79869
// Pedro Estevam Oliveira Fonseca - RM80193
// Weslley Francis Fernandes - RM81609

//  - Link do Github:
// https://github.com/kmrbolas/ProjetoPSFlutter

//  - Link do vídeo de apresentação do aplicativo:
// https://www.youtube.com/watch?v=8kRu0uhIcLQ&t=38s


import 'package:ProjetoPSFlutter/pages/chat_page.dart';
import 'package:ProjetoPSFlutter/pages/pandemic_page.dart';
import 'pages/noticias_page.dart';
import 'pages/perfil_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
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
            Tab(icon: ImageIcon(AssetImage("assets/images/plague.png")),),
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
));

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
              Tab(icon: ImageIcon(AssetImage("assets/images/plague.png")),),
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

