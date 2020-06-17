import 'package:ProjetoPSFlutter/widgets/pandemic_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ProjetoPSFlutter/models/uf_info.dart';
import 'package:ProjetoPSFlutter/models/country_info.dart';

class PandemicPage extends StatefulWidget {
  @override
  _PandemicPageState createState() => _PandemicPageState();
}

class _PandemicPageState extends State<PandemicPage> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: TabBar(
          unselectedLabelColor: Colors.purpleAccent,
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.purple, Colors.purpleAccent]),
            borderRadius: BorderRadius.circular(50),
            color: Colors.purpleAccent
          ),
          controller: _tabController,
          tabs: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Brasil", style: TextStyle(fontSize: 16),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Global", style: TextStyle(fontSize: 16),),
            ),
          ],
        ),
      ),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: <Widget>[
          BrasilPandemicList(),
          PandemicList(),
        ],
      ),
    );

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

}

class BrasilPandemicList extends StatelessWidget {

  Future<List<UFInfo>> fetch() async {
    var response = await http.get("https://covid19-brazil-api.now.sh/api/report/v1");
    if (response.statusCode != 200) return null;
    var decoded = jsonDecode(response.body)["data"] as List;
    var list = decoded.map((e) => UFInfo.fromJson(e)).toList();
    list.sort((a, b) => b.cases - a.cases);
    for (int i = 0; i < list.length; ++i)
      list[i].state = "${i + 1}° - ${list[i].state}";
    var total = list.reduce((a, b) => UFInfo(
      cases: a.cases + b.cases,
      refuses: a.refuses + b.refuses,
      deaths: a.deaths + b.deaths,
      suspects: a.suspects + b.suspects,
    ));
    total.state = "Brasil";
    total.uf = "Total";
    return [total] + list;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Colors.transparent,
      body: FutureBuilder(future: fetch(), builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            break;
          case ConnectionState.done:
            return ListView(
                children: (snapshot.data as List<UFInfo>)?.map((i) => UFCard(i))?.toList() ?? []
            );
        }
        return Center(child: SpinKitFadingCircle(color: Colors.purple, size: 40,));
      },)
  );
}

class PandemicList extends StatelessWidget {

  Future<List<CountryInfo>> fetch() async {
    var response = await http.get("https://covid19-brazil-api.now.sh/api/report/v1/countries");
    if (response.statusCode != 200) return null;
    var decoded = jsonDecode(response.body)["data"] as List;
    var list = decoded.map((e) => CountryInfo.fromJson(e)).toList();
    list.sort((a, b) => b.cases - a.cases);
    for (int i = 0; i < list.length; ++i)
      list[i].country = "${i + 1}° - ${list[i].country}";
    var total = list.reduce((a, b) => CountryInfo(
      cases: a.cases + b.cases,
      confirmed: a.confirmed + b.confirmed,
      deaths: a.deaths + b.deaths,
      recovered: a.recovered + (b.recovered ?? 0),
    ));
    total.country = "Total";
    return [total] + list;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Colors.transparent,
      body: FutureBuilder(future: fetch(), builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            break;
          case ConnectionState.done:
            return ListView(
              children: (snapshot.data as List<CountryInfo>)?.map((i) => CountryCard(i))?.toList() ?? []
            );
        }
        return Center(child: SpinKitFadingCircle(color: Colors.purple, size: 50,));
      },)
  );
}
