import 'package:ProjetoPSFlutter/widgets/text_composer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ProjetoPSFlutter/models/chat_message.dart';
import 'package:ProjetoPSFlutter/widgets/chat_message_list_item.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'dart:io';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _messageList = <ChatMessage>[];
  final _controllerText = new TextEditingController();

  void _sendMessage({String text, File imgFile}) async {
    Map<String, dynamic> data = {};
    String name = "User";
    String type = "ChatMessageType.sent";

    if (imgFile != null) {
      StorageUploadTask task = FirebaseStorage.instance
          .ref()
          .child(DateTime.now().millisecondsSinceEpoch.toString())
          .putFile(imgFile);

      StorageTaskSnapshot taskSnapshot = await task.onComplete;
      String url = await taskSnapshot.ref.getDownloadURL();
      data['imgUrl'] = url;
    }

    if (text != null) {
      data['text'] = text;
      data['name'] = name;
      data['type'] = type;
      data['time'] = DateTime.now().millisecondsSinceEpoch;
    }
    //salva mensagem do usuário no firebase
    Firestore.instance.collection('user1').document().setData(data);
    _addMessage(name: 'User', text: text, type: ChatMessageType.sent);
  }

  @override
  void dispose() {
    super.dispose();
    _controllerText.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NomeDoBot"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.purple,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          _buildList(),
          Divider(height: 1.0),
          TextComposer(_sendMessage),
        ],
      ),
    );
  }

// Cria a lista de mensagens (de baixo para cima)
  Widget _buildList() {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.all(8.0),
        reverse: true,
        itemBuilder: (_, int index) =>
            ChatMessageListItem(chatMessage: _messageList[index]),
        itemCount: _messageList.length,
      ),
    );
  }

  // Envia uma mensagem com o padrão a direita
  //void _sendMessage({String text}) {
  //  _controllerText.clear();
  //  _addMessage(name: 'User', text: text, type: ChatMessageType.sent);
  //}

  // Adiciona uma mensagem na lista de mensagens
  void _addMessage({String name, String text, ChatMessageType type}) {
    var message = ChatMessage(text: text, name: name, type: type);
    setState(() {
      _messageList.insert(0, message);
    });

    if (type == ChatMessageType.sent) {
      // Envia a mensagem para o chatbot e aguarda sua resposta
      _dialogFlowRequest(query: message.text);
    }
  }

  Future _dialogFlowRequest({String query}) async {
    // Adiciona uma mensagem temporária na lista
    _addMessage(
        name: 'NomeDoBot',
        text: 'Escrevendo...',
        type: ChatMessageType.received);

    // Faz a autenticação com o serviço, envia a mensagem e recebe uma resposta da Intent
    AuthGoogle authGoogle =
        await AuthGoogle(fileJson: "assets/key.json").build();
    Dialogflow dialogflow =
        Dialogflow(authGoogle: authGoogle, language: "pt-BR");
    AIResponse response = await dialogflow.detectIntent(query);

    // remove a mensagem temporária
    setState(() {
      _messageList.removeAt(0);
    });

    // adiciona a mensagem com a resposta do DialogFlow
    _addMessage(
        name: 'NomeDoBot',
        text: response.getMessage() ?? '',
        type: ChatMessageType.received);

    // salva a mensagem do bot no firebase
    Firestore.instance.collection("user1").document().setData({
      "name": "NomeDoBot",
      "text": response.getMessage(),
      "type": "ChatMessageType.received",
      "time": DateTime.now().millisecondsSinceEpoch
    });
  }
}
