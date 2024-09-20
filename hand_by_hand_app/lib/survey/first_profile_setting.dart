import 'package:flutter/material.dart';
import 'package:hand_by_hand_app/components/circle_top.dart';
import 'package:hand_by_hand_app/components/custom_button.dart';
import 'package:hand_by_hand_app/components/custom_input.dart';
import 'package:hand_by_hand_app/survey/category_survey.dart';

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
    return Stack(
      children: [
        Container(
          width: 180,
          height: 180,
          decoration: BoxDecoration(
              border: Border.all(width: 3, color: Colors.white),
              borderRadius: BorderRadius.circular(100),
              color: Theme.of(context).primaryColorLight),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: ElevatedButton(
            style: const ButtonStyle(
                shape: WidgetStatePropertyAll(CircleBorder()),
                backgroundColor: WidgetStatePropertyAll(Colors.white)),
            onPressed: () {},
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
