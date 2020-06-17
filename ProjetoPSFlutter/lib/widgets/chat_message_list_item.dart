import 'package:ProjetoPSFlutter/models/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';

class ChatMessageListItem extends StatelessWidget {
  final ChatMessage chatMessage;

  ChatMessageListItem({this.chatMessage});

  @override
  Widget build(BuildContext context) {
    return chatMessage.type == ChatMessageType.sent
        ? _showSentMessage()
        : _showReceivedMessage();
  }

  Widget _showSentMessage({EdgeInsets padding, TextAlign textAlign}) {
    return ListTile(
      contentPadding: EdgeInsets.fromLTRB(64.0, 0.0, 8.0, 0.0),
      trailing: CircleAvatar(child: Text(chatMessage.name.toUpperCase()[0])),
      title: Text(chatMessage.name, textAlign: TextAlign.right),
//      subtitle: Text(chatMessage.text, textAlign: TextAlign.right),
      subtitle: Linkify(
        text: chatMessage.text,
        textAlign: TextAlign.right,
      ),
    );
  }

    Widget _showReceivedMessage() {
    return ListTile(
      contentPadding: EdgeInsets.fromLTRB(8.0, 0.0, 64.0, 0.0),
      leading: CircleAvatar( backgroundImage: AssetImage("assets/robot.jfif"),),
      title: Text(chatMessage.name, textAlign: TextAlign.left),
      subtitle: Linkify(
        text: chatMessage.text,
        textAlign: TextAlign.left,
      ),
    );
  }
}