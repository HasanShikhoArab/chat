import 'package:chat/cubit/cubits/chat_cubit.dart';
import 'package:chat/moudels/messagemodel.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../Constes.dart';
import '../weights/chatbuble.dart';

class chat extends StatefulWidget {
  chat({super.key});

  static String id = 'chatt';

  @override
  State<chat> createState() => _chatState();
}

class _chatState extends State<chat> {
  final controller = ScrollController();

  TextEditingController contr = TextEditingController();

  get message => null;

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute
        .of(context)!
        .settings
        .arguments;


    return Scaffold(
      appBar: AppBar(
        backgroundColor: kprimaryColor.shade700,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Klogo,
              height: 40,
              width: 40,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              'chat',
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                var messagesList=BlocProvider.of<ChatCubit>(context).messagesList;
                return ListView.builder(


                  controller: controller,
                  itemCount: messagesList.length,
                  itemBuilder: (context, index) {
                    return messagesList[index].id == email ?
                    chatbubble(message: messagesList[index],)
                        : chatbubble2(message: messagesList[index]);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: TextField(
              controller: contr,
              onSubmitted: (value) {
                BlocProvider.of<ChatCubit>(context).sendmessage(message: contr.text, email: email as String);
                contr.clear();
                controller.animateTo(controller.position.maxScrollExtent,
                    duration: Duration(seconds: 3),
                    curve: Curves.bounceInOut);
              },
              decoration: InputDecoration(
                  hintText: 'Enter message',
                  suffixIcon: Icon(
                    Icons.send, color: kprimaryColor.shade700,),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                          color: kprimaryColor.shade700))),
            ),
          )
        ],
      ),
    );
  }
}






