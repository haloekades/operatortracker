import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:operatortracker/features/home/presentation/pages/home_page.dart';
import '../bloc/login_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _nikController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => HomePage(loginEntity: state.user)),
                    (Route<dynamic> route) => false,
              );
            } else if (state is LoginError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Login by Code",
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 42),
                Text("Enter Your NIK", style: TextStyle(fontSize: 24)),
                SizedBox(height: 12),
                IntrinsicWidth(
                  child: Column(
                    children: [
                      ConstrainedBox(
                        constraints: const BoxConstraints(minWidth: 400),
                        child: TextField(
                          controller: _nikController,
                          decoration: const InputDecoration(
                            labelText: 'NIK',
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ),

                      state is LoginError
                          ? Text(
                            "Can't find your NIK",
                            style: TextStyle(fontSize: 20, color: Colors.red),
                          )
                          : const SizedBox(),
                      const SizedBox(height: 16),
                      ConstrainedBox(
                        constraints: const BoxConstraints(minWidth: 400),
                        child:
                            state is LoginLoading
                                ? const Center(
                                  child: SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                                : ElevatedButton(
                                  onPressed: () {
                                    final nik = _nikController.text.trim();
                                    context.read<LoginBloc>().add(
                                      LoginSubmitted(nik),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    minimumSize: const Size.fromHeight(
                                      50,
                                    ),
                                  ),
                                  child: const Text('Login'),
                                ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 46),
              ],
            );
          },
        ),
      ),
    );
  }
}
