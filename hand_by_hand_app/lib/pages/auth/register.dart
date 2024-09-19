import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:hand_by_hand_app/pages/auth/login.dart';

class Register extends StatelessWidget {
  const Register({super.key});

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
          child: RegisterForm(),
        ),
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({
    super.key,
  });

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _nameController = TextEditingController();

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
      }
    }

    return SafeArea(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "สร้างบัญชี",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                  icon: const Icon(Icons.person_outlined),
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  labelText: "ชื่อ",
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor)),
                  floatingLabelStyle:
                      TextStyle(color: Theme.of(context).primaryColor)),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "กรุณากรอกชื่อ";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                  icon: const Icon(Icons.email_outlined),
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
              height: 10,
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
              height: 10,
            ),
            TextFormField(
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              decoration: InputDecoration(
                  icon: const Icon(Icons.lock_outline),
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  labelText: "ยืนยันรหัสผ่าน",
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor)),
                  floatingLabelStyle:
                      TextStyle(color: Theme.of(context).primaryColor)),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "กรุณากรอกรหัสผ่าน";
                }

                if (value != _passwordController.text) {
                  return "รหัสผ่านไม่ตรงกัน";
                }
                return null;
              },
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
                        const Text("สร้างบัญชี"),
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
                  "มีบัญชีผู้ใช้แล้ว?",
                  style: TextStyle(color: Theme.of(context).primaryColorDark),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const Login(),
                          ));
                    },
                    style: const ButtonStyle(
                      overlayColor: WidgetStatePropertyAll(
                        Colors.transparent,
                      ),
                    ),
                    child: Text(
                      "เข้าสู่ระบบ",
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
