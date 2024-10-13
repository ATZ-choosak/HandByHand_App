import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_by_hand_app/module/page_route_not_return.dart';
import 'package:hand_by_hand_app/presentation/bloc/auth_bloc/bloc/auth_bloc.dart';
import 'package:hand_by_hand_app/presentation/view/login_page.dart';
import 'package:hand_by_hand_app/presentation/widgets/custom_button.dart';
import 'package:hand_by_hand_app/presentation/widgets/custom_scaffold.dart';

class AccountSetting extends StatelessWidget {
  const AccountSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        appBar: AppBar(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              const Text(
                "ตั้งค่าบัญชี",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              CustomButton(
                buttonText: "ออกจากระบบ",
                submit: () {
                  context.read<AuthBloc>().add(LogoutEvent());
                  pageRouteNotReturn(context, const LoginPage());
                },
                useIcon: false,
              )
            ],
          ),
        ));
  }
}
