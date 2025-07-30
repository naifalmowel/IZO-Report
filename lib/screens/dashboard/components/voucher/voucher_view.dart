import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:izo_report/screens/dashboard/components/voucher/voucher_list.dart';
import '../../../../utils/constants.dart';

class VoucherView extends StatelessWidget {
  const VoucherView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      //  backgroundColor: Colors.grey.withOpacity(0.3),
        surfaceTintColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Container(
           // decoration: BoxDecoration(color: Colors.grey.withOpacity(0.3)),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => const VoucherList(type: 'Payment'));
                    },
                    child: Container(
                      width: Get.width / 2,
                      height: Get.height / 12,
                      padding: const EdgeInsets.all(defaultPadding),
                      decoration: BoxDecoration(
                          color: primaryColor.withOpacity(0.8),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          border:
                              Border.all(color: secondaryColor.withOpacity(0.6))),
                      child: const Center(
                        child: Text(
                          "Payment",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => const VoucherList(type: 'Receipt'));
                    },
                    child: Container(
                      width: Get.width / 2,
                      height: Get.height / 12,
                      padding: const EdgeInsets.all(defaultPadding),
                      decoration: BoxDecoration(
                          color: primaryColor.withOpacity(0.8),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          border:
                              Border.all(color: secondaryColor.withOpacity(0.6))),
                      child: const Center(
                        child: Text(
                          "Receipt",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
