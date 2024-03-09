// model chat:
import 'package:cloud_firestore/cloud_firestore.dart';


class Message{
final String senderId;
final String receverId;
final String message;
final Timestamp timestamp;

Message({
required this.senderId,
required this.receverId,
required this.message,
  required this.timestamp,
});

Map<String,dynamic >toMap(){
  return{
    "senderId": senderId,
    "receverId":receverId,
    "message":message,
    "timestamp":timestamp,
  };
} 
}