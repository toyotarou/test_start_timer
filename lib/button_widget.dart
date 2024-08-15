// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  var backgroundColor;
  var color;

  ButtonWidget({
    super.key,
    required this.text,
    this.color = Colors.white,
    required this.onClicked,
    this.backgroundColor = Colors.black,
  });

  ///
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClicked,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 20,
          color: color,
        ),
      ),
    );
  }
}
