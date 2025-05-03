// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final chatModel = chatModelFromMap(jsonString);
import 'dart:convert';

import 'package:hive_flutter/adapters.dart';

part 'chat_model.g.dart';

ChatModel chatModelFromMap(String str) => ChatModel.fromMap(json.decode(str));

String chatModelToMap(ChatModel data) => json.encode(data.toMap());

@HiveType(typeId: 0)
class ChatModel {
  @HiveField(0)
  final String? sender;
  @HiveField(1)
  final String? query;
  @HiveField(2)
  final String? response;

  ChatModel({
    this.sender,
    this.query,
    this.response,
  });

  factory ChatModel.fromMap(Map<String, dynamic> json) => ChatModel(
        sender: json["sender"] ?? "",
        query: json["query"] ?? "",
        response: json["response"] ?? "",
      );

  Map<String, dynamic> toMap() => {
        "sender": sender ?? "",
        "query": query ?? "",
        "response": response ?? "",
      };

  ChatModel copyWith({
    String? sender,
    String? query,
    String? response,
  }) {
    return ChatModel(
      sender: sender ?? this.sender,
      query: query ?? this.query,
      response: response ?? this.response,
    );
  }
}
