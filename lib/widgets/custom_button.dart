import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revision/controllers/login/login_controller.dart';
import 'package:revision/controllers/login/login_state.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onClick;
  final bool isLoading;
  const CustomButton({super.key, required this.text, required this.onClick, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      width: screenSize.width,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(10)
      ),
      child: InkWell(
        onTap: onClick,
        child: Center(
          child: isLoading == true ? CircularProgressIndicator(color: Colors.white,) : Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 17
              ),
            ),
        ),
      ),
    );
  }
}