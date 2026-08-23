import 'package:flutter/material.dart';

/// Tag Domain Model
class TagModel {
  final String id;
  final String name;
  final int colorValue;
  final DateTime createdAt;

  const TagModel({
    required this.id,
    required this.name,
    required this.colorValue,
    required this.createdAt,
  });

  Color get color => Color(colorValue);
}
