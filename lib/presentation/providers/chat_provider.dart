import "package:flutter/material.dart";
import "package:yes_no_app/domain/entities/message.dart";

class ChatProvider extends ChangeNotifier {
  //controlador que maneja la posición del scroll
  final ScrollController chatScrollController = ScrollController();
  List<Message> messageList = [
    Message(text: "Hola Salazar", fromWho: FromWho.hers),
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
    if (text.trim().isEmpty) {
      return; // No hacer nada si el texto está vacío
    }
    final newMessage = Message(text: text.trim(), fromWho: FromWho.me);
    //agregar un nuevo mensaje a la lista
    messageList.add(newMessage);
    print("Cantidad de mensajes:  ${messageList.length}");

    //notifica a provider que algo cambió
    notifyListeners();
    moveScrollToBottom();
  }

  //mover el scroll hasta abajo
  Future<void> moveScrollToBottom() async {
    await Future.delayed(const Duration(milliseconds: 100));
    chatScrollController.animateTo(
        //offset: posicion del maximo scroll posible
        chatScrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        //rebote al final de la animacion
        curve: Curves.easeOut);
  }
}
