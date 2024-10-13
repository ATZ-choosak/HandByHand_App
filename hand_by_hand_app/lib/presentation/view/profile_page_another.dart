import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_by_hand_app/data/models/user/user_model.dart';
import 'package:hand_by_hand_app/module/page_route.dart';
import 'package:hand_by_hand_app/presentation/bloc/auth_bloc/bloc/auth_bloc.dart';
import 'package:hand_by_hand_app/presentation/view/account_setting.dart';
import 'package:hand_by_hand_app/presentation/view/profile_setting.dart';
import 'package:hand_by_hand_app/presentation/widgets/alert_message.dart';
import 'package:hand_by_hand_app/presentation/widgets/custom_button.dart';
import 'package:hand_by_hand_app/presentation/widgets/profile_image_circle.dart';

class ProfilePageAnother extends StatelessWidget {
  const ProfilePageAnother({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AuthBloc>(context).add(GetMeEvent());

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is GetMeLoading) {
          return const CircularProgressIndicator();
        }

        if (state is GetMeSuccess) {
          return Profile(
            user: state.getMe,
          );
        }

        if (state is GetMeFailure) {
          AlertMessage.alert("แจ้งเตือน", state.message, context);
        }

        return const CircularProgressIndicator();
      },
    );
  }
}

class Profile extends StatelessWidget {
  const Profile({
    super.key,
    required this.user,
  });

  final UserGetMe user;

  final double coverHeight = 200;
  final double profileHeight = 144;

  @override
  Widget build(BuildContext context) {
    final double top = coverHeight - profileHeight / 2;

    return SizedBox(
      height: double.maxFinite,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            width: MediaQuery.of(context).size.width,
            child: BackgroundCover(
              coverHeight: coverHeight,
            ),
          ),
          Positioned(
              top: top,
              width: MediaQuery.of(context).size.width,
              child: ProfileDetail(
                user: user,
                profileHeight: profileHeight / 2,
              )),
        ],
      ),
    );
  }
}

class BackgroundCover extends StatelessWidget {
  const BackgroundCover({
    super.key,
    required this.coverHeight,
  });

  final double coverHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: coverHeight,
      padding: const EdgeInsets.all(20),
      color: Theme.of(context).primaryColor,
    );
  }
}

class ProfileDetail extends StatelessWidget {
  const ProfileDetail({
    super.key,
    required this.user,
    required this.profileHeight,
  });

  final UserGetMe user;

  final double profileHeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
              border: Border.fromBorderSide(
                  BorderSide(color: Colors.white, width: 5)),
              borderRadius: BorderRadius.all(Radius.circular(100))),
          child: ProfileImageCircle(
            profileImage: user.profileImage,
            name: user.name,
            radius: profileHeight,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          user.name,
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColorLight),
        ),
        const SizedBox(
          height: 20,
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PostLabel(),
            SizedBox(
              width: 50,
            ),
            CompleteLabel(),
            SizedBox(
              width: 50,
            ),
            ReviewLabel()
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        ProfileMenu(
          me: user,
        ),
      ],
    );
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    super.key,
    required this.me,
  });

  final UserGetMe me;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomButton(
          buttonText: "แก้ไขโปรไฟล์",
          submit: () {
            pageRoute(context, ProfileSetting(me: me));
          },
          useIcon: false,
          width: 100,
          height: 40,
        ),
        const SizedBox(
          width: 10,
        ),
        CustomButton(
          buttonText: "ตั้งค่าบัญชี",
          submit: () {
            pageRoute(context, const AccountSetting());
          },
          useIcon: false,
          width: 100,
          height: 40,
        )
      ],
    );
  }
}

class Separate extends StatelessWidget {
  const Separate({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey[300],
      ),
    );
  }
}

class ReviewLabel extends StatelessWidget {
  const ReviewLabel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "4.5",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
        const Text("รีวิว")
      ],
    );
  }
}

class CompleteLabel extends StatelessWidget {
  const CompleteLabel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "3",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColorLight,
          ),
        ),
        const Text("สำเร็จ")
      ],
    );
  }
}

class PostLabel extends StatelessWidget {
  const PostLabel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "12",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColorLight,
          ),
        ),
        const Text("โพสต์")
      ],
    );
  }
}
