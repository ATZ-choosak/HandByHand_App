import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hand_by_hand_app/presentation/bloc/auth_bloc/bloc/auth_bloc.dart';
import 'package:hand_by_hand_app/presentation/widgets/alert_message.dart';
import 'package:hand_by_hand_app/presentation/widgets/circle_top.dart';
import 'package:hand_by_hand_app/presentation/view/auth/login.dart';

class ConfirmEmail extends StatelessWidget {
  const ConfirmEmail({super.key});

  @override
  Widget build(BuildContext context) {
    final state = BlocProvider.of<AuthBloc>(context).state;
    String email = "abc@gmail.com";

    if (state is AuthRegisterSuccess) {
      email = state.email;
    }

    if (state is AuthEmailNotVerify) {
      email = state.email;
    }

    void resendEmail() {
      context.read<AuthBloc>().add(ResentVerifyEvent(email));
    }

    void toLogin() async {
      context.read<AuthBloc>().add(InitEvent());
      await Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => const Login(),
        ),
        (Route<dynamic> route) => false,
      );
    }

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
                  height: 8,
                ),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        ),
                      );
                    }

                    if (state is AuthResentVerifySuccess) {
                      AlertMessage.alert("แจ้งเตือน", state.message, context);
                    }

                    if (state is AuthResendVerifyFailure) {
                      AlertMessage.alert("แจ้งเตือน", state.error, context);
                    }

                    return TextButton(
                        onPressed: () {
                          resendEmail();
                        },
                        style: const ButtonStyle(
                          overlayColor: WidgetStatePropertyAll(
                            Colors.transparent,
                          ),
                        ),
                        child: Text(
                          "ส่งอีเมลอีกครั้ง",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold),
                        ));
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 130,
                      child: ElevatedButton(
                        onPressed: () {
                          toLogin();
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
