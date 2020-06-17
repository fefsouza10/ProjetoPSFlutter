import 'dart:convert';

class ChatMessageType {
  static const sent = "SENT";
  static const received = "RECEIVED";
}

class ChatMessage {
  String name;
  String text;
  String type;
  DateTime sentDate;

  ChatMessage({this.name, this.text, this.type, this.sentDate});

  ChatMessage.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    text = json['text'];
    type = json['type'];
    sentDate = DateTime.fromMillisecondsSinceEpoch(int.parse(json['sentDate']));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['text'] = this.text;
    data['type'] = this.type;
    data['sentDate'] = this.sentDate.millisecondsSinceEpoch.toString();
    return data;
  }
}