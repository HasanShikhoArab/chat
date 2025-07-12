import 'package:chat/moudels/messagemodel.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  CollectionReference messags = FirebaseFirestore.instance.collection(
      KmessageCollecation);

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute
        .of(context)!
        .settings
        .arguments;
    return StreamBuilder<QuerySnapshot>(

        stream: messags.orderBy(kcreated).snapshots()
        , builder: (context, snapshot) {
      if (snapshot.hasData) {
        List<Message> messageList = [];
        for (int i = 0; i < snapshot.data!.docs.length; i++) {
          messageList.add(Message.fromjson(snapshot.data!.docs[i]));
        }

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
                child: ListView.builder(


                  controller: controller,
                  itemCount: messageList.length,
                  itemBuilder: (context, index) {
                    return messageList[index].id == email ?
                    chatbubble(message: messageList[index],)
                                        :chatbubble2(message: messageList[index]);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: TextField(
                  controller: contr,
                  onSubmitted: (value) {
                    messags.add({

                      'message': value,
                      kcreated: DateTime.now(),
                      'id': email
                    });
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


      else {
        return Text('');
      }
    });
  }
}



