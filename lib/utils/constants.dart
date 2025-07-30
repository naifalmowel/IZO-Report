import 'dart:io';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';

 Color primaryColor = const Color(0xFFee6800).withOpacity(0.8);
 Color secondaryColor = Colors.grey.withOpacity(0.8);
 Color textColor = Colors.black87;
LinearGradient backgroundGradient = LinearGradient(
 colors: [
  Colors.white.withOpacity(0.8),
  primaryColor.withOpacity(0.1),
  Colors.white.withOpacity(0.8),
// secondaryColor.withOpacity(0.3),
 ],
 begin: Alignment.topCenter,
 end: Alignment.bottomCenter,
 stops: const [0.0, 0.0, 0.9],
);

const defaultPadding = 16.0;
class ConstApp {

 static String typeUser = "";

 static void showSnakeBarSuccess(BuildContext context, String contentText) {
  AnimatedSnackBar.material(
   contentText,
   borderRadius: const BorderRadius.all(Radius.circular(20)),
   type: AnimatedSnackBarType.success,
   duration: const Duration(milliseconds: 2000),
  ).show(
   context,
  );
 }

 static void showSnakeBarError(BuildContext context, String contentText) {
  AnimatedSnackBar.material(
   contentText,
   borderRadius: const BorderRadius.all(Radius.circular(20)),
   type: AnimatedSnackBarType.error,
   duration: const Duration(milliseconds: 4000),
   snackBarStrategy: RemoveSnackBarStrategy()
  ).show(
   context,
  );
 }

 static double getWidth(BuildContext context) {
  return MediaQuery.sizeOf(context).width;
 }

 static double getHeight(BuildContext context) {
  return MediaQuery.sizeOf(context).height;
 }

 static double getTextSize(BuildContext context) {
  return  isTab(context)
      ? MediaQuery.sizeOf(context).height / MediaQuery.sizeOf(context).width
      : MediaQuery.sizeOf(context).width /
      MediaQuery.sizeOf(context).height;}

 static TextStyle getTextStyle({
  required BuildContext context,
  Color? color,
  double size = 10,
  FontWeight fontWeight = FontWeight.normal,
 }) {
  return TextStyle(
   color: color ?? primaryColor,
   fontSize: getTextSize(context) * size,
   fontFamily: "Dubai",
   fontWeight: fontWeight,
   decorationColor: primaryColor,
  );
 }

 static bool isTab(BuildContext context) {
  if (!Platform.isWindows && MediaQuery.of(context).size.width <= 800) {
   return true;
  }
  return false;
 }

}