import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:operatortracker/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:operatortracker/features/chat/presentation/bloc/chat_event.dart';
import 'package:operatortracker/features/chat/presentation/pages/chat_page.dart';
import 'package:operatortracker/features/home/presentation/bloc/home_bloc.dart';
import 'package:operatortracker/features/home/presentation/bloc/home_event.dart';
import 'package:operatortracker/features/home/presentation/pages/home_page.dart';
import 'package:operatortracker/features/login/domain/entities/login_entity.dart';
import 'package:operatortracker/features/login/presentation/bloc/login_bloc.dart';
import 'package:operatortracker/features/login/presentation/pages/login_page.dart';
import 'core/di/injection.dart' as di;
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
                create: (_) => di.sl<LoginBloc>()..add(LoginStarted()),
                child: LoginPage(),
              ),
            );

          case '/home':
            final loginEntity = settings.arguments as LoginEntity;
            return MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (context) => di.sl<HomeBloc>()..add(HomeStarted(loginEntity)),
                child: HomePage(loginEntity: loginEntity),
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
