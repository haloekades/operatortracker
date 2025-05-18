import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:operatortracker/core/services/websocket_service.dart';
import 'package:operatortracker/features/chat/presentation/pages/chat_page.dart';
import 'package:operatortracker/features/home/presentation/bloc/home_bloc.dart';
import 'package:operatortracker/features/home/presentation/bloc/home_event.dart';
import 'package:operatortracker/features/home/presentation/bloc/home_state.dart';
import 'package:operatortracker/features/login/domain/entities/login_entity.dart';

class HomePage extends StatelessWidget {
  final LoginEntity loginEntity;

  const HomePage({Key? key, required this.loginEntity}) : super(key: key);

  void _logout(BuildContext context) {
    context.read<HomeBloc>().add(HomeLogout());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeExit) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/login',
              (route) => false,
            );
          }
        },
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is HomeLoaded) {
              return Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      'assets/dummy_maps.png',
                      fit: BoxFit.cover,
                    ),
                  ),

                  Positioned(
                    top: 40,
                    right: 24,
                    child: FloatingActionButton(
                      heroTag: 'menu_fab',
                      backgroundColor: Colors.red,
                      onPressed: () => _logout(context),
                      child: const Icon(Icons.logout),
                    ),
                  ),

                  Positioned(
                    top: 40,
                    left: 20,
                    right: 120,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Name: ${loginEntity.name}',
                            style: _textStyle(),
                          ),
                          Text(
                            'Role: ${loginEntity.roleName}',
                            style: _textStyle(),
                          ),
                          Text(
                            'Email: ${loginEntity.email}',
                            style: _textStyle(),
                          ),
                          Text(
                            'Phone: ${loginEntity.phone}',
                            style: _textStyle(),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: 24,
                    right: 100,
                    child: FloatingActionButton(
                      heroTag: 'chat_fab',
                      backgroundColor: Colors.blue,
                      onPressed:
                          () => {
                            Navigator.pushNamed(
                              context,
                              '/chat',
                              arguments: loginEntity.unitId,
                            ),
                          },
                      child: const Icon(Icons.chat),
                    ),
                  ),

                  Positioned(
                    bottom: 24,
                    right: 24,
                    child: FloatingActionButton(
                      heroTag: 'menu_fab',
                      backgroundColor: Colors.blue,
                      onPressed: () => _showActivityMenu(context),
                      child: const Icon(Icons.menu),
                    ),
                  ),

                  if (state.message != null)
                    AlertDialog(
                      backgroundColor: Colors.black87,
                      title: const Text(
                        'New Message',
                        style: TextStyle(color: Colors.white),
                      ),
                      content: ConstrainedBox(
                        constraints: const BoxConstraints(minWidth: 700),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.yellow[900],
                            borderRadius: BorderRadius.circular(24),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.warning, color: Colors.white),
                                  const SizedBox(width: 12),
                                  Text(
                                    '${state.message?.senderName ?? ''} (${state.message?.senderNik ?? ''})',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                state.message?.message ?? '',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                formatDateTime(state.message?.createdAt),
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            context.read<HomeBloc>().add(
                              HomeStarted(loginEntity),
                            );
                          },
                          child: const Text(
                            'Balas Nanti',
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            context.read<HomeBloc>().add(
                              HomeStarted(loginEntity),
                            );
                          },
                          child: const Text(
                            'Mengerti',
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          ),
                        ),
                      ],
                    ),
                ],
              );
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }

  TextStyle _textStyle() => const TextStyle(color: Colors.white, fontSize: 16);

  void _showActivityMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        final activities = [
          'Idle',
          'Hauling',
          'Loading',
          'Hanging',
          'Dumping',
          'Queuing',
          'Maintenance',
        ];

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: activities.length,
          itemBuilder: (_, index) {
            return ListTile(
              leading: const Icon(Icons.radio_button_unchecked),
              title: Text(activities[index]),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Selected: ${activities[index]}')),
                );
              },
            );
          },
          separatorBuilder: (_, __) => const Divider(),
        );
      },
    );
  }

  String getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }

  String formatDateTime(DateTime? dateTime) {
    if (dateTime != null) {
      String day = dateTime.day.toString().padLeft(2, '0');
      String month = getMonthName(dateTime.month);
      String year = dateTime.year.toString();
      String hour = dateTime.hour.toString().padLeft(2, '0');
      String minute = dateTime.minute.toString().padLeft(2, '0');

      return '$day $month $year, $hour:$minute';
    } else {
      return "";
    }
  }
}
