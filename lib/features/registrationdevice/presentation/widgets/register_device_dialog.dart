import 'package:flutter/material.dart';

class RegisterDeviceDialog {
  static final ValueNotifier<bool> _activationState = ValueNotifier(false);

  static void show(BuildContext context, {required bool isWaitingActivationDialogState,
    required String deviceId}) {
    _activationState.value = isWaitingActivationDialogState;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: Padding(
            padding: EdgeInsets.symmetric(horizontal: 42.0, vertical: 8.0),
            child: ValueListenableBuilder<bool>(
              valueListenable: _activationState,
              builder: (context, isWaitingForActivation, _) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          isWaitingForActivation ? Icons.save : Icons.hourglass_empty,
                          size: 64,
                          color: Colors.blue,
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Installation Wizard",
                                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                            Text(
                              "Device must be registered before can be used",
                              style: TextStyle(fontSize: 14, color: Colors.blue),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 64),
                    isWaitingForActivation
                        ? Column(
                      children: [
                        Text("Device ID", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        SizedBox(height: 16),
                        TextFormField(
                          initialValue: deviceId ?? "-",
                          style: TextStyle(fontSize: 14),
                          enabled: false,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.grey[100],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 16),
                        Text("Waiting For Activation...",
                          style: TextStyle(fontSize: 14, color: Colors.blue),
                        ),
                      ],
                    )
                        : Column(
                      children: [
                        LinearProgressIndicator(
                          backgroundColor: Colors.grey[300],
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                        ),
                        SizedBox(height: 16),
                        Text("Please Wait",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        Text("We tried to install your devices",
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(height: 64),
                    Text("Version 1.0.0", style: TextStyle(fontSize: 14)),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  static void updateState(bool isWaitingForActivation) {
    _activationState.value = isWaitingForActivation;
  }

  static void hide(BuildContext context) {
    if (Navigator.of(context, rootNavigator: true).canPop()) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }
}
