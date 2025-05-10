import 'package:flutter/material.dart';

class LoadingDialog {
  static void show(BuildContext context, {String message = 'Loading...'}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        content: Padding(
          padding: EdgeInsets.symmetric(horizontal: 42.0, vertical: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.save, size: 64, color: Colors.blue),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Installation Wizard", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                      Text("Device must be registered before can be used", style: TextStyle(fontSize: 14, color: Colors.blue)),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 64),
              SizedBox(
                width: double.infinity, // 👈 takes full width of the parent (Padding area)
                child: LinearProgressIndicator(
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              ),
              SizedBox(height: 16),
              Text("Please Wait", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text("We tried to install your devices", style: TextStyle(fontSize: 14)),
              SizedBox(height: 64),
              Text("Version 1.0.0", style: TextStyle(fontSize: 14)),
            ],
          ),
        )
      ),
    );
  }

  static void hide(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}