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
  Future<List<NewsInfo>> requestNews(int index, int count) async =>
      throw UnimplementedError();
}

class DemoRequester implements DBRequester {
  @override
  Future<List<NewsInfo>> requestNews(int index, int count) async {
    await Future.delayed(Duration(seconds: 1));
    return [
      NewsInfo(
          AssetImage("assets/images/noticia1.jpg"),
          "EUA cancelam autorização para uso da hidroxicloroquina no tratamento contra a Covid-19",
          "<hr><h3>FDA divulgou documento nesta segunda-feira e disse que 'não é mais razoável acreditar que as formulações orais de hidroxicloroquina e de cloroquina posam ser eficazes'.</h3><hr>"),
      NewsInfo(
          AssetImage("assets/images/noticia2.jpg"),
          "OMS vai discutir se mantém testes com hidroxicloroquina após EUA suspenderem uso da substância contra a Covid-19",
          "<hr><h3>Diretor de emergências da entidade, Michael Ryan, afirmou que o grupo executivo dos ensaios Solidariedade deve se encontrar nesta semana para decidir sobre o braço dos testes que usa a substância.</h3><hr>"),
      NewsInfo(
          AssetImage("assets/images/noticia3.jpg"),
          "Coronavírus: os países onde a pandemia cresce, com o Brasil entre os mais afetados; veja a situação de cada lugar",
          "<hr><h3>O Brasil e seus vizinhos da América Latina compõem o mais recente epicentro da pandemia de coronavírus, que matou mais de 400 mil pessoas no mundo. Na semana passada, morreram em média 4.319 pessoas por dia, sendo 2.028 no subcontinente latino-americano.</h3><hr>"),
      NewsInfo(
          AssetImage("assets/images/noticia4.jpg"),
          "Dados preliminares de estudo britânico identificam remédio que pode reduzir mortes de pacientes graves com Covid-19",
          "<hr><h3>Para pacientes que estão em aparelhos respiradores, o risco de morte cai de 40% para 28%. Entre os que recebem oxigênio, chance de morrer se reduz de 25% para 20%. Para pacientes leves não houve constatação de melhora.</h3><hr>"),
      NewsInfo(
          AssetImage("assets/images/noticia5.jpg"),
          "Vacina do Imperial College London será testada em 300 pessoas no Reino Unido",
          "<hr><h3>Governo britânico investe 41 milhões de libras (cerca de R\$ 267 milhões). Fase em humanos deverá garantir segurança e eficácia na imunização.</h3><hr>"),
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
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xFFffffff),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 10.0,
                      offset: Offset(0.0, 5.0),
                    ),
                  ]),
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Column(
                  children: <Widget>[
                    GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            return NoticiaExp(info);
                          }));
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image(
                            image: info.image,
                            fit: BoxFit.cover,
                            height: 150,
                            width: 500,
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                          child: Text(
                        info.title,
                        style: TextStyle(
                            fontSize: 20, backgroundColor: Colors.white),
                      )),
                    ),
                    ListTileTheme(
                      dense: true,
                      child: ExpansionTile(
                        title: Text(
                          "Leia mais",
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                        children: <Widget>[
                          HtmlView(
                            data: info.htmlText,
                            scrollable: false,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )));
  }
}

class NoticiaExp extends StatelessWidget {
  final NewsInfo info;

  NoticiaExp(this.info);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Image(image: info.image, fit: BoxFit.fitHeight)),
          Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 0,
                    ),
                    SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16.0,
                        right: 16.0,
                      ),
                      child: Text(
                        info.title,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Text(
                        info.htmlText,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text("Voltar para Perfil"),
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
                return ListView(
                    children: (snapshot.data as List<NewsInfo>)
                            ?.map((i) => NewsCard(i))
                            ?.toList() ??
                        []);
            }
            return Center(
                child: SpinKitFadingCircle(
              color: Colors.purple,
              size: 50,
            ));
          },
        ));
  }
}
