// ignore_for_file: avoid_print

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:hand_by_hand_app/module/page_route_not_return.dart';
import 'package:hand_by_hand_app/presentation/bloc/auth_bloc/bloc/auth_bloc.dart';
import 'package:hand_by_hand_app/presentation/widgets/alert_message.dart';
import 'package:hand_by_hand_app/presentation/widgets/custom_button.dart';
import 'package:hand_by_hand_app/presentation/widgets/custom_scaffold.dart';
import 'package:hand_by_hand_app/presentation/view/auth/register.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_by_hand_app/presentation/view/confirm_email.dart';
import 'package:hand_by_hand_app/presentation/view/feed.dart';
import 'package:hand_by_hand_app/presentation/view/forgot_password.dart';
import 'package:hand_by_hand_app/presentation/view/survey/first_profile_setting.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      child: Container(
        padding: const EdgeInsets.all(35),
        child: SingleChildScrollView(
          child: LoginForm(),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  LoginForm({
    super.key,
  });

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void submit() async {
      if (!_formKey.currentState!.validate()) {
        return;
      } else {
        _formKey.currentState!.save();
        context
            .read<AuthBloc>()
            .add(LoginEvent(_emailController.text, _passwordController.text));
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
            EmailInput(emailController: _emailController),
            const SizedBox(
              height: 20,
            ),
            PasswordInput(passwordController: _passwordController),
            const SizedBox(
              height: 20,
            ),
            const ForgotPasswordButton(),
            const SizedBox(
              height: 80,
            ),
            LoginButton(
              submit: submit,
              buttonText: "เข้าสู่ระบบ",
            ),
            const SizedBox(
              height: 90,
            ),
            const CreateAccount(),
          ],
        ),
      ),
    );
  }
}

class CreateAccount extends StatelessWidget {
  const CreateAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
                  color: Theme.of(context).primaryColorLight,
                  fontWeight: FontWeight.bold),
            ))
      ],
    );
  }
}

class LoginButton extends CustomButton {
  const LoginButton(
      {super.key,
      required super.submit,
      super.disabled = false,
      required super.buttonText});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          height: 50,
          child: ElevatedButton(
            onPressed: () => submit(),
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white),
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthLoading) {
                  return const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  );
                }

                if (state is AuthLoginSuccess) {
                  if (state.auth.isFirstLogin) {
                    pageRouteNotReturn(context, const Feed());
                  } else {
                    pageRouteNotReturn(context, FirstProfileSetting());
                  }
                }

                if (state is AuthFailure) {
                  AlertMessage.alert("แจ้งเตือน", state.error, context);
                }

                if (state is AuthEmailNotVerify) {
                  WidgetsBinding.instance.addPostFrameCallback((_) async {
                    await Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ConfirmEmail(),
                      ),
                      (Route<dynamic> route) => false,
                    );
                  });
                }

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(buttonText),
                    const SizedBox(
                      width: 20,
                    ),
                    const Icon(Icons.arrow_forward)
                  ],
                );
              },
            ),
          ),
        )
      ],
    );
  }
}

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "ลืมรหัสผ่าน?",
          style: TextStyle(color: Theme.of(context).primaryColorDark),
        ),
        TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ForgotPassword(),
                ),
              );
            },
            style: const ButtonStyle(
              overlayColor: WidgetStatePropertyAll(
                Colors.transparent,
              ),
            ),
            child: Text(
              "รีเซ็ตรหัสผ่าน",
              style: TextStyle(
                  color: Theme.of(context).primaryColorLight,
                  fontWeight: FontWeight.bold),
            ))
      ],
    );
  }
}

class PasswordInput extends StatelessWidget {
  const PasswordInput({
    super.key,
    required TextEditingController passwordController,
  }) : _passwordController = passwordController;

  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _passwordController,
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      decoration: InputDecoration(
          icon: const Icon(Icons.lock_outline),
          hintStyle: TextStyle(color: Colors.grey[500]),
          labelText: "รหัสผ่าน",
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          floatingLabelStyle: TextStyle(color: Theme.of(context).primaryColor)),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "กรุณากรอกรหัสผ่าน";
        }
        return null;
      },
    );
  }
}

class EmailInput extends StatelessWidget {
  const EmailInput({
    super.key,
    required TextEditingController emailController,
  }) : _emailController = emailController;

  final TextEditingController _emailController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _emailController,
      decoration: InputDecoration(
          icon: const Icon(Icons.email_outlined),
          hintText: "abc@example.com",
          hintStyle: TextStyle(color: Colors.grey[500]),
          labelText: "อีเมล",
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          floatingLabelStyle: TextStyle(color: Theme.of(context).primaryColor)),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "กรุณากรอกอีเมล";
        }

        if (!EmailValidator.validate(value)) {
          return "กรุณากรอกอีเมลให้ถูกต้อง";
        }

        return null;
      },
    );
  }
}
