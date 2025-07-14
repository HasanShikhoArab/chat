import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../Constes.dart';
import '../../moudels/messagemodel.dart';
part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  CollectionReference messages =
  FirebaseFirestore.instance.collection(KmessageCollecation);
  List<Message> messagesList = [];
void sendmessage({required String message, required String email}){
  messages.add({
    kmessage: message,
    kcreated: DateTime.now(),
    'id': email,
  });


}

void getmessage(){
  messages.orderBy(kcreated).snapshots().listen((event) {
messagesList.clear();
for(var doc in event.docs ){

  messagesList.add(Message.fromjson(doc.data() as Map<String, dynamic>));
  
}

    emit(ChatSucces(messagesList));
  });

}
}
