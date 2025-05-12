import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:operatortracker/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:operatortracker/features/chat/presentation/bloc/chat_event.dart';
import 'package:operatortracker/features/chat/presentation/pages/chat_page.dart';
import 'package:operatortracker/features/login/presentation/bloc/login_bloc.dart';
import 'package:operatortracker/features/login/presentation/pages/login_page.dart';
import 'injection.dart' as di;
import 'features/registrationdevice/presentation/pages/installation_page.dart';
import 'features/registrationdevice/presentation/bloc/installation_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App',
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => di.sl<InstallationBloc>(),
                child: InstallationPage(),
              ),
            );

          case '/login':
            return MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => di.sl<LoginBloc>(),
                child: LoginPage(),
              ),
            );

          case '/chat':
            final unitId = settings.arguments as String;
            return MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => di.sl<ChatBloc>()..add(FetchChatMessages(unitId)),
                child: ChatPage(unitId: unitId),
              ),
            );

          default:
            return MaterialPageRoute(
              builder: (_) => Scaffold(
                body: Center(child: Text('Page not found')),
              ),
            );
        }
      },
    );
  }
}
