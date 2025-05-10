import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/installation_bloc.dart';
import '../bloc/installation_event.dart';
import '../bloc/installation_state.dart';
import '../../../../core/widgets/loading_dialog.dart';

class InstallationPage extends StatefulWidget {
  const InstallationPage({super.key});

  @override
  State<InstallationPage> createState() => _InstallationPageState();
}

class _InstallationPageState extends State<InstallationPage> {
  late InstallationBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read<InstallationBloc>();
    Future.delayed(Duration.zero, () {
      LoadingDialog.show(context, message: 'Checking device...');
      bloc.add(StartInstallation('DEVICE00009jajakka'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocConsumer<InstallationBloc, InstallationState>(
        listener: (context, state) {
          if (state is InstallationLoading) {
            LoadingDialog.show(context);
          } else {
            LoadingDialog.hide(context);
          }

          if (state is InstallationFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is InstallationAwaitingActivation) {
            _showActivationPopup(context, state.deviceId);
          } else if (state is InstallationSuccess) {
            Navigator.pushReplacementNamed(context, '/login');
          }
        },
        builder: (context, state) {
          return const Center(child: Text('Initializing...', style: TextStyle(color: Colors.white)));
        },
      ),
    );
  }

  void _showActivationPopup(BuildContext context, String deviceId) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        final nikController = TextEditingController();
        final passController = TextEditingController();
        return AlertDialog(
          backgroundColor: Colors.black,
          title: const Text('Waiting for Activation', style: TextStyle(color: Colors.white)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Device ID: $deviceId', style: const TextStyle(color: Colors.white70)),
              const SizedBox(height: 16),
              TextField(
                controller: nikController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(labelText: 'NIK', labelStyle: TextStyle(color: Colors.white70)),
              ),
              TextField(
                controller: passController,
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(labelText: 'Password', labelStyle: TextStyle(color: Colors.white70)),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
                bloc.add(SubmitActivation(
                  nik: nikController.text,
                  password: passController.text,
                  deviceId: deviceId,
                ));
              },
              child: const Text('Activate', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}