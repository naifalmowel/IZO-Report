import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:izo_report/screens/main/main_screen.dart';
import 'package:izo_report/screens/qr_code/qr_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import '../controllers/info_controllers.dart';
import '../controllers/internet_check_controller.dart';
import '../utils/constants.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

  @override
  VideoPlayerScreenState createState() => VideoPlayerScreenState();
}

class VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
bool isE = false;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/video/video.mp4')
      ..initialize().then((_) async {
        setState(() {
          _controller.setVolume(0.0);
          _controller.play();

        });
        if (Get.find<INetworkInfo>().connectionStatus.value == 1) {
          try{
            // isE = await Get.find<InfoController>().checkMobile();
            //  await Get.find<InfoController>().getAllBills();
            //  await Get.find<InfoController>().getAllHalls();
            //  await Get.find<InfoController>().getAllPurchase();
            //  await Get.find<InfoController>().getAllExpense();
            //  await Get.find<InfoController>().getAllVoucher();
            // await Get.find<InfoController>().getAllBoxes();
            await Get.find<InfoController>().getIzoReportInfo();
            await Get.find<InfoController>().getInformation();
          }catch(e){
            isE = false ;
            Get.find<InfoController>().isLoading(false);
            Get.find<InfoController>().isLoadingCheck(false);
          }
        }

      });
    // String urlServer = Get.find<SharedPreferences>().getString('url') ?? '';
    String urlServer = Get.find<SharedPreferences>().getString('deviceId') ?? '';
    Future.delayed(
        const Duration(seconds: 5),
        () => Get.off(
            () =>
            urlServer == '' ? const QRScanner() : const MainScreen()
                // : isE ? const MainScreen() : const QRScanner()
    ));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff4f4f3),
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : Center(
                child: SpinKitFoldingCube(
                color: primaryColor,
                size: 75,
              )),
      ),
    );
  }
}
