import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hand_by_hand_app/module/page_route_not_return.dart';
import 'package:hand_by_hand_app/presentation/bloc/item_bloc/bloc/item_bloc.dart';
import 'package:hand_by_hand_app/presentation/bloc/auth_bloc/bloc/auth_bloc.dart';
import 'package:hand_by_hand_app/presentation/bloc/category_bloc/bloc/category_bloc.dart';
import 'package:hand_by_hand_app/presentation/view/feed.dart';
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
          create: (context) => getIt<AuthBloc>()..add(GetMeEvent()),
        ),
        BlocProvider(
          create: (context) =>
              getIt<CategoryBloc>()..add(CategoryLoadingEvent()),
        ),
        BlocProvider(
          create: (context) => getIt<ItemBloc>()..add(ItemInitalEvent()),
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
        home: Scaffold(body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {

            print(state);

            if (state is GetMeLoading) {
              
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is GetMeSuccess) {
              if (state.getMe.isFirstLogin) {
                pageRouteNotReturn(context, const Feed());
              } else {
                pageRouteNotReturn(context, FirstProfileSetting());
              }
            }

            if (state is GetMeFailure) {
              pageRouteNotReturn(context, const Onboarding());
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        )),
      ),
    );
  }
}
