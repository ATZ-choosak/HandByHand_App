import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hand_by_hand_app/auth_bloc/bloc/auth_bloc.dart';
import 'package:hand_by_hand_app/components/alert_message.dart';
import 'package:hand_by_hand_app/components/circle_top.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({
    super.key,
  });

  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void submit() async {
      if (!_formKey.currentState!.validate()) {
        return;
      } else {
        _formKey.currentState!.save();
        context.read<AuthBloc>().add(ResetPasswordEvent(emailController.text));
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
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
                  "images/forgot_password.svg",
                  height: 200,
                  width: double.infinity,
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "รีเซ็ตรหัสผ่าน",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                    "กรอกอีเมลของคุณเพื่อรับลิงค์สำหรับการรีเซ็ตรหัสผ่าน"),
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Form(
                    key: _formKey,
                    child: EmailInput(
                      emailController: emailController,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 90,
                      child: ElevatedButton(
                        onPressed: () => submit(),
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            backgroundColor: Theme.of(context).primaryColor,
                            foregroundColor: Colors.white),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("ต่อไป"),
                            BlocBuilder<AuthBloc, AuthState>(
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

                                if (state is AuthResetPasswordSuccess) {
                                  AlertMessage.alert(
                                      "แจ้งเตือน", state.message, context);
                                }

                                if (state is AuthFailure) {
                                  AlertMessage.alert(
                                      "แจ้งเตือน", state.error, context);
                                }

                                return const Icon(Icons.arrow_forward);
                              },
                            )
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


