import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revision/controllers/login/login_state.dart';
import 'package:revision/controllers/web_services.dart';
import 'package:revision/local/shared_pref.dart';
import 'package:revision/models/user.dart';

//loading
//success

class LoginControllerCubit extends Cubit<LoginState>{
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  User user = User();

  LoginControllerCubit() : super(InitLoginState());

  static LoginControllerCubit get(context) => BlocProvider.of(context);

  Future<bool> onLogin(BuildContext context) async{
    bool valid = formKey.currentState!.validate();
    if(valid){
      formKey.currentState!.save();
      emit(LoadingLoginState());
      WebServices webServices = WebServices();
      Map<String, dynamic>? map = await webServices.login(user);
      if(map != null){
        if(map['status'] == true){
          await SharedPref.setEmail(user.email!);
          await SharedPref.setToken(map['token']);
          formKey.currentState!.reset();
          emit(SuccessLoginState());
          return true;
        }
        else{
          emit(FailLoginState());
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(map['massage']) , backgroundColor: Colors.red,));
          return false;
        }
      }
      else{
        emit(FailLoginState());
        return false;
      }
    }
    else return false;
  }
}
