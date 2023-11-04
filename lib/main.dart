import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:revision/controllers/home/home_controller.dart';
import 'package:revision/controllers/lang/lang_cubit.dart';
import 'package:revision/controllers/lang/lang_state.dart';
import 'package:revision/controllers/login/login_controller.dart';
import 'package:revision/local/shared_pref.dart';
import 'package:revision/screens/home_screen.dart';
import 'package:revision/screens/login_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref.init();
  runApp(MultiBlocProvider(
    providers: [
        BlocProvider(create: (context) => LoginControllerCubit(),),
        BlocProvider(create: (context) => HomeControllerCubit(),),
        BlocProvider(create: (context) => LangCubit(),),
      ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String? langFromSharedPref = SharedPref.getLang();
    if(langFromSharedPref != null){
      LangCubit.get(context).changeLang(langFromSharedPref);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LangCubit, LangState>(
      builder: ((context, state) {
        return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(LangCubit.get(context).lang),
      title: 'Revision',
      home: LoginScreen(),
    );
      }),
    );
  }
}
