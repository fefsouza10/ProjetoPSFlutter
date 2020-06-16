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
      NewsInfo(AssetImage("assets/images/noticia1.jpg"), "EUA cancelam autorização para uso da hidroxicloroquina no tratamento contra a Covid-19", "FDA divulgou documento nesta segunda-feira e disse que 'não é mais razoável acreditar que as formulações orais de hidroxicloroquina e de cloroquina posam ser eficazes'."),
      NewsInfo(AssetImage("assets/images/noticia2.jpg"), "OMS vai discutir se mantém testes com hidroxicloroquina após EUA suspenderem uso da substância contra a Covid-19", "Diretor de emergências da entidade, Michael Ryan, afirmou que o grupo executivo dos ensaios Solidariedade deve se encontrar nesta semana para decidir sobre o braço dos testes que usa a substância."),
      NewsInfo(AssetImage("assets/images/noticia3.jpg"), "Coronavírus: os países onde a pandemia cresce, com o Brasil entre os mais afetados; veja a situação de cada lugar", "O Brasil e seus vizinhos da América Latina compõem o mais recente epicentro da pandemia de coronavírus, que matou mais de 400 mil pessoas no mundo. Na semana passada, morreram em média 4.319 pessoas por dia, sendo 2.028 no subcontinente latino-americano."),
      NewsInfo(AssetImage("assets/images/ed-avatar.jpg"), "Título bom bolado", "asdasdasdasdasdasdasdasdasdasdasdasdasdsa"),
      NewsInfo(AssetImage("assets/images/ed-avatar.jpg"), "Título bom bolado", "asdasdasdasdasdasdasdasdasdasdasdasdasdsa"),
    ];
  }
}

class NewsCard extends StatelessWidget {

  final NewsInfo info;

  NewsCard(this.info);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(14, 10, 14, 10),
      child: Card(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Column(
          children: <Widget>[
            Image(image: info.image,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: Text(info.title, style: TextStyle(fontSize: 20, backgroundColor: Colors.white),)),
            ),
            ExpansionTile(
              title: Text("Leia mais", style: TextStyle(fontSize: 16, color: Colors.grey),),
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
    ));
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
