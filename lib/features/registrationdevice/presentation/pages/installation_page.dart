import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:operatortracker/core/services/websocket_service.dart';
import 'package:operatortracker/features/registrationdevice/presentation/widgets/register_device_dialog.dart';
import '../bloc/installation_bloc.dart';
import '../bloc/installation_event.dart';
import '../bloc/installation_state.dart';

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
      bloc.add(StartInstallation('EK4DEVICES001'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocConsumer<InstallationBloc, InstallationState>(
        listener: (context, state) {
          if (state is InstallationLoading) {
            RegisterDeviceDialog.show(context, isWaitingActivationDialogState: false, deviceId: state.deviceId);
          } else if (state is InstallationAwaitingActivation){
            RegisterDeviceDialog.updateState(true);
            WebSocketService().connect(state.deviceId, () {
              Navigator.pushReplacementNamed(context, '/login');
              WebSocketService().disconnect();
            });
          } else if (state is InstallationFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            RegisterDeviceDialog.hide(context);
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
}