import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ProjetoPSFlutter/models/chat_message.dart';
import 'package:ProjetoPSFlutter/widgets/chat_message_list_item.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  static const BotName = "James o Sábio";
  static const MessagesCollection = "chatMessages";
  static final ChatMessage introMessage = ChatMessage(
    name: BotName,
    text: "Olá menu nome é james e estou aqui para conversar com você nessa quarentena, quando tiver um tempinho mande um oi ;)",
    type: ChatMessageType.received,
  );
  static final ChatMessage typingMessage = ChatMessage(
    name: BotName,
    text: "Digitando...",
    type: ChatMessageType.received,
  );

  TextEditingController controller = TextEditingController();
  List<ChatMessage> messages = [introMessage];
  bool typing = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
    children: <Widget>[
      buildMessageList(),
      Divider(height: 1.0),
      SizedBox(
        height: 50,
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: controller,
                onSubmitted: (text) {
                  controller.text = "";
                  sendMessage(text);
                },
              ),
            ),
            IconButton(
              icon: Icon(Icons.send),
              onPressed: () {
                sendMessage(controller.text);
                controller.text = "";
              },
            ),
          ],
        ),
      )
    ],
  );

  Widget buildMessageList() => Expanded(
    child: StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection(MessagesCollection).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Center(child: SpinKitFadingCircle(color: Colors.purple, size: 50,),);
        messages = snapshot.data.documents.map((e) => ChatMessage.fromJson(e.data)).toList();
        messages.sort((a, b) => b.sentDate.compareTo(a.sentDate));
        messages = messages + [introMessage];
        return ListView(
          children: (typing ? [typingMessage] + messages : messages).map((e) => ChatMessageListItem(chatMessage: e)).toList(),
          reverse: true,
        );
      }
    )
  );

  Future sendMessage(String text) async {
    if (text.trim().isEmpty) return;
    typing = true;
    await Firestore.instance.collection(MessagesCollection).document().setData(ChatMessage(
      text: text,
      name: "User",
      type: ChatMessageType.sent,
      sentDate: DateTime.now()
    ).toJson());

    AuthGoogle authGoogle = await AuthGoogle(fileJson: "assets/key.json").build();
    Dialogflow dialogflow = Dialogflow(authGoogle: authGoogle, language: Language.portugueseBrazilian);
    AIResponse response = await dialogflow.detectIntent(text);

    if (response == null) return;

    var textMsg = response.getMessage();

    if (textMsg == null) return;

    var msg = ChatMessage(
      name: BotName,
      type: ChatMessageType.received,
      text: response.getMessage(),
      sentDate: DateTime.now(),
    );

    typing = false;
    await Firestore.instance.collection(MessagesCollection).document().setData(msg.toJson());
  }

}
