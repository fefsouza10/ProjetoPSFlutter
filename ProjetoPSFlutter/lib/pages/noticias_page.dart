import 'package:flutter/material.dart';
import 'package:flutter_html_view/flutter_html_view.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class NewsInfo {
  ImageProvider image;
  String title;
  String htmlText;
  NewsInfo(this.image, this.title, this.htmlText);
}

class DBRequester {
  Future<List<NewsInfo>> requestNews(int index, int count) async => throw UnimplementedError();
}

class DemoRequester implements DBRequester {
  @override
  Future<List<NewsInfo>> requestNews(int index, int count) async {
    await Future.delayed(Duration(seconds: 1));
    return [
      NewsInfo(AssetImage("assets/ed-avatar.jpg"), "Título bom bolado", "asdasdasdasdasdasdasdasdasdasdasdasdasdsa"),
      NewsInfo(AssetImage("assets/ed-avatar.jpg"), "Título bom bolado", "asdasdasdasdasdasdasdasdasdasdasdasdasdsa"),
      NewsInfo(AssetImage("assets/ed-avatar.jpg"), "Título bom bolado", "asdasdasdasdasdasdasdasdasdasdasdasdasdsa"),
      NewsInfo(AssetImage("assets/ed-avatar.jpg"), "Título bom bolado", "asdasdasdasdasdasdasdasdasdasdasdasdasdsa"),
      NewsInfo(AssetImage("assets/ed-avatar.jpg"), "Título bom bolado", "asdasdasdasdasdasdasdasdasdasdasdasdasdsa"),
    ];
  }
}

class NewsCard extends StatelessWidget {

  final NewsInfo info;

  NewsCard(this.info);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Column(
          children: <Widget>[
            Image(image: info.image,),
            Text(info.title.toUpperCase(), style: TextStyle(fontSize: 24, backgroundColor: Colors.grey),),
            ExpansionTile(
              title: Text("Leia mais", style: TextStyle(fontSize: 8, color: Colors.grey),),
              children: <Widget>[
                HtmlView(
                  data: info.htmlText,
                  scrollable: false,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class NewsPage extends StatefulWidget {
  final DBRequester requester;

  NewsPage(this.requester);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: widget.requester.requestNews(0, 4),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              return ListView(children: (snapshot.data as List<NewsInfo>)?.map((i) => NewsCard(i))?.toList() ?? []);
          }
          return Center(child: SpinKitFadingCircle(color: Colors.purple, size: 50,));
        },
      )
    );
  }
}
