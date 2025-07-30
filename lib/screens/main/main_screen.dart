import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:izo_report/controllers/info_controllers.dart';
import 'package:izo_report/controllers/internet_check_controller.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constants.dart';
import '../../utils/responsive.dart';
import '../dashboard/components/box_list.dart';
import '../dashboard/components/information_box.dart';
import '../dashboard/components/profit_details.dart';
import '../qr_code/qr_scanner.dart';
import '../tables/halls_page.dart';
import '../widget/no_internet_widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Obx(
            () => Get.find<InfoController>().isLoading.value
                ? Center(
                    child: SpinKitFoldingCube(
                    color: primaryColor,
                    size: 75,
                  ))
                : Get.find<INetworkInfo>().connectionStatus.value == 1
                    ? SafeArea(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: RefreshIndicator(
                            color: primaryColor,
                            onRefresh: () async {
                            await Get.find<InfoController>().getIzoReportInfo();
                            await Get.find<InfoController>().getInformation();
                              //  await Get.find<InfoController>().getAllHalls();
                              //  await Get.find<InfoController>().getAllPurchase();
                              //  await Get.find<InfoController>().getAllVoucher();
                              //  await Get.find<InfoController>().getAllExpense();
                              // await Get.find<InfoController>().getAllBoxes();
                              // await Get.find<InfoController>().getInformation();
                              // if (!response) {
                              //   Get.snackbar(
                              //     'ERROR',
                              //     'SORRY , NO SERVER CONNECTION !!',
                              //     backgroundColor: Colors.red.withOpacity(0.8),
                              //     borderRadius: 20,
                              //     margin: const EdgeInsets.only(
                              //         top: 30, right: 20, left: 20),
                              //     icon: const Icon(Icons.warning),
                              //     isDismissible: true,
                              //     dismissDirection: DismissDirection.horizontal,
                              //   );
                              // }
                            },
                            child: Stack(
                              alignment: Alignment.topRight,
                              children: [
                                SingleChildScrollView(
                                  physics: const AlwaysScrollableScrollPhysics(),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 40),
                                        child: SizedBox(
                                          width: double.infinity,
                                          height: 85,
                                          child: Image.asset('assets/images/IZO.png'),
                                        ),
                                      ),
                                      const SizedBox(height: defaultPadding),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 5,
                                            child: Column(
                                              children: [
                                                const InfoBox(),
                                                const SizedBox(
                                                    height: defaultPadding),
                                                // Obx(
                                                //   () => Get.find<InfoController>()
                                                //               .appType.value ==
                                                //           'REST'
                                                //       ? const HallPage()
                                                //       : const SizedBox(),
                                                // ),
                                                Get.find<InfoController>().appType.value == 'REST' ?   const HallPage() : const SizedBox(),
                                                const BoxList(),
                                                if (Responsive.isMobile(context))
                                                  const SizedBox(
                                                      height: defaultPadding),
                                                if (Responsive.isMobile(context))
                                                  const ProfitDetails(),
                                              ],
                                            ),
                                          ),
                                          if (!Responsive.isMobile(context))
                                            const Expanded(
                                              flex: 2,
                                              child: Column(
                                                children: [
                                                  SizedBox(height: defaultPadding + 10),
                                                  ProfitDetails(),
                                                ],
                                              ),
                                            ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Padding(
                                            padding: const EdgeInsets.only(top: 20),
                                            child: SingleChildScrollView(
                                              child: AlertDialog(
                                                alignment: Alignment.topCenter,
                                                backgroundColor: Colors.white.withOpacity(0.9),
                                                actionsPadding: const EdgeInsets.all(20),
                                                shape: const OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius.all(Radius.circular(30))),
                                                title: Center(
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Lottie.asset('lottie/question.json',
                                                            height: 200, width: 200),
                                                        const Text('Are You Sure To Go To The Home Page ?',
                                                            textAlign: TextAlign.center),
                                                      ],
                                                    )),
                                                content: const Text(
                                                    'You Will Not Be Able To Return To This Page',
                                                    textAlign: TextAlign.center),
                                                actions: [
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        Get.back();
                                                      },
                                                      style: ButtonStyle(
                                                          backgroundColor:
                                                          WidgetStateColor.resolveWith(
                                                                  (states) => Colors.redAccent)),
                                                      child: const Padding(
                                                        padding: EdgeInsets.only(left: 20, right: 20),
                                                        child: Text(
                                                          'No',
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontWeight: FontWeight.w600),
                                                        ),
                                                      )),
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        Get.find<SharedPreferences>().remove('deviceId');
                                                        // Get.find<SharedPreferences>().remove('url');
                                                        Get.offAll(() => const QRScanner());
                                                      },
                                                      style: ButtonStyle(
                                                          backgroundColor:
                                                          WidgetStateColor.resolveWith((states) =>
                                                              primaryColor.withOpacity(0.8))),
                                                      child: const Padding(
                                                        padding: EdgeInsets.only(left: 20, right: 20),
                                                        child: Text(
                                                          'Yes',
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontWeight: FontWeight.w600),
                                                        ),
                                                      )),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                        barrierDismissible: true,);
                                  },
                                  child: Lottie.asset(
                                    'lottie/report.json',
                                    height: 75,
                                    width: 75,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : EmptyFailureNoInternetView(
                        image: 'lottie/no_internet.json',
                        title: 'Network Error',
                        description: 'Internet Not Found !!',
                        buttonText: "Retry",
                        onPressed: () async {
                          if (Get.find<INetworkInfo>().connectionStatus.value ==
                              1) {
                            bool response =
                                await Get.find<InfoController>().getAllBills();
                                await Get.find<InfoController>().getAllHalls();
                            await Get.find<InfoController>()
                                .getAllBoxes();
                            if (!response) {
                              Get.snackbar(
                                'ERROR',
                                'SORRY , NO SERVER CONNECTION !!',
                                backgroundColor: Colors.red.withOpacity(0.8),
                                borderRadius: 20,
                                margin: const EdgeInsets.only(
                                    top: 30, right: 20, left: 20),
                                icon: const Icon(Icons.warning),
                                isDismissible: true,
                                dismissDirection: DismissDirection.horizontal,
                              );
                            }
                          } else {
                            Get.snackbar('ERROR', 'SORRY , NO INTERNET !!',
                                backgroundColor: Colors.red.withOpacity(0.8),
                                borderRadius: 20,
                                margin: const EdgeInsets.only(
                                    top: 30, right: 20, left: 20),
                                icon: const Icon(Icons.warning),
                                isDismissible: true,
                                dismissDirection: DismissDirection.horizontal,
                                maxWidth:
                                    MediaQuery.of(context).size.width / 1.5);
                          }
                        },
                      ),
          )
        ],
      ),
    );
  }
}
