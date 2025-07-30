import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:izo_report/controllers/info_controllers.dart';

import '../../../utils/constants.dart';
import 'chart.dart';
import 'card_profit_widget.dart';

class ProfitDetails extends StatelessWidget {
  const ProfitDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Container(
        padding: const EdgeInsets.all(defaultPadding),
        decoration:  BoxDecoration(
          color: secondaryColor.withOpacity(0.25),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child:  GetBuilder<InfoController>(
          builder: (controller) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Profit ",
                  style: TextStyle(
                    fontSize: 25,
                    color: primaryColor,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'bung'
                  ),
                ),
                Divider(color: primaryColor , thickness: 4),
                const SizedBox(height: defaultPadding),
                const Chart(),
                  CardProfitWidget(
                  svgSrc: "assets/icons/invoice.svg",
                  title: "Sales",
                  amountOfFiles: controller.totalSales.value.toStringAsFixed(2),
                  numOfFiles: 1328, color: primaryColor,
                ),
                  CardProfitWidget(
                  svgSrc: "assets/icons/purchase.svg",
                  title: "Purchase",
                  amountOfFiles: controller.totalPurchase.value.toStringAsFixed(2),
                  numOfFiles: 1328, color: const Color(0xFF26E5FF),
                ),
                  CardProfitWidget(
                  svgSrc: "assets/icons/voucher.svg",
                  title: "Voucher",
                  amountOfFiles: controller.totalPayment.toStringAsFixed(2),
                  numOfFiles: 1328, color: const Color(0xFFFFCF26),
                ),
                  CardProfitWidget(
                  svgSrc: "assets/icons/expense.svg",
                  title: "Expense",
                  amountOfFiles: controller.totalExpense.toStringAsFixed(2),
                  numOfFiles: 140, color: const Color(0xFFEE2727),
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}
