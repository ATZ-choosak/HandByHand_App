import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_by_hand_app/presentation/bloc/auth_bloc/bloc/auth_bloc.dart';
import 'package:hand_by_hand_app/presentation/widgets/circle_top.dart';
import 'package:hand_by_hand_app/presentation/widgets/custom_button.dart';
import 'package:hand_by_hand_app/presentation/widgets/custom_input.dart';
import 'package:hand_by_hand_app/presentation/view/survey/category_survey.dart';

class FirstProfileSetting extends StatelessWidget {
  FirstProfileSetting({super.key});

  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void submit() async {
      await Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => const CategorySurvey(),
        ),
        (Route<dynamic> route) => false,
      );
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Stack(children: [
            const CircleTop(),
            SizedBox(
              width: double.infinity,
              child: Container(
                margin: const EdgeInsets.only(top: 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const ProfilePicture(),
                    Container(
                      padding: const EdgeInsets.all(40),
                      child: Form(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomInput(
                                inputController: _nameController,
                                icon: const Icon(Icons.person_outlined),
                                hintText: "John smith",
                                labelText: "ชื่อ",
                                validateText: "กรุณากรอกชื่อ"),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomInput(
                                inputController: _nameController,
                                icon: const Icon(Icons.phone_outlined),
                                hintText: "080-880-8118",
                                labelText: "เบอร์โทร",
                                validateText: "กรุณากรอกชื่อ"),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomInput(
                                inputController: _nameController,
                                icon: const Icon(Icons.pin_drop_outlined),
                                hintText: "123 ถนน 4 ซอย 9 อำเภอ...",
                                labelText: "ที่อยู่",
                                validateText: "กรุณากรอกชื่อ"),
                            const SizedBox(
                              height: 50,
                            ),
                            CustomButton(
                              submit: submit,
                              buttonText: "สร้างโปรไฟล์",
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ]),
        ));
  }
}

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    void updateProfileImage() {
      context.read<AuthBloc>().add(UpdateProfileImageEvent());
    }

    return Stack(
      children: [
        Container(
          width: 180,
          height: 180,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
              border: Border.all(
                  width: 5,
                  color: Colors.white,
                  strokeAlign: BorderSide.strokeAlignOutside),
              borderRadius: BorderRadius.circular(100),
              color: Colors.white),
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthUpdateProfileImageSuccess) {
                return Image.file(
                  state.image,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                );
              }
              return const SizedBox();
            },
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: ElevatedButton(
            style: const ButtonStyle(
                shape: WidgetStatePropertyAll(CircleBorder()),
                backgroundColor: WidgetStatePropertyAll(Colors.white)),
            onPressed: updateProfileImage,
            child: Icon(
              Icons.add,
              color: Theme.of(context).primaryColor,
            ),
          ),
        )
      ],
    );
  }
}
