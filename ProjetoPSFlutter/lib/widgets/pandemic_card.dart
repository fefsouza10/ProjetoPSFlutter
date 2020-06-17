import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:ProjetoPSFlutter/models/uf_info.dart';
import 'package:ProjetoPSFlutter/models/country_info.dart';
import 'package:percent_indicator/percent_indicator.dart';

class _Creator {
  final NumberFormat fmt = NumberFormat("###,###,###,###", Language.portugueseBrazilian);
  Widget row(IconData icon, String string, int number, { Color iconColor = Colors.black, Color textColor = Colors.white, Color numberColor = Colors.black }) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Row(children: <Widget>[
        Icon(icon, color: iconColor,),
        Text(" " + string, style: TextStyle(color: textColor),),
      ],),
      Text(number != null ? fmt.format(number) : "???", style: TextStyle(color: numberColor),),
    ],
  );
  Widget card(Widget child) => Padding(
    padding: EdgeInsets.fromLTRB(8, 12, 8, 16),
    child: Container(
      decoration: BoxDecoration(
          color: Color(0xFF333366),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
            ),
          ]
      ),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: child,
      ),
    ),
  );
  Widget percent(double percentage, String text) => Row(
    children: <Widget>[
      CircularPercentIndicator(
        percent: percentage,
        center: Text(
          "${(100 * percentage).toStringAsFixed(2)}%",
          style: TextStyle(
            color: Colors.white,
            fontSize: 8,
          ),
        ),
        radius: 50,
        progressColor: Colors.red[800],
        circularStrokeCap: CircularStrokeCap.round,
        animation: true,
        animationDuration: 1000,
        footer: Text(text, style: TextStyle(fontSize: 12, color: Colors.white),),
      ),
    ],
  );
}

class UFCard extends StatelessWidget with _Creator {
  final UFInfo info;
  UFCard(this.info);

  @override
  Widget build(BuildContext context) => card(Theme(
    data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
    child: ExpansionTile(
      trailing: SizedBox(),
      title: Column(
        children: <Widget>[
          Text("${info.state} - ${info.uf}".toUpperCase(), style: TextStyle(fontSize: 20, color: Colors.white),),
          SizedBox(height: 12,),
          row(MdiIcons.biohazard, "Casos Confirmados", info.cases, iconColor: Colors.red, numberColor: Colors.red),
          row(MdiIcons.accountAlert, "Casos em Investigação", info.suspects, iconColor: Colors.deepPurple, numberColor: Colors.deepPurple),
          row(MdiIcons.pulse, "Casos Descartados", info.refuses, iconColor: Colors.green, numberColor: Colors.green),
          row(MdiIcons.skull, "Óbitos", info.deaths, iconColor: Colors.black, numberColor: Colors.black),
        ],
      ),
      children: <Widget>[
        SizedBox(height: 12,),
            () {
          var pDeaths = (info.deaths.toDouble() / info.cases);
          return Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  percent(pDeaths, "Taxa de letalidade"),
                  SizedBox(height: 15,),
                  SizedBox(
                    width: 150,
                    child: Text("Os testes ${
                        pDeaths < .015 ? "são confiáveis." :
                        pDeaths < .03 ? "são relativamente confiáveis." :
                        pDeaths < .045 ? "já não são muito confiáveis." :
                        "não estão sendo suficientes e não são confiáveis para investigar o avanço da pandemia no local.\n"}",
                      style: TextStyle(color: Colors.white,),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ],
          );
        }(),
        Text(
          "As conclusões apresentadas são somente uma estimativa, para mais informações consulte as autoridades de saúde ou acesse o Painel Coronavirus no site covid.saude.gov.br",
          style: TextStyle(
            color: Colors.red[900],
            fontSize: 8,
          ),
          textAlign: TextAlign.center,
        )
      ],
    ),
  ));
}

class CountryCard extends StatelessWidget with _Creator {
  final CountryInfo info;
  CountryCard(this.info);

  @override
  Widget build(BuildContext context) => card(Theme(
    data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
    child: ExpansionTile(
      trailing: SizedBox(),
      title: Column(
        children: <Widget>[
          Text(info.country.toUpperCase(), style: TextStyle(fontSize: 24, color: Colors.white),),
          SizedBox(height: 12,),
          row(MdiIcons.biohazard, "Casos Confirmados", info.confirmed, iconColor: Colors.red, numberColor: Colors.red),
          row(MdiIcons.accountAlert, "Casos em Investigação", info.cases, iconColor: Colors.deepPurple, numberColor: Colors.deepPurple),
          row(MdiIcons.pulse, "Recuperados", info.recovered, iconColor: Colors.green, numberColor: Colors.green),
          row(MdiIcons.skull, "Óbitos", info.deaths, iconColor: Colors.black, numberColor: Colors.black),
        ],
      ),
      children: <Widget>[
        SizedBox(height: 12,),
        () {
          var pDeaths = (info.deaths.toDouble() / info.confirmed);
          var r = Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  percent(pDeaths, "Taxa de letalidade"),
                  SizedBox(height: 15,),
                  SizedBox(
                    width: 150,
                    child: Text("Os testes ${
                        pDeaths < .015 ? "são confiáveis." :
                        pDeaths < .03 ? "são relativamente confiáveis." :
                        pDeaths < .045 ? "já não são muito confiáveis." :
                        "não estão sendo suficientes e não são confiáveis para investigar o avanço da pandemia no local.\n"}",
                      style: TextStyle(color: Colors.white,),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ],
          );
          if (info.recovered == null) return r;
          var pRecovered = info.recovered.toDouble() / info.confirmed;
          r.children.add(
            Column(
              children: <Widget>[
                percent(pRecovered, "Taxa de recuperação"),
                SizedBox(height: 15,),
                SizedBox(
                  width: 150,
                  child: Text("A curva do espalhamento do vírus ${
                      pRecovered <= .55 ? "ainda está crescente e provávelmente ainda não atingiu seu pico." :
                      pDeaths < .65 ? "ainda está crescente, porém com tendências a diminuir." :
                      pDeaths < .85 ? "está sendo bem controlada e com tendências a diminuir." :
                      "está sendo muito bem controlada e deverá diminuir em breve.\n"}",
                    style: TextStyle(color: Colors.white, ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            )
          );
          return r;
        }(),
        Text(
          "As conclusões apresentadas são somente uma estimativa, para mais informações consulte as autoridades de saúde.",
          style: TextStyle(
            color: Colors.red[900],
            fontSize: 8,
          ),
          textAlign: TextAlign.center,
        )
      ],
    ),
  ));
}