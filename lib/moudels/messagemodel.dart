import 'package:chat/Constes.dart';

class Message {
  final String message;
  final String id;

  Message(this.message, this.id);

  factory Message.fromjson(Map<String, dynamic> jsonData) {
    return Message(
      jsonData[kmessage] ?? '', // يعالج لو القيمة null
      jsonData['id'] ?? '',
    );
  }
}