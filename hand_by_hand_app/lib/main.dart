import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hand_by_hand_app/api/auth/auth_service.dart';
import 'package:hand_by_hand_app/api/token_service.dart';
import 'package:hand_by_hand_app/auth_bloc/bloc/auth_bloc.dart';
import 'package:hand_by_hand_app/onboarding/onboarding.dart';
import 'package:hand_by_hand_app/pages/feed.dart';
import 'package:hand_by_hand_app/singleton/api_instance.dart';

void main() {
  setupLocaltor();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(auth: AuthService()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.white,
          brightness: Brightness.light,
          visualDensity: VisualDensity.standard,
          primaryColor: const Color(0xfff0b000),
          primaryColorLight: const Color(0xfff0b000),
          primaryColorDark: const Color(0xff5e5e5e),
          textTheme: GoogleFonts.notoSansThaiTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home: Scaffold(
          body: Center(
              child: FutureBuilder(
            future: TokenService.getAccessToken(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.isNotEmpty) {
                  return const Feed();
                } else {
                  return const CircularProgressIndicator();
                }
              } else {
                return const Onboarding();
              }
            },
          )),
        ),
      ),
    );
  }
}
