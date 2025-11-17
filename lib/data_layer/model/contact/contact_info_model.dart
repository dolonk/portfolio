import 'package:flutter/material.dart';

class ContactInfoModel {
  final String title;
  final String value;
  final String description;
  final IconData icon;
  final String actionText;
  final Color accentColor;
  final VoidCallback? onTap;

  ContactInfoModel({
    required this.title,
    this.value = "",
    required this.description,
    required this.icon,
    this.actionText = "",
    required this.accentColor,
    this.onTap,
  });
}
