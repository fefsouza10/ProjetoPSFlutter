import 'package:ProjetoPSFlutter/widgets/text_composer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'perfil_page.dart';

class EditarPerfilPage extends StatefulWidget {
  @override
  _EditarPerfilPageState createState() => _EditarPerfilPageState();
}

class _EditarPerfilPageState extends State<EditarPerfilPage> {
  final _formKey = GlobalKey<FormState>();

  Map<String, dynamic> data = {};
  String id;
  final db = Firestore.instance;
  String name;
  String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                  SizedBox(
                    height: 0.0,
                  ),
                  Container(
                    height: 70.0,
                    width: 250.0,
                    child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      shadowColor: Colors.black,
                      color: Colors.white,
                      elevation: 7.0,
                      child: Center(
                        child: Text(
                          "Edite seu perfil",
                          style: TextStyle(
                              fontSize: 30.0, fontFamily: "Montserrat"),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Material(
                          color: Colors.purple,
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.purple,
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Padding(
                                  padding: EdgeInsets.all(0),
                                  child: Material(
                                    child: TextFormField(
                                      onChanged: (text) {
                                        data['name'] = text;
                                      },
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "Campo vazio";
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                          labelText: "Editar nome",
                                          labelStyle: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 17,
                                              fontFamily: 'Montserrat')),
                                    ),
                                  ))),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Material(
                          child: Container(
                              child: Padding(
                            padding: EdgeInsets.all(0),
                            child: TextFormField(
                              onChanged: (text) {
                                data['email'] = text;
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Campo vazio";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  labelText: "Editar e-mail",
                                  labelStyle: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 17,
                                      fontFamily: 'Montserrat')),
                            ),
                          )),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 100.0,
                  ),
                  Container(
                    height: 40.0,
                    width: 105.0,
                    child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      shadowColor: Colors.greenAccent,
                      color: Colors.green,
                      elevation: 7.0,
                      child: RaisedButton(
                        color: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.green)),
                        onPressed: () {
                          // Validate returns true if the form is valid, otherwise false.
                          if (_formKey.currentState.validate()) {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            Firestore.instance
                                .collection("user1")
                                .document("dadosUser")
                                .updateData(data);
                            setState(() {
                              Navigator.pop(context, data);
                            });
                            Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text('Processing Data')));
                          }
                        },
                        child: Text(
                          'Salvar',
                          style: TextStyle(color: Colors.white),
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
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Center(
                          child: Text(
                            "Voltar",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text("Voltar para Perfil"),
      ),
    );
  }

  void readData() async {
    DocumentSnapshot snapshot =
        await db.collection('conversas').document("user1").get();
    print(snapshot.data);
  }
}

class GetClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height / 3.5);
    path.lineTo(size.width + 50000, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
