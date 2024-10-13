// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:hand_by_hand_app/data/models/user/user_model.dart';
import 'package:hand_by_hand_app/module/image_path.dart';
import 'package:hand_by_hand_app/presentation/widgets/avartar_no_image.dart';

class ProfileImageCircle extends StatelessWidget {
  const ProfileImageCircle(
      {super.key, required this.profileImage, required this.name, this.radius});

  final ProfileImage? profileImage;
  final String name;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return profileImage != null
        ? CircleAvatar(
            radius: radius,
            backgroundImage: NetworkImage(imagePath(profileImage!.url)),
            onBackgroundImageError: (exception, stackTrace) {
              print("Image not loaded.");
            },
          )
        : AvatarNoImage(
            radius: radius,
            username: name,
            fontSize: radius,
          );
  }
}
