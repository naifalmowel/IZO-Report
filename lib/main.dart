
import 'package:flutter/material.dart';
import 'package:izo_report/controllers/info_controllers.dart';
import 'package:get/get.dart';
import 'package:izo_report/controllers/internet_check_controller.dart';
import 'package:izo_report/screens/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  Get.put(prefs);
  Get.put(InfoController());
  Get.put(INetworkInfo());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return   GetMaterialApp(
      onInit: ()async{

      },
      theme: ThemeData(fontFamily: 'bah' , useMaterial3: true),
      defaultTransition: Transition.size,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Admin Panel',
      home: const Scaffold(
          body: VideoPlayerScreen()),
    );
  }
}
