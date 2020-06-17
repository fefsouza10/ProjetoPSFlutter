import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'editarperfil_page.dart';

class PerfilPage extends StatefulWidget {
  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  String id;
  final db = Firestore.instance;
  String name;

  void initState() {
    setState(() {
      super.initState();
      readData();
    });
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
        Center(
            child: FutureBuilder(
          future: readData(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
              case ConnectionState.active:
                break;
              case ConnectionState.done:
                if (!snapshot.hasData)
                  return Text("Não foi possível carregar o seu perfil.");
                var data = snapshot.data as Map<String, dynamic>;
                return Column(
                  children: <Widget>[
                    SizedBox(
                      height: 100,
                    ),
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
                      height: 70.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        _showEditarPerfil();
                      },
                      child: Container(
                        height: 40.0,
                        width: 105.0,
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          shadowColor: Colors.greenAccent,
                          color: Colors.green,
                          elevation: 7.0,
                          child: Center(
                            child: Text(
                              "Editar perfil",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      height: 40.0,
                      width: 105.0,
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
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
            }
            return SpinKitFadingCircle(
              color: Colors.purple,
              size: 50,
            );
          },
        )),
      ],
    );
  }

  Future<Map<String, dynamic>> readData() async {
    DocumentSnapshot snapshot =
        await db.collection('user1').document("dadosUser").get();
    return snapshot.data;
  }

  void _showEditarPerfil() {
    Navigator.push(context,
            MaterialPageRoute(builder: (context) => EditarPerfilPage()))
        .then((value) {
      setState(() {});
    });
  }
}

class GetClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height / 1.87);
    path.lineTo(size.width + 0, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
