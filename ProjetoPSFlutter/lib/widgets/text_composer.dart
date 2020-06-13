import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';

class TextComposer extends StatefulWidget {

  TextComposer(this.sendMessage);

  final Function({String text, File imgFile}) sendMessage; //enviar a mensagem do usuário

  @override
  _TextComposerState createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {

  final TextEditingController _controller = TextEditingController();

//o usuário está digitando? pra ativar/desativar botão e outras coisas referentes ao campo de texto
  bool _isComposing = false;

  void _reset(){
    _controller.clear();
            setState(() {
              _isComposing = false;
            });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
        child: Row(
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () async{
            final PickedFile imgFile = await ImagePicker().getImage(source: ImageSource.gallery);
            final File file = File(imgFile.path);
            if (imgFile == null) return;
            widget.sendMessage(imgFile: file);
          },
        ),
        Expanded(
          child: TextField(
            controller: _controller,
            decoration:
                InputDecoration.collapsed(hintText: "Enviar uma mensagem"),
            onChanged: (text) {
              setState(() {
                _isComposing = text.isNotEmpty;
              });
            },
            onSubmitted: (text) {
              widget.sendMessage(text: text);
              _reset();
            },
          ),
        ),
        IconButton(
          icon: Icon(Icons.send),
          onPressed: _isComposing ? () {
            widget.sendMessage(text: _controller.text);
            _reset();
          } : null,
        ),
      ],
    ));
  }
}
