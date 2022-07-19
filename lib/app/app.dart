
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:caro_game/localizations/app_localization.dart';
import 'package:caro_game/modules/play/play_page.dart';
import '../modules/welcome/welcome_page.dart';
import 'cubit/app_cubit.dart';
import 'cubit/app_state.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);
  @override
  _AppState createState() => _AppState();
}

// ignore: prefer_mixin
class _AppState extends State<App> with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit(AppInitial()),
        ),
      ],
      child: GestureDetector(
        onTap: () {
          //Hide keyboard when tap outside
          WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
        },
        child: BlocBuilder<AppCubit, AppState>(
          builder: (context, state) {
            return MaterialApp(
              // locale: (state is AppLanguageFetchLocaleCompleted)
              //     ? state.locale
              //     : const Locale('vi'),
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate
              ],
              theme: context.read<AppCubit>().styles.themeData,
              home: WelcomePage()
            );
          },
        ),
      ),
    );
  }
}
