import "package:flutter/material.dart";
import "package:yes_no_app/domain/entities/message.dart";

class ChatProvider extends ChangeNotifier {
  List<Message> messageList = [
    Message(text: "Hola Salazar", fromWho: FromWho.me),
    Message(
        text: "Por haberte hido te vas a especial directo",
        fromWho: FromWho.me),
    Message(text: "Por haberte hido te vas a to", fromWho: FromWho.me),
    Message(
        text: "Por haberte hido te vas a especial directo",
        fromWho: FromWho.me),
    Message(
        text: "Por haberte hido te vas a especial directo",
        fromWho: FromWho.me),
  ];

  Future<void> sendMessage(String text) async {
    final newMessage = Message(text: text, fromWho: FromWho.me);
    //agregar un nuevo mensaje a la lista
    messageList.add(newMessage);

    //notifica a provider que algo cambio
    notifyListeners();
  }
}
