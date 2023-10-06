import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revision/controllers/login/login_state.dart';
import 'package:revision/local/shared_pref.dart';
import 'package:revision/models/user.dart';

//loading
//success

class LoginControllerCubit extends Cubit<LoginState>{
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  User user = User();

  LoginControllerCubit() : super(InitLoginState());

  static LoginControllerCubit get(context) => BlocProvider.of(context);

  void onLogin() async{
    bool valid = formKey.currentState!.validate();
    if(valid){
      formKey.currentState!.save();
      emit(LoadingLoginState());
      await Future.delayed(Duration(seconds: 3), () async{
        await SharedPref.setEmail(user.email!);
        await SharedPref.setPassword(user.password!);
      });
      formKey.currentState!.reset();
      emit(SuccessLoginState());
    }
  }
}
