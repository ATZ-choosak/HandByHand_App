import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_by_hand_app/presentation/bloc/auth_bloc/bloc/auth_bloc.dart';
import 'package:hand_by_hand_app/presentation/view/login_page.dart';

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    void logout() async {
      context.read<AuthBloc>().add(LogoutEvent());
      if (context.mounted) {
        await Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => const LoginPage(),
          ),
          (Route<dynamic> route) => false,
        );
      }
    }

    return Scaffold(
        body: Center(
      child: ElevatedButton(onPressed: logout, child: const Text("Logout")),
    ));
  }
}
