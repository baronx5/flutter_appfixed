import 'package:flutter/material.dart';
import 'package:flutter_appfixed/Models/user.dart';
import 'package:flutter_appfixed/apiResponse.dart';

messageDialog(BuildContext context, String msg) {
  return AlertDialog(
    title: Text('Message dialog'),
    content: Container(
        height: 200,
        width: 200,
        child: Center(child: Text(msg),)
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context, 'OK'),
        child: Text(
          'OK',
          style: TextStyle(
            color: Color(0xFF6200EE),
          ),
        ),
      ),
    ],
  );
}