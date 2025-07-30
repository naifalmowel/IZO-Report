import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:izo_report/controllers/info_controllers.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constants.dart';
import '../main/main_screen.dart';

class QRScanner extends StatefulWidget {
  const QRScanner({super.key});

  @override
  State<QRScanner> createState() => _QRScannerState();
}
var _formKey = GlobalKey<FormState>();
MobileScannerController cameraController = MobileScannerController();
TextEditingController ipController = TextEditingController();
class _QRScannerState extends State<QRScanner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.grey.withOpacity(0.3)),
          ),
          Obx(() => Get.find<InfoController>().isLoadingCheck.value
              ? Center(
                  child: SpinKitFoldingCube(
                  color: primaryColor,
                  size: 75,
                ))
              : Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (MediaQuery.of(context).size.width > 650)
                        Row(
                          children: [
                            Expanded(
                              child: Center(
                                child: Lottie.asset('lottie/qr.json',
                                    width: 300, height: 300),
                              ),
                            ),
                            Expanded(child: info()),
                          ],
                        ),
                      if (MediaQuery.of(context).size.width < 650)
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: Lottie.asset('lottie/qr.json',
                                width: 300, height: 300),
                          ),
                        ),
                      const SizedBox(height: 20),
                      if (MediaQuery.of(context).size.width < 650)
                        Expanded(flex: 2, child: info()),
                    ],
                  ),
                ))
        ],
      ),
    );
  }

  Widget info() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            'Welcome'.toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'bah',
                fontSize: 40,
                color: Colors.grey[800],
                fontWeight: FontWeight.bold),
          ),
          Text(
            'To The IZO Report',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'bah',
                fontSize: 30,
                color: Colors.grey[800],
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 50, right: 50),
            child: Text(
              'kindly open the desktop application (IZO) and scan the QR code located in the settings menu under the active mobile app',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'bah', fontSize: 15, color: Colors.grey[700]),
            ),
          ),
          MediaQuery.of(context).size.width > 650
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.qr_code_scanner,
                    size: 130,
                    color: Colors.grey[700],
                  ),
                ),
          Align(
            alignment: MediaQuery.of(context).size.width > 650
                ? Alignment.bottomRight
                : Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: ElevatedButton(
                  onPressed: () async {
                    ConstApp.typeUser = "";
                    Get.to(() => const MyHomePage());
                  },
                  style: ButtonStyle(
                      shape: WidgetStateProperty.all<
                          RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                              side: const BorderSide(
                                  color: Colors.black38))),
                      backgroundColor: WidgetStateColor.resolveWith(
                              (states) => primaryColor)),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text('Scan QR',
                            style: TextStyle(
                                fontFamily: 'bung',
                                fontSize: 20,
                                color: Colors.white)),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.qr_code, size: 30, color: Colors.white),
                    ],
                  )),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          // Align(
          //   alignment: MediaQuery.of(context).size.width > 650
          //       ? Alignment.bottomRight
          //       : Alignment.bottomCenter,
          //   child: Padding(
          //     padding: const EdgeInsets.only(left: 50, right: 50),
          //     child: ElevatedButton(
          //         onPressed: () async {
          //           openAlertBox();
          //         },
          //         style: ButtonStyle(
          //             shape: WidgetStateProperty.all<
          //                 RoundedRectangleBorder>(
          //                 RoundedRectangleBorder(
          //                     borderRadius: BorderRadius.circular(18),
          //                     side: const BorderSide(
          //                         color: Colors.black38))),
          //             backgroundColor: WidgetStateColor.resolveWith(
          //                     (states) => primaryColor)),
          //         child: const Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             Padding(
          //               padding: EdgeInsets.all(10),
          //               child: Text('Manually',
          //                   maxLines: 1,
          //                   overflow: TextOverflow.ellipsis,
          //                   style: TextStyle(
          //                       fontFamily: 'bung',
          //                       fontSize: 20,
          //                       color: Colors.white)),
          //             ),
          //             Icon(Icons.front_hand,
          //                 size: 30,
          //                 color: Colors.white),
          //           ],
          //         )),
          //   ),
          // ),
          // const SizedBox(
          //   height: 10,
          // ),
          TextButton(onPressed: () async{
            ConstApp.typeUser = "guest";
            await  Get.find<InfoController>().getIzoReportInfo();
            await  Get.find<InfoController>().getInformation();
            // await  Get.find<InfoController>().getAllHalls();
            // await  Get.find<InfoController>().getAllBoxes();
            // await  Get.find<InfoController>().getAllExpense();
            // await  Get.find<InfoController>().getAllPurchase();
            // await  Get.find<InfoController>().getAllVoucher();
            // await  Get.find<InfoController>().getInformation();
            Get.to(()=>const MainScreen());
          }, child: Text("Connect as guest",style: TextStyle(color: primaryColor),)),
        ],
      ),
    );
  }
  openAlertBox() {
    ipController.clear();
    Get.find<InfoController>().isLoading.value = false;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: const EdgeInsets.only(top: 10.0),
            content: SizedBox(
              width: 300.0,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const SizedBox(
                      height: 5,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        'Write IP Address Here And Click Connect',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'bung',
                            fontSize: 15,
                            color: Colors.black),
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    const Divider(
                      color: Colors.grey,
                      height: 4.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30.0, right: 30.0, top: 10, bottom: 10),
                      child: TextFormField(
                        controller: ipController,
                        // inputFormatters: [
                        //   MyInputFormatters.ipAddressInputFilter(),
                        //   LengthLimitingTextInputFormatter(15),
                        //   IpAddressInputFormatter()
                        // ],
                        onFieldSubmitted: (_){
                          if(!_formKey.currentState!.validate()){
                            return;
                          }
                          Get.back();
                          Get.find<InfoController>().isLoadingCheck(true);
                          Future.microtask(() async{ if (ipController.text.isNotEmpty) {
                            await foundBarcode1(BarcodeCapture(), context,ipController.text);
                            Get.find<InfoController>().isLoadingCheck(false);
                            Get.find<InfoController>().isLoading(false);
                          }
                          });
                        },
                        keyboardType: TextInputType.number,
                        validator: (value){
                          if(value == null||value.isEmpty){
                          return 'Can not be Empty !!';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          label: Text('IP Address'),
                          hintText: '192.168.1.1',
                          border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(20))),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        if(!_formKey.currentState!.validate()){
                          return;
                        }
                        Get.back();
                        Get.find<InfoController>().isLoadingCheck(true);
                        Future.microtask(() async{ if (ipController.text.isNotEmpty) {
                          await foundBarcode1(BarcodeCapture(), context,ipController.text);
                          Get.find<InfoController>().isLoadingCheck(false);
                          Get.find<InfoController>().isLoading(false);
                        }
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(32.0),
                              bottomRight: Radius.circular(32.0)),
                        ),
                        child: const Text(
                          "Connect",
                          style: TextStyle(
                              fontFamily: 'bung',
                              fontSize: 20,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MobileScannerController cameraController = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text("Mobile Scanner"),
        actions: [
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.torchState,
              builder: (context, state, child) {
                switch (state) {
                  case TorchState.off:
                    return const Icon(Icons.flash_off, color: Colors.white);
                  case TorchState.on:
                    return const Icon(Icons.flash_on, color: Colors.yellow);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.toggleTorch(),
          ),
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.cameraFacingState,
              builder: (context, state, child) {
                switch (state) {
                  case CameraFacing.front:
                    return const Icon(Icons.flip_camera_ios);
                  case CameraFacing.back:
                    return const Icon(Icons.flip_camera_ios_outlined);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.switchCamera(),
          ),
        ],
      ),
      body: MobileScanner(
        controller: cameraController,
        onDetect: (value){
          if(value.barcodes.isNotEmpty){
            cameraController.stop();
            Get.back(canPop: true);
            foundBarcode1(value , context , '');
          }

        },
      ),
    );
  }



}
Future foundBarcode(BarcodeCapture barcode , BuildContext context, String address) async {
  try {
    final String code =address == ''? (barcode.barcodes.last.rawValue ?? "---") : '$address-8080';
    debugPrint('Barcode found! $code');
    Get.find<SharedPreferences>().setString('url', code.replaceAll('-', ':'));
    bool check = await Get.find<InfoController>().checkQR();
    bool check1 = await Get.find<InfoController>().checkMobile();
    //print("check $check");
    // print("check1 $check1");
    if(check1){
      await Get.find<InfoController>().signUp();
      await Get.find<InfoController>().getAllBills();
      await Get.find<InfoController>().getAllHalls();
      await Get.find<InfoController>().getAllPurchase();
      await Get.find<InfoController>().getAllExpense();
      await Get.find<InfoController>().getAllVoucher();
      await Get.find<InfoController>().getInformation();
      await Get.find<InfoController>()
          .getAllBoxes();
      Get.find<InfoController>().isLoadingCheck(false);
      Get.find<InfoController>().isLoading(false);
    }else{
      if (check) {
        await Get.find<InfoController>().signUp();
        await Get.find<InfoController>().getAllBills();
        await Get.find<InfoController>().getAllHalls();
        await Get.find<InfoController>().getAllPurchase();
        await Get.find<InfoController>().getAllExpense();
        await Get.find<InfoController>().getAllVoucher();
        await Get.find<InfoController>().getInformation();
        await Get.find<InfoController>()
            .getAllBoxes();
        Get.find<InfoController>().isLoadingCheck(false);
        Get.find<InfoController>().isLoading(false);
      }
      else {
        Get.offAll(()=>const QRScanner());
        Get.snackbar(
          'ERROR',
          'SORRY , NO SERVER CONNECTION !!',
          backgroundColor: Colors.red,
          borderRadius: 20,
          margin:const EdgeInsets.only(top: 30 , right: 20 , left: 20),
          icon: const Icon(Icons.warning),
          isDismissible: true,
          dismissDirection: DismissDirection.horizontal,
        );
        Get.find<SharedPreferences>().remove('url');
        Get.find<InfoController>().isLoadingCheck(false);
        Get.find<InfoController>().isLoading(false);
      }
    }

  } catch (e) {
    Get.offAll(()=>const QRScanner());
    Get.snackbar(
      'ERROR',
      'SORRY , NO SERVER CONNECTION !!',
      backgroundColor: Colors.red,
      borderRadius: 20,
      margin:const EdgeInsets.only(top: 30 , right: 20 , left: 20),
      icon: const Icon(Icons.warning),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
    );
    Get.find<InfoController>().isLoading(false);
    Get.find<InfoController>().isLoadingCheck(false);
    Get.find<SharedPreferences>().remove('url');

  }
  Get.find<InfoController>().isLoading(false);
  Get.find<InfoController>().isLoadingCheck(false);


}
Future foundBarcode1(BarcodeCapture barcode , BuildContext context, String address) async {
  try {
    final String code =address == ''? (barcode.barcodes.last.rawValue ?? "---") : address;
    debugPrint('Barcode found! $code');
    if(code=='---'){
      Get.snackbar(
        'ERROR',
        'SORRY , NO SERVER CONNECTION !!',
        backgroundColor: Colors.red,
        borderRadius: 20,
        margin:const EdgeInsets.only(top: 30 , right: 20 , left: 20),
        icon: const Icon(Icons.warning),
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
      );
      return;
    }
    Get.find<SharedPreferences>().remove('deviceId');
    Get.find<SharedPreferences>().setString('deviceId', code);
    bool check = await Get.find<InfoController>().getIzoReportInfo();
      if (check) {
        Get.find<InfoController>().isLoadingCheck(false);
        Get.find<InfoController>().isLoading(false);
        await Get.find<InfoController>().getInformation();
        Get.offAll(()=>const MainScreen());
        Get.snackbar(
          'Success',
          'The Server Is Connected !!',
          backgroundColor: Colors.green,
          icon: const Icon(Icons.check),
        );
      }
      else {
        Get.offAll(()=>const QRScanner());
        Get.snackbar(
          'ERROR',
          'SORRY , NO SERVER CONNECTION !!',
          backgroundColor: Colors.red,
          borderRadius: 20,
          margin:const EdgeInsets.only(top: 30 , right: 20 , left: 20),
          icon: const Icon(Icons.warning),
          isDismissible: true,
          dismissDirection: DismissDirection.horizontal,
        );
        Get.find<SharedPreferences>().remove('deviceId');
        Get.find<InfoController>().isLoadingCheck(false);
        Get.find<InfoController>().isLoading(false);
      }


  } catch (e) {
    Get.offAll(()=>const QRScanner());
    Get.snackbar(
      'ERROR',
      'SORRY , NO SERVER CONNECTION !!',
      backgroundColor: Colors.red,
      borderRadius: 20,
      margin:const EdgeInsets.only(top: 30 , right: 20 , left: 20),
      icon: const Icon(Icons.warning),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
    );
    Get.find<InfoController>().isLoading(false);
    Get.find<InfoController>().isLoadingCheck(false);
    Get.find<SharedPreferences>().remove('deviceId');

  }
  Get.find<InfoController>().isLoading(false);
  Get.find<InfoController>().isLoadingCheck(false);


}