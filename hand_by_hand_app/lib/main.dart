import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hand_by_hand_app/presentation/bloc/additem_bloc/bloc/additem_bloc.dart';
import 'package:hand_by_hand_app/data/source/token_service.dart';
import 'package:hand_by_hand_app/presentation/bloc/auth_bloc/bloc/auth_bloc.dart';
import 'package:hand_by_hand_app/presentation/bloc/category_bloc/bloc/category_bloc.dart';
import 'package:hand_by_hand_app/mockup/category/category_mockup.dart';
import 'package:hand_by_hand_app/presentation/view/onboarding/onboarding.dart';
import 'package:hand_by_hand_app/presentation/view/survey/first_profile_setting.dart';
import 'package:hand_by_hand_app/service_locator.dart.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MainApp());
  });
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<AuthBloc>(),
        ),
        BlocProvider(
          create: (context) => CategoryBloc(CategoryMockup().getCategory()),
        ),
        BlocProvider(
          create: (context) => AdditemBloc(
              CategoryMockup().getCategory(), CategoryMockup().getCategory()),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: const Color(0xfff0b000),
              secondary: const Color.fromARGB(255, 54, 171, 157),
              surface: Colors.white),
          scaffoldBackgroundColor: Colors.white,
          brightness: Brightness.light,
          visualDensity: VisualDensity.standard,
          primaryColor: const Color(0xfff0b000),
          primaryColorLight: const Color.fromARGB(255, 54, 171, 157),
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
                  return FirstProfileSetting();
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
