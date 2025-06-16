import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'note_model.g.dart';

@HiveType(typeId: 1)
class NoteModel {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String content;
  @HiveField(3)
  final Color color;
  // @HiveField(4)
  // final DateTime createdAt;
  // @HiveField(5)
  // final DateTime updatedAt;

  NoteModel({
    required this.id,
    required this.title,
    required this.content,
    required this.color,
    // required this.createdAt,
    // required this.updatedAt,
  });


  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id'] as int,
      title: json['title'] as String,
      content: json['content'] as String,
      color: Color(json['color'] as int),
      // createdAt: DateTime.parse(json['createdAt'] as String),
      // updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'color': color,
      // 'createdAt': createdAt.toIso8601String(),
      // 'updatedAt': updatedAt.toIso8601String(),
    };
  }
}