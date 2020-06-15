import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class UFInfo {
  int uid;
  String uf;
  String state;
  int cases;
  int deaths;
  int suspects;
  int refuses;
  bool broadcast;
  String comments;
  String datetime;

  UFInfo(
      {this.uid,
        this.uf,
        this.state,
        this.cases,
        this.deaths,
        this.suspects,
        this.refuses,
        this.broadcast,
        this.comments,
        this.datetime});

  UFInfo.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    uf = json['uf'];
    state = json['state'];
    cases = json['cases'];
    deaths = json['deaths'];
    suspects = json['suspects'];
    refuses = json['refuses'];
    broadcast = json['broadcast'];
    comments = json['comments'];
    datetime = json['datetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['uid'] = this.uid;
    data['uf'] = this.uf;
    data['state'] = this.state;
    data['cases'] = this.cases;
    data['deaths'] = this.deaths;
    data['suspects'] = this.suspects;
    data['refuses'] = this.refuses;
    data['broadcast'] = this.broadcast;
    data['comments'] = this.comments;
    data['datetime'] = this.datetime;
    return data;
  }
}

class CountryInfo {
  String country;
  int cases;
  int confirmed;
  int deaths;
  int recovered;
  String updatedAt;

  CountryInfo(
  {this.country,
    this.cases,
    this.confirmed,
    this.deaths,
    this.recovered,
    this.updatedAt});

  CountryInfo.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    cases = json['cases'];
    confirmed = json['confirmed'];
    deaths = json['deaths'];
    recovered = json['recovered'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this.country;
    data['cases'] = this.cases;
    data['confirmed'] = this.confirmed;
    data['deaths'] = this.deaths;
    data['recovered'] = this.recovered;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

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

      ],
    ),
  ));
}