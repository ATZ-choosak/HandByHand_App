import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hand_by_hand_app/presentation/view/auth/login.dart';
import 'package:hand_by_hand_app/presentation/view/auth/register.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SvgPicture.asset(
                "images/login_image.svg",
                height: 300,
              ),
              Text(
                "Welcome To\nHand by Hand",
                style: TextStyle(
                    fontSize: 26,
                    color: Theme.of(context).primaryColorDark,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "ยินดีต้อนรับสู่ Hand by Hand\nแอปพลิเคชันที่ช่วยให้คุณสามารถแลกเปลี่ยนสิ่งของ\nที่ยังใช้งานได้กับผู้คนในชุมชนของคุณ!",
                style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                    fontSize: 12,
                    height: 2),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                      backgroundColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100))),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const Register(),
                        ));
                  },
                  child: const Text(
                    "สร้างบัญชี",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(16.0),
                    side: BorderSide(
                        width: 2, color: Theme.of(context).primaryColorLight),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const Login(),
                        ));
                  },
                  child: Text(
                    "เข้าสู่ระบบ",
                    style: TextStyle(
                      color: Theme.of(context).primaryColorLight,
                      fontSize: 14,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
