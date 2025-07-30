import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:izo_report/controllers/info_controllers.dart';

import '../../../utils/constants.dart';
import '../../../utils/responsive.dart';
import 'file_info_card.dart';

class InfoBox extends StatelessWidget {
  const InfoBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: defaultPadding + 10),
            Responsive(
              mobile: FileInfoCardGridView(
                crossAxisCount: size.width < 650 ? 2 : 2,
                childAspectRatio: size.width < 650 ? 1.0 : 1.5,
              ),
              tablet: FileInfoCardGridView(
                crossAxisCount: 4,
                childAspectRatio: size.width < 650 ? 1.4 : 1.0,
              ),
              desktop: FileInfoCardGridView(
                childAspectRatio: size.width < 1400 ? 1.1 : 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FileInfoCardGridView extends StatefulWidget {
  const FileInfoCardGridView({
    super.key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  });

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  State<FileInfoCardGridView> createState() => _FileInfoCardGridViewState();
}

class _FileInfoCardGridViewState extends State<FileInfoCardGridView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<InfoController>(builder: (controller) {
      return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.information.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: widget.crossAxisCount,
          crossAxisSpacing: defaultPadding,
          mainAxisSpacing: defaultPadding,
          childAspectRatio: widget.childAspectRatio,
        ),
        itemBuilder: (context, index) => FileInfoCard(
          color: controller.information[index].color!,
          title: controller.information[index].title!,
          total: controller.information[index].total!,
          percentage: controller.information[index].percentage!,
          rTotal: controller.information[index].receipt??0,
          voucherSelected: (String value) {
            // if (value == 'p') {
            //   controller.information[index].total =
            //       controller.totalPayment.value;
            // } else {
            //   controller.information[index].total =
            //       controller.totalReceipt.value;
            // }
            // setState(() {});
          },
          onSelected: (String value) {
            if (controller.information[index].title == 'Sales') {
              if (value == 'a') {
                controller.information[index].total =
                    controller.totalSales.value;
              } else if (value == 'd') {
                controller.information[index].total =
                    controller.dailySales.value;
              } else if (value == 'm') {
                controller.information[index].total =
                    controller.monthlySales.value;
              } else if (value == 'y') {
                controller.information[index].total =
                    controller.yearlySales.value;
              }
            }
            else if (controller.information[index].title == 'Purchases') {
              if (value == 'a') {
                controller.information[index].total =
                    controller.totalPurchase.value;
              } else if (value == 'd') {
                controller.information[index].total =
                    controller.dailyPurchase.value;
              } else if (value == 'm') {
                controller.information[index].total =
                    controller.monthPurchase.value;
              } else if (value == 'y') {
                controller.information[index].total =
                    controller.yearPurchase.value;
              }
            }
            else if (controller.information[index].title == 'Expenses') {
              if (value == 'a') {
                controller.information[index].total =
                    controller.totalExpense.value;
              } else if (value == 'd') {
                controller.information[index].total =
                    controller.dailyExpense.value;
              } else if (value == 'm') {
                controller.information[index].total =
                    controller.monthExpense.value;
              } else if (value == 'y') {
                controller.information[index].total =
                    controller.yearlyExpense.value;
              }
            }
            setState(() {});
          },
          onTap: () async {
            // if (controller.information[index].title == 'Sales') {
            //   Get.to(() => const BillList());
            // } else if (controller.information[index].title == 'Purchases') {
            //   await Get.find<InfoController>().getAllPurchase();
            //   Get.to(() => const PurchaseList());
            // } else if (controller.information[index].title == 'Expenses') {
            //   await Get.find<InfoController>().getAllExpense();
            //   Get.to(() => const ExpenseList());
            // } else if (controller.information[index].title == 'Voucher') {
            //   await Get.find<InfoController>().getAllVoucher();
            //   await Get.find<InfoController>().getAllPurchase();
            //   Get.to(() => const VoucherView());
            // }
          },
        ),
      );
    });
  }
}
