// ignore_for_file: avoid_print

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:hand_by_hand_app/api/dio_service.dart';
import 'package:hand_by_hand_app/api/auth/auth_response.dart';
import 'package:hand_by_hand_app/components/alert_message.dart';
import 'package:hand_by_hand_app/pages/auth/register.dart';
import 'package:hand_by_hand_app/pages/feed.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.all(35),
        child: const SingleChildScrollView(
          child: LoginForm(),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    void submit() async {
      if (!_formKey.currentState!.validate()) {
        return;
      } else {
        _formKey.currentState!.save();

        setState(() {
          loading = true;
        });

        AuthResponse response = await DioService()
            .login(_emailController.text, _passwordController.text);

        if (context.mounted) {
          if (response.status) {
            await Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (_) => const Feed(),
              ),
              (Route<dynamic> route) => false,
            );
          } else {
            AlertMessage.alert(
                "แจ้งเตือน", response.message, context);
          }
          setState(() {
            loading = false;
          });
        }
      }
    }

    return SafeArea(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "เข้าสู่ระบบ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "กรุณาเข้าสู่ระบบเพื่อดำเนินการ",
              style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 60,
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                  icon: const Icon(Icons.email_outlined),
                  hintText: "abc@example.com",
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  labelText: "อีเมล",
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor)),
                  floatingLabelStyle:
                      TextStyle(color: Theme.of(context).primaryColor)),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "กรุณากรอกอีเมล";
                }

                if (!EmailValidator.validate(value)) {
                  return "กรุณากรอกอีเมลให้ถูกต้อง";
                }

                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _passwordController,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              decoration: InputDecoration(
                  icon: const Icon(Icons.lock_outline),
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  labelText: "รหัสผ่าน",
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor)),
                  floatingLabelStyle:
                      TextStyle(color: Theme.of(context).primaryColor)),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "กรุณากรอกรหัสผ่าน";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  "ลืมรหัสผ่าน?",
                  style: TextStyle(color: Theme.of(context).primaryColorDark),
                ),
                TextButton(
                    onPressed: () {},
                    style: const ButtonStyle(
                      overlayColor: WidgetStatePropertyAll(
                        Colors.transparent,
                      ),
                    ),
                    child: Text(
                      "รีเซ็ตรหัสผ่าน",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ))
              ],
            ),
            const SizedBox(
              height: 80,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 130,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () => submit(),
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text("เข้าสู่ระบบ"),
                        loading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : const Icon(Icons.arrow_forward),
                      ],
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 90,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "ยังไม่มีบัญชีผู้ใช้?",
                  style: TextStyle(color: Theme.of(context).primaryColorDark),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const Register(),
                          ));
                    },
                    style: const ButtonStyle(
                      overlayColor: WidgetStatePropertyAll(
                        Colors.transparent,
                      ),
                    ),
                    child: Text(
                      "สร้างบัญชี",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
