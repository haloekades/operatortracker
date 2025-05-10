import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection.dart' as di;
import 'features/installation/presentation/pages/installation_page.dart';
import 'features/installation/presentation/bloc/installation_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => di.sl<InstallationBloc>(),
        child: InstallationPage(),
      ),
    );
  }
}