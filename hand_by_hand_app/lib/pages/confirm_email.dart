import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hand_by_hand_app/pages/auth/login.dart';

class ConfirmEmail extends StatelessWidget {
  const ConfirmEmail({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const CircleTop(),
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                ),
                SvgPicture.asset(
                  "images/mail_sent.svg",
                  height: 200,
                  width: double.infinity,
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "ยืนยันอีเมลของคุณ",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text("เราได้ส่งลิงค์สำหรับยืนยันอีเมล ไปยัง :"),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  email,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  "เช็ค inbox ของคุณ\nคลิกยืนยันอีเมล เพื่อดำเนินการต่อ",
                  textAlign: TextAlign.center,
                  style: TextStyle(height: 2),
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 130,
                      child: ElevatedButton(
                        onPressed: () async {
                          await Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const Login(),
                            ),
                            (Route<dynamic> route) => false,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            backgroundColor: Theme.of(context).primaryColor,
                            foregroundColor: Colors.white),
                        child: const Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("เข้าสู่ระบบ"),
                            Icon(Icons.arrow_forward)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CircleTop extends StatelessWidget {
  const CircleTop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -380,
      left: -100,
      child: Container(
        width: 560,
        height: 560,
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor, shape: BoxShape.circle),
      ),
    );
  }
}
