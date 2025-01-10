import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastMessagePage extends StatelessWidget {
  final String message;

  // Constructor accepts a message
  const ToastMessagePage({required this.message});

  @override
  Widget build(BuildContext context) {
    // Show the toast message
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );

    // Return a simple empty page or a custom layout if needed
    return Scaffold(
      body: Center(
        child: Text(
          'Processing...',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
