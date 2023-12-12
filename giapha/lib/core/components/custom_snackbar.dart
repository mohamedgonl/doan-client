import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';

class CustomSnackBar  {
  const CustomSnackBar({ required this.message, required this.type});
  final String message;
  final AnimatedSnackBarType type;
 
  show(BuildContext context) {
     AnimatedSnackBar.material(message,
                  type: type,
                  duration: const Duration(milliseconds: 2000))
              .show(context);
  }
}
