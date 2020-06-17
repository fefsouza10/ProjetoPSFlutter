import 'package:flutter/material.dart';
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
          "A FDA (Food and Drug Administration, em inglês), agência que atua como a Anvisa nos Estados Unidos, revogou a permissão de emergência para o tratamento com a cloroquina e a hidroxicloroquina contra a Covid-19. \n\nOs responsáveis pelo órgão regulador declararam nesta segunda-feira (15) que \"não é mais razoável acreditar que as formulações orais de hidroxicloroquina e de cloroquina possam ser eficazes\". \n\nA agência explica que tomou a decisão com base em novas informações e em uma reavaliação dos dados disponíveis no momento da liberação de emergência para pacientes com Covid-19 no país, publicada em 28 de março."),
      NewsInfo(
          AssetImage("assets/images/noticia2.jpg"),
          "OMS vai discutir se mantém testes com hidroxicloroquina após EUA suspenderem uso da substância contra a Covid-19",
          "O diretor de emergências da Organização Mundial de Saúde (OMS), Michael Ryan, afirmou nesta segunda-feira (15) que a entidade vai discutir nesta semana se mantém os ensaios clínicos com hidroxicloroquina contra a Covid-19.\n\nA decisão foi anunciada logo depois que os Estados Unidos suspenderam a autorização emergencial de uso da substância contra a doença.\n\nOs testes com a hidroxicloroquina já haviam sido suspensos pela OMS no dia 25 de maio, mas, depois, foram retomados. Os experimentos com o remédio fazem parte de um conjunto de ensaios clínicos globais, chamados \"Solidariedade\" (veja detalhes mais abaixo nesta reportagem), que buscam um tratamento para a Covid-19.\n\nNormalmente, a hidroxicloroquina é usada para tratar alguns tipos de malária e de doenças autoimunes, como o lúpus. A substância surgiu como uma possibilidade de combater o novo coronavírus, mas vários estudos já apontam que ela não tem eficácia contra a doença."),
      NewsInfo(
          AssetImage("assets/images/noticia3.jpg"),
          "Coronavírus: os países onde a pandemia cresce, com o Brasil entre os mais afetados; veja a situação de cada lugar",
          "O Brasil e seus vizinhos da América Latina compõem o mais recente epicentro da pandemia de coronavírus, que matou mais de 400 mil pessoas no mundo. Na semana passada, morreram em média 4.319 pessoas por dia, sendo 2.028 no subcontinente latino-americano.\n\nOutros lugares do globo já ocuparam esse lugar: primeiro a China, onde o surto começou em dezembro, seguida da Europa e depois dos Estados Unidos.\n\nAtualmente, países e territórios se dividem basicamente em três fases: número de infectados em alta, pandemia estabilizada e casos novos em queda.\n\nHoje, segundo os dados disponíveis de 160 localidades no mundo, o primeiro grupo tem 75 países e territórios, sendo a maioria do hemisfério Sul, principal de regiões como América Latina, África e Oriente Médio.\n\nO segundo grupo, com 52, inclui lugares como os Estados Unidos, que têm o maior número de mortos e infectados, mas superaram o primeiro pico de casos de Covid-19, e o terceiro, 43. Mas esse cenário muda todos os dias."),
      NewsInfo(
          AssetImage("assets/images/noticia4.jpg"),
          "Dados preliminares de estudo britânico identificam remédio que pode reduzir mortes de pacientes graves com Covid-19",
          "Pesquisadores britânicos anunciaram nesta terça-feira (16) dados preliminares de um estudo que identifica um medicamento barato e amplamente disponível que pode ajudar na recuperação de pacientes gravemente doentes com coronavírus. Trata-se de um tipo específico de corticoide comum\n\nOs resultados preliminares do estudo Recovery são muito claros -- o remédio reduz o risco de morte em pacientes com complicações respiratórias graves. A Covid-19 é uma doença global -- é fantástico que o primeiro tratamento que demonstradamente reduz a mortalidade esteja instantaneamente disponível em todo o mundo\", afirmou Martin Landray, professor de medicina e epidemiologia do Departamento de Saúde da População da Universidade de Oxford, um dos líderes do estudo.\n\nOs resultados completos serão tornados públicos brevemente, de acordo com os cientistas. O estudo foi feito com mais de 2.000 pacientes que receberam o medicamento, e foram comparados a 4.300 que receberam os cuidados de praxe.\n\nPara os pacientes que estão em aparelhos respiradores, o risco de morte cai de 40% para 28%. Entre os que recebem oxigênio, a chance de morrer se reduziu de 25% para 20%. Para pacientes mais leves não houve constatação de melhora.\n\nOs pesquisadores estimam que se a droga tivesse sido administrada a pacientes com Covid-19 no Reino Unido desde o começo da pandemia, até 5.000 vidas teriam sido salvas."),
      NewsInfo(
          AssetImage("assets/images/noticia5.jpg"),
          "Vacina do Imperial College London será testada em 300 pessoas no Reino Unido",
          "O Imperial College London, no Reino Unido, iniciará os testes de uma vacina contra a Covid-19 em 300 pacientes a partir desta semana. Esta será a primeira vez que o produto será aplicado em humanos, etapa importante para mostrar se a aplicação é eficaz e segura.\n\nRobin Shattock, pesquisador principal na corrida pela vacina britânica, disse que a produção começou \"do zero\" e conseguiu chegar à etapa de testes clínicos em apenas três meses: \"do código ao candidato\".\n\n\"Isso nunca foi feito antes com este tipo de vacina. Se a nossa abordagem funcionar e a vacina fornecer proteção eficaz contra a doença, ela poderá revolucionar a forma como responderemos a surtos no futuro\", disse Shattock no documento divulgado à imprensa.\n\nO projeto recebeu uma verba de 41 milhões de libras \(cerca de R\$ 267 milhões\) do governo britânico e mais 5 milhões de libras \(cerca de R\$ 32,6 milhões\) de instituições filantrópicas. De acordo com a Imperial College, a vacina passou por testes rigorosos de segurança em animais e produziu sinais positivos de uma proteção contra o Sars CoV-2."),
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
        child: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return NoticiaExp(info);
            }));
          },
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
                  padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                  child: Column(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image(
                          image: info.image,
                          fit: BoxFit.cover,
                          height: 150,
                          width: 500,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                            child: Text(
                          info.title,
                          style: TextStyle(
                              fontSize: 20, backgroundColor: Colors.white),
                        )),
                      ),
                      ListTileTheme(
                        dense: true,
                        child: ListTile(
                          title: Text(
                            "Aperte para ler mais",
                            style: TextStyle(fontSize: 15, color: Colors.grey),
                          ),
                          trailing: Text(
                            "Fonte: g1/Globo",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          dense: true,
                        ),
                      )
                    ],
                  ),
                ),
              )),
        ));
  }
}

class NoticiaExp extends StatelessWidget {
  final NewsInfo info;

  NoticiaExp(this.info);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(bottom: 0.0),
                child: Image(image: info.image, fit: BoxFit.fitHeight)),
            Stack(
              children: <Widget>[
                Column(
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
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Text(
                        info.htmlText,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                    SizedBox(height: 20.0,)
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text("Voltar para Notícias"),
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
