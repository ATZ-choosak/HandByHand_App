import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_by_hand_app/presentation/bloc/auth_bloc/bloc/auth_bloc.dart';
import 'package:hand_by_hand_app/presentation/widgets/alert_message.dart';
import 'package:hand_by_hand_app/presentation/widgets/custom_scaffold.dart';
import 'package:hand_by_hand_app/presentation/view/auth/login.dart';
import 'package:hand_by_hand_app/presentation/view/confirm_email.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      child: Container(
        padding: const EdgeInsets.all(35),
        child: SingleChildScrollView(
          child: RegisterForm(),
        ),
      ),
    );
  }
}

class RegisterForm extends StatelessWidget {
  RegisterForm({
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
        context.read<AuthBloc>().add(RegisterEvent(_emailController.text,
         _passwordController.text));
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
            EmailInput(emailController: _emailController),
            const SizedBox(
              height: 10,
            ),
            PasswordInput(passwordController: _passwordController),
            const SizedBox(
              height: 10,
            ),
            ConfirmPasswordInput(passwordController: _passwordController),
            const SizedBox(
              height: 80,
            ),
            CreateAccountButton(
              submit: submit,
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
                          color: Theme.of(context).primaryColorLight,
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

class CreateAccountButton extends StatelessWidget {
  const CreateAccountButton({super.key, required this.submit});

  final Function submit;

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
                  if (state is AuthRegisterSuccess) {
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

                  if (state is AuthLoading) {
                    return const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    );
                  }

                  if (state is AUthRegisterFailure) {
                    AlertMessage.alert("แจ้งเตือน", state.error, context);
                    context.read<AuthBloc>().add(InitEvent());
                  }

                  return const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("สร้างบัญชี"),
                      SizedBox(
                        width: 20,
                      ),
                      Icon(Icons.arrow_forward)
                    ],
                  );
                },
              )),
        )
      ],
    );
  }
}

class ConfirmPasswordInput extends StatelessWidget {
  const ConfirmPasswordInput({
    super.key,
    required TextEditingController passwordController,
  }) : _passwordController = passwordController;

  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      decoration: InputDecoration(
          icon: const Icon(Icons.lock_outline),
          hintStyle: TextStyle(color: Colors.grey[500]),
          labelText: "ยืนยันรหัสผ่าน",
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          floatingLabelStyle: TextStyle(color: Theme.of(context).primaryColor)),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "กรุณากรอกรหัสผ่าน";
        }

        if (value != _passwordController.text) {
          return "รหัสผ่านไม่ตรงกัน";
        }
        return null;
      },
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

class NameInput extends StatelessWidget {
  const NameInput({
    super.key,
    required TextEditingController nameController,
  }) : _nameController = nameController;

  final TextEditingController _nameController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _nameController,
      decoration: InputDecoration(
          icon: const Icon(Icons.person_outlined),
          hintStyle: TextStyle(color: Colors.grey[500]),
          labelText: "ชื่อ",
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          floatingLabelStyle: TextStyle(color: Theme.of(context).primaryColor)),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "กรุณากรอกชื่อ";
        }
        return null;
      },
    );
  }
}
