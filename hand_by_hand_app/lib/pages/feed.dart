import 'package:flutter/material.dart';
import 'package:hand_by_hand_app/api/auth/auth_service.dart';
import 'package:hand_by_hand_app/api/user/user_service.dart';
import 'package:hand_by_hand_app/pages/login_page.dart';

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    void logout() async {
      await AuthService().logout();
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
          child: FutureBuilder(
        future: UserService().getMe(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(snapshot.data!.name),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  onPressed: () => logout(),
                  child: const Text("ออกจากระบบ"),
                ),
              ],
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      )),
    );
  }
}
