import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:operatortracker/core/session/SessionManager.dart';
import '../bloc/chat_bloc.dart';
import '../bloc/chat_event.dart';
import '../bloc/chat_state.dart';
import '../../../../core/di/injection.dart';

class ChatPage extends StatefulWidget {
  final String unitId;

  ChatPage({required this.unitId});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: Text('Chat')),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) {
                  if (state is ChatLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is ChatLoaded) {
                    return Container(
                      color: Colors.black87,
                      child: ListView.builder(
                        reverse: true,
                        itemCount: state.messages.length,
                        itemBuilder: (_, i) {
                          final msg = state.messages[i];
                          final isMe =
                              msg.senderNik == sl<SessionManager>().nik;

                          return Align(
                            alignment:
                                isMe
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 8,
                              ),
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.yellow[400],
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16),
                                  bottomLeft: Radius.circular(isMe ? 16 : 0),
                                  bottomRight: Radius.circular(isMe ? 0 : 16),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    msg.senderNik,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    msg.message,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    _formatDate(msg.createdAt),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return Center(child: Text('No messages.'));
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      onSubmitted: (text) {
                        _sendMessage(context, text);
                      },
                      decoration: InputDecoration(
                        hintText: 'Type a message',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      _sendMessage(context, _controller.text);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendMessage(BuildContext context, String text) {
    if (text.trim().isEmpty) return;
    context.read<ChatBloc>().add(
      SendChatMessageEvent(widget.unitId, text.trim()),
    );
    _controller.clear();
  }

  String _formatDate(DateTime date) {
    final months = [
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
    final day = date.day.toString().padLeft(2, '0');
    final month = months[date.month - 1];
    final year = date.year;
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return '$day $month $year, $hour:$minute';
  }
}
