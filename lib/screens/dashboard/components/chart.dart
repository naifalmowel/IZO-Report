import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:izo_report/controllers/info_controllers.dart';

import '../../../utils/constants.dart';

class Chart extends StatelessWidget {
  const Chart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InfoController>(
        builder: (controller) {
          return SizedBox(
            height: 200,
            child: Stack(
              children: [
                PieChart(
                  PieChartData(
                    sectionsSpace: 0,
                    centerSpaceRadius: 70,
                    startDegreeOffset: -90,
                    sections: [
                      PieChartSectionData(
                        color: primaryColor,
                        value:((controller.totalSales.value/controller.total.value)*100),
                        showTitle: false,
                        radius: 25,
                      ),
                      PieChartSectionData(
                        color: const Color(0xFF26E5FF),
                        value: ((controller.totalPurchase.value/controller.total.value)*100),
                        showTitle: false,
                        radius: 22,
                      ),
                      PieChartSectionData(
                        color: const Color(0xFFFFCF26),
                        value: ((controller.totalPayment.value/controller.total.value)*100),
                        showTitle: false,
                        radius: 19,
                      ),
                      PieChartSectionData(
                        color: const Color(0xFFEE2727),
                        value: ((controller.totalExpense.value/controller.total.value)*100),
                        showTitle: false,
                        radius: 16,
                      ),
                      PieChartSectionData(
                        color: primaryColor.withOpacity(0.1),
                        value: 25,
                        showTitle: false,
                        radius: 13,
                      ),
                    ],
                  ),
                ),
                Positioned.fill(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: defaultPadding),
                      Text(
                        controller.profit.toStringAsFixed(2),
                        style: Theme
                            .of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                          color: textColor,
                          fontWeight: FontWeight.w600,
                          height: 0.5,
                        ),
                      ),
                      const Text("AED")
                    ],
                  ),
                )
              ],
            ),
          );
        }
    );
  }
}
