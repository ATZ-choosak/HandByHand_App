import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_by_hand_app/data/models/user/user_model.dart';
import 'package:hand_by_hand_app/presentation/bloc/auth_bloc/bloc/auth_bloc.dart';
import 'package:hand_by_hand_app/presentation/widgets/alert_message.dart';
import 'package:hand_by_hand_app/presentation/widgets/profile_image_circle.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 200,
          padding: const EdgeInsets.all(20),
          color: Theme.of(context).primaryColorLight,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: const BoxDecoration(
                      border: Border.fromBorderSide(
                          BorderSide(color: Colors.white, width: 5)),
                      borderRadius:
                          BorderRadius.all(Radius.circular(100))),
                  child: ProfileImageCircle(
                    profileImage: user.profileImage,
                    name: user.name,
                    radius: 80,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  user.name,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(user.email),
                //  Container(width: double.infinity,
                // height: 0.8,
                // color: Colors.grey[200],
                // )
                TextButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(LogoutEvent());
                    },
                    child: const Text("ออกจากระบบ"))
              ],
            ),
          ],
        ),
      ],
    );
  }
}
