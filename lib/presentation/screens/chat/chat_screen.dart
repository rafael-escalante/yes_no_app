import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yes_no_app/domain/entities/message.dart';
import 'package:yes_no_app/presentation/Widgets/chat/my_message_bubble.dart';
import 'package:yes_no_app/presentation/Widgets/chat/her_message_bubble.dart';
import 'package:yes_no_app/presentation/Widgets/shared/message_field_box.dart';
import 'package:yes_no_app/presentation/providers/chat_provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.all(4.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage("https://i.imgflip.com/7n3nhk.jpg"),
          ),
        ),
        title: Text("Mi amor ❤️"),
      ),
      body: _ChatView(),
    );
  }
}

class _ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Le pide que este pendiente de cambios
    final chatProvider = context.watch<ChatProvider>();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    //enlaza el controlador creado en ChatProvider
                    controller: chatProvider.chatScrollController,
                    itemCount: chatProvider.messageList.length,
                    itemBuilder: (context, index) {
                      //Instancia que sabrá de quien es el mensaje
                      final message = chatProvider.messageList[index];
                      //si el residuo es 0, es de ella; si no, es 0 es mio
                      //Si es par es de ella, si es impar mio
                      //return (index % 2 == 0)
                      return (message.fromWho == FromWho.hers)
                          ? const HerMessageBubble()
                          : MyMessageBubble(message: message);
                    })),

            ///caja de texto de mensajes
            MessageFieldBox(
              onValue: chatProvider.sendMessage,
            ),
          ],
        ),
      ),
    );
  }
}
