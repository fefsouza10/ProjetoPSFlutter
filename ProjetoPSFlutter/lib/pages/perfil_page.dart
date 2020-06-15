import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'editarperfil_page.dart';

class PerfilPage extends StatefulWidget {
  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  Map<String, dynamic> data = {
    "name": "Teste",
    "email": "teste@exemplo.com",
  };

//TextEditingController =

  String id;
  final db = Firestore.instance;
  String name;

  void initState() {
    setState(() {
      readData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(color: Colors.white.withOpacity(1.0)),
        ClipPath(
          child: Container(color: Colors.purple.withOpacity(1.0)),
          clipper: GetClipper(),
        ),
        Positioned(
            width: 350.0,
            left: 25.0,
            top: MediaQuery.of(context).size.height / 5,
            child: Column(
              children: <Widget>[
                Container(
                  width: 150.0,
                  height: 150.0,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      image: DecorationImage(
                          image: NetworkImage(
                            ("https://i.imgur.com/vIeNO5P.png"),
                          ),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.all(Radius.circular(75.0)),
                      boxShadow: [
                        BoxShadow(blurRadius: 7.0, color: Colors.black)
                      ]),
                ),
                SizedBox(height: 30.0),
                Material(
                  color: Colors.white,
                  child: Text(
                    data['name'],
                    style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Montserrat",
                        color: Colors.black),
                  ),
                ),
                SizedBox(height: 15.0),
                Material(
                  color: Colors.white,
                  child: Text(
                    data['email'],
                    style: TextStyle(
                        fontSize: 17.0,
                        fontStyle: FontStyle.italic,
                        fontFamily: "Montserrat"),
                  ),
                ),
                SizedBox(
                  height: 250.0,
                ),
                Container(
                  height: 30.0,
                  width: 95.0,
                  child: Material(
                    borderRadius: BorderRadius.circular(20.0),
                    shadowColor: Colors.greenAccent,
                    color: Colors.green,
                    elevation: 7.0,
                    child: GestureDetector(
                      onTap: () {
                        _showEditarPerfil();
                      },
                      child: Center(
                        child: Text(
                          "Editar perfil",
                          style: TextStyle(
                              color: Colors.white, fontFamily: "Montserrat"),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Container(
                  height: 30.0,
                  width: 95.0,
                  child: Material(
                    borderRadius: BorderRadius.circular(20.0),
                    shadowColor: Colors.redAccent,
                    color: Colors.red,
                    elevation: 7.0,
                    child: GestureDetector(
                      onTap: () {},
                      child: Center(
                        child: Text(
                          "Log out",
                          style: TextStyle(
                              color: Colors.white, fontFamily: "Montserrat"),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ],
    );
  }

  void readData() async {
    DocumentSnapshot snapshot =
        await db.collection('conversas').document("user1").get();
    print(snapshot.data['name']);
    print(snapshot.data['email']);
    data['name'] = snapshot.data['name'];
    data['email'] = snapshot.data['email'];
  }

  void _showEditarPerfil() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => EditarPerfilPage()));
  }
}

class GetClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height / 2.37);
    path.lineTo(size.width + 125, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return null;
  }
}
