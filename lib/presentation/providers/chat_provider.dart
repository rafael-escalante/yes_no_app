import "package:flutter/material.dart";
import "package:yes_no_app/config/helpers/get_yes_no_answer.dart";
import "package:yes_no_app/domain/entities/message.dart";

class ChatProvider extends ChangeNotifier {
  //controlador que maneja la posición del scroll
  final ScrollController chatScrollController = ScrollController();
  final getYesNoAnswer = GetYesNoAnswer();
  List<Message> messageList = [];

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) {
      return; // No hacer nada si el texto está vacío
    }
    final newMessage = Message(text: text.trim(), fromWho: FromWho.me);
    //agregar un nuevo mensaje a la lista
    messageList.add(newMessage);
    print("Cantidad de mensajes:  ${messageList.length}");

    //detectar si el usuario hizo una pregunta
    if (text.endsWith('?')) {
      herReply();
    }

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

  //crea la respuesta de ella (del servidor)
  Future<void> herReply() async {
    //Obtener el mensaje de la peticion http
    final herMessage = await getYesNoAnswer.getAnswer();

    //añadimos el mensaje de ella a la lista de mensajes
    messageList.add(herMessage);

    //notificar a provider que algo cambio
    notifyListeners();

    //mover el scroll hasta el ultimo mensaje
    moveScrollToBottom();
  }
}
