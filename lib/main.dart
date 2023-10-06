import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revision/controllers/home/home_controller.dart';
import 'package:revision/controllers/login/login_controller.dart';
import 'package:revision/local/shared_pref.dart';
import 'package:revision/screens/home_screen.dart';
import 'package:revision/screens/login_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginControllerCubit(),),
        BlocProvider(create: (context) => HomeControllerCubit(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Revision',
        home: HomeScreen(),
      ),
    );
  }
}
