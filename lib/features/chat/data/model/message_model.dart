import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String? bodyMessage;
  String? chatId;
  String? fileUrl;
  int? receiverId;
  String? receiverType;
  bool? seen;
  int? senderId;
  String? senderType;
  Timestamp? time;

  // Constructor
  MessageModel({
    this.bodyMessage,
    this.chatId,
    this.fileUrl,
    this.receiverId,
    this.receiverType,
    this.seen,
    this.senderId,
    this.senderType,
    this.time,
  });

  // Factory constructor to create an instance from JSON
  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      bodyMessage: json['bodyMessage'] as String?,
      chatId: json['chatId'] as String?,
      fileUrl: json['fileUrl'] as String?,
      receiverId: json['receiverId'] as int?,
      receiverType: json['receiverType'] as String?,
      seen: json['seen'] as bool?,
      senderId: json['senderId'] as int?,
      senderType: json['senderType'] as String?,
      time: json['time'] as dynamic,
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'bodyMessage': bodyMessage,
      'chatId': chatId,
      'fileUrl': fileUrl,
      'receiverId': receiverId,
      'receiverType': receiverType,
      'seen': seen,
      'senderId': senderId,
      'senderType': senderType,
      'time': time,
    };
  }
}
