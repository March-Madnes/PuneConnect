import 'package:flutter/material.dart';

class IssuedPass {
  final int id;
  final int passIndex;
  final String title;
  final DateTime issueDate;
  final int price;
  final Icon passIcon;

  IssuedPass(this.id, this.passIndex, this.title, this.issueDate, this.price, this.passIcon);
}