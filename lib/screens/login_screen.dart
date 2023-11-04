import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revision/controllers/login/login_controller.dart';
import 'package:revision/controllers/login/login_state.dart';
import 'package:revision/screens/home_screen.dart';
import 'package:revision/widgets/custom_button.dart';
import 'package:revision/widgets/custom_textfeild.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            width: screenSize.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
              child: Form(
                key: LoginControllerCubit.get(context).formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20,),
                    CustomTextField(
                      text: "Email",
                      onSaved: (value){
                        LoginControllerCubit.get(context).user.email = value;
                      }, 
                      validator: (value){
                        if(value!.isEmpty) return "Enter email";
                        else if(!value.contains("@") || !value.contains(".com")) return "Invalid email";
                        else return null;
                      },
                      type: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 10,),
                    CustomTextField(
                      text: "Password",
                      onSaved: (value){
                        LoginControllerCubit.get(context).user.password = value;
                      }, 
                      validator: (value){
                        if(value!.isEmpty) return "Enter password";
                        else if(value.length < 8) return "short password";
                        else return null;
                      },
                      isPassword: true,
                    ),
                    SizedBox(height: 15,),
                    BlocBuilder<LoginControllerCubit, LoginState>(
                      builder: ((context, state) {
                        return CustomButton(
                          text: "Login",
                          onClick: ()async{
                            bool canNavigate = await LoginControllerCubit.get(context).onLogin(context);
                            if(canNavigate){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
                            }     
                          },
                          isLoading: state is LoadingLoginState ? true : false,
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}