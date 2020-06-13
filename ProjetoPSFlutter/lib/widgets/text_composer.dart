import 'package:flutter/material.dart';

class TextComposer extends StatefulWidget {

  TextComposer(this.sendMessage);

  final Function({String text}) sendMessage; //enviar a mensagem do usuário

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
          onPressed: () {},
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
