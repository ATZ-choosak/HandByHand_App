// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_by_hand_app/data/models/user/user_model.dart';
import 'package:hand_by_hand_app/presentation/bloc/auth_bloc/bloc/auth_bloc.dart';
import 'package:hand_by_hand_app/presentation/widgets/alert_message.dart';
import 'package:hand_by_hand_app/presentation/widgets/avartar_no_image.dart';
import 'package:hand_by_hand_app/presentation/widgets/button_loading.dart';
import 'package:hand_by_hand_app/presentation/widgets/circle_top.dart';
import 'package:hand_by_hand_app/presentation/widgets/custom_button.dart';
import 'package:hand_by_hand_app/presentation/widgets/custom_input.dart';
import 'package:hand_by_hand_app/presentation/widgets/profile_image_circle.dart';

class ProfileSetting extends StatelessWidget {
  const ProfileSetting({super.key, required this.me});

  final UserGetMe me;

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: me.name);

    final phoneController = TextEditingController(text: me.phone);

    final addressController = TextEditingController(text: me.address);

    final formKey = GlobalKey<FormState>();

    void submit() async {
      if (!formKey.currentState!.validate()) {
        return;
      } else {
        formKey.currentState!.save();

        if (context.mounted) {
          context.read<AuthBloc>().add(UpdateProfileEvent(
                username: nameController.text,
                phone: phoneController.text,
                address: addressController.text,
              ));
        }
      }
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Stack(alignment: Alignment.center, children: [
            const CircleTop(),
            SizedBox(
              width: double.infinity,
              child: Container(
                margin: const EdgeInsets.only(top: 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ProfilePicture(
                      nameController: nameController,
                      image: me.profileImage,
                    ),
                    Container(
                      padding: const EdgeInsets.all(40),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomInput(
                                inputController: nameController,
                                icon: const Icon(Icons.person_outlined),
                                hintText: "John smith",
                                labelText: "ชื่อ",
                                validateText: "กรุณากรอกชื่อ"),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomInput(
                                inputController: phoneController,
                                icon: const Icon(Icons.phone_outlined),
                                hintText: "080-880-8118",
                                labelText: "เบอร์โทร",
                                validateText: "กรุณากรอกเบอร์โทร"),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomInput(
                                inputController: addressController,
                                icon: const Icon(Icons.pin_drop_outlined),
                                hintText: "บ้านเลขที่ 100 ถนน ....",
                                labelText: "ที่อยู่",
                                validateText: "กรุณากรอกที่อยู่"),
                            const SizedBox(
                              height: 50,
                            ),
                            BlocBuilder<AuthBloc, AuthState>(
                              builder: (context, state) {
                                if (state is AuthUpdateProfileLoading) {
                                  return const ButtonLoading();
                                }

                                if (state is AuthUpdateProfileFailure) {
                                  AlertMessage.alert(
                                      "แจ้งเตือน", state.message, context);
                                }

                                if (state is AuthUpdateProfileSuccess) {
                                  context.read<AuthBloc>().add(GetMeEvent());

                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    Navigator.pop(context);
                                  });
                                }

                                return CustomButton(
                                  submit: submit,
                                  buttonText: "อัพเดทโปรไฟล์",
                                );
                              },
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

class ProfilePicture extends StatefulWidget {
  const ProfilePicture({
    super.key,
    required this.nameController,
    required this.image,
  });

  final TextEditingController nameController;

  final ProfileImage? image;

  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  String username = "";

  @override
  void initState() {
    super.initState();
    widget.nameController.addListener(() {
      setState(() {
        username = widget.nameController.text;
      });
    });
  }

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
            buildWhen: (previous, current) {
              return current is AuthUpdateProfileImageSuccess;
            },
            builder: (context, state) {
              if (state is AuthUpdateProfileImageSuccess) {
                return Image.file(
                  state.image,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                );
              }

              if (widget.image != null) {
                return ProfileImageCircle(
                    profileImage: widget.image, name: username);
              }

              return AvatarNoImage(
                username: username,
              );
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
