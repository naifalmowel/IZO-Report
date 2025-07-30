import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:izo_report/controllers/info_controllers.dart';
import 'package:izo_report/utils/responsive.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import '../../../utils/constants.dart';

class BillList extends StatefulWidget {
  const BillList({
    super.key,
  });

  @override
  State<BillList> createState() => _BillListState();
}

final controller = Get.find<InfoController>();

class _BillListState extends State<BillList> {
  @override
  Widget build(BuildContext context) {
    controller.totalS.value = 0;
    controller.totalCash.value = 0;
    controller.totalVisa.value = 0;
    for (var i in controller.billsPlayer) {
      if (i.type == 'sales') {
        controller.totalS.value += i.finalTotal;
        controller.totalCash.value += i.cashAmount;
        controller.totalVisa.value += i.visaAmount;
      } else {
        controller.totalS.value -= i.finalTotal;
        controller.totalCash.value -= i.cashAmount;
        controller.totalVisa.value -= i.visaAmount;
      }
    }
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.grey.withOpacity(0.3),
        surfaceTintColor: Colors.transparent,
        actions: [
          PopupMenuButton(
              tooltip: 'Type',
              iconSize: 25,
              icon: const Icon(
                Icons.more_vert,
              ),
              color: Colors.white,
              onSelected: (value) async {
                if (value == 'a') {
                  await controller.getAllBills();
                } else if (value == 'd') {
                  controller.billsPlayer.value = controller.bills
                      .where((p0) =>
                          p0.date.day == DateTime.now().day &&
                          p0.date.month == DateTime.now().month &&
                          p0.date.year == DateTime.now().year)
                      .toList();
                } else if (value == 'm') {
                  controller.billsPlayer.value = controller.bills
                      .where((p0) =>
                          p0.date.month == DateTime.now().month &&
                          p0.date.year == DateTime.now().year)
                      .toList();
                } else if (value == 'y') {
                  controller.billsPlayer.value = controller.bills
                      .where((p0) => p0.date.year == DateTime.now().year)
                      .toList();
                }
                setState(() {});
              },
              itemBuilder: (BuildContext bc) {
                return [
                  const PopupMenuItem(
                    value: 'a',
                    child: Text("All"),
                  ),
                  const PopupMenuItem(
                    value: 'd',
                    child: Text("Daily"),
                  ),
                  const PopupMenuItem(
                    value: 'm',
                    child: Text("Monthly"),
                  ),
                  const PopupMenuItem(
                    value: 'y',
                    child: Text("Yearly"),
                  ),
                ];
              })
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                //color: Colors.grey.withOpacity(0.3),
                //  gradient: backgroundGradient
                ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                right: defaultPadding, left: defaultPadding, top: 5),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(defaultPadding),
                    decoration: BoxDecoration(
                        // color: secondaryColor.withOpacity(0.5),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        border:
                            Border.all(color: primaryColor.withOpacity(0.8))),
                    height: ConstApp.isTab(context)
                        ? ConstApp.getHeight(context) * 0.8
                        : ConstApp.getHeight(context) * 0.7,
                    child: SizedBox(
                      height: Responsive.isMobile(context)
                          ? MediaQuery.of(context).size.height / 1.5
                          : MediaQuery.of(context).size.width / 2.5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Sales",
                            style: ConstApp.getTextStyle(
                                context: context,
                                size: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Divider(
                            color: primaryColor,
                            thickness: 4,
                          ),
                          Expanded(
                            child: SizedBox(
                              width: double.infinity,
                              child: LiquidPullToRefresh(
                                onRefresh: () async {
                                  bool response =
                                      await Get.find<InfoController>()
                                          .getAllBills();
                                  if (!response) {
                                    Get.snackbar(
                                      'ERROR',
                                      'SORRY , NO SERVER CONNECTION !!',
                                      backgroundColor:
                                          Colors.red.withOpacity(0.8),
                                      borderRadius: 20,
                                      margin: const EdgeInsets.only(
                                          top: 30, right: 20, left: 20),
                                      icon: const Icon(Icons.warning),
                                      isDismissible: true,
                                      dismissDirection:
                                          DismissDirection.horizontal,
                                    );
                                  }
                                },
                                color: primaryColor,
                                showChildOpacityTransition: true,
                                borderWidth: 2,
                                child: GetBuilder<InfoController>(
                                    builder: (controller) {
                                  return DataTable2(
                                    columnSpacing: defaultPadding,
                                    minWidth: 700,
                                    dataRowHeight: 70,
                                    columns: [
                                      DataColumn(
                                        label: Text(
                                          "Bill Number",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: textColor),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Center(
                                          child: Text(
                                            "Date",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: textColor),
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        tooltip: 'Amount(AED)',
                                        label: Center(
                                          child: Text(
                                            "Amount",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: textColor),
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Center(
                                          child: Text(
                                            "Type",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: textColor),
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Center(
                                          child: Text(
                                            "Hall",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: textColor),
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Center(
                                          child: Text(
                                            "Table",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: textColor),
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Center(
                                          child: Text(
                                            "Cash",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: textColor),
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Center(
                                          child: Text(
                                            "Visa",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: textColor),
                                          ),
                                        ),
                                      ),
                                    ],
                                    rows: List.generate(
                                      controller.billsPlayer.length,
                                      (index) => DataRow(
                                        cells: [
                                          DataCell(
                                            Text(
                                              controller
                                                  .billsPlayer[index].billNum,
                                              //  style: ConstApp.getTextStyle(context: context,color: textColor,fontWeight:FontWeight.w400),
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              DateFormat('dd-MM-yyyy hh:mm a')
                                                  .format(controller
                                                      .billsPlayer[index].date),
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(fontSize:13,),
                                            ),
                                          ),
                                          DataCell(Center(
                                            child: Text(
                                              controller
                                                  .billsPlayer[index].finalTotal
                                                  .toStringAsFixed(2),
                                              //       style: ConstApp.getTextStyle(context: context,color: textColor,fontWeight:FontWeight.w400),
                                            ),
                                          )),
                                          DataCell(Center(
                                            child: Text(
                                              controller.billsPlayer[index].type
                                                  .toUpperCase(),
                                              style: TextStyle(
                                                color: controller
                                                            .billsPlayer[index]
                                                            .type ==
                                                        'sales'
                                                    ? textColor
                                                    : Colors.red,
                                              ),
                                              // style: ConstApp.getTextStyle(context: context,color: controller
                                              //     .billsPlayer[index]
                                              //     .type ==
                                              //     'sales'
                                              //     ? textColor
                                              //     : Colors.red,fontWeight:FontWeight.w400),
                                            ),
                                          )),
                                          DataCell(Center(
                                            child: Text(
                                              controller
                                                  .billsPlayer[index].hall,
                                              //   style: ConstApp.getTextStyle(context: context,color: textColor,fontWeight:FontWeight.w400),
                                            ),
                                          )),
                                          DataCell(Center(
                                            child: Text(
                                              controller.billsPlayer[index].hall
                                                      .contains('e')
                                                  ? '-'
                                                  : controller
                                                      .billsPlayer[index].table,
                                              // style: ConstApp.getTextStyle(context: context,color: textColor,fontWeight:FontWeight.w400),
                                            ),
                                          )),
                                          DataCell(Center(
                                            child: Text(
                                              controller.billsPlayer[index]
                                                          .cashAmount ==
                                                      0
                                                  ? '-'
                                                  : controller
                                                      .billsPlayer[index]
                                                      .cashAmount
                                                      .toStringAsFixed(2),
                                              // style: ConstApp.getTextStyle(context: context,color: textColor,fontWeight:FontWeight.w400),
                                            ),
                                          )),
                                          DataCell(Center(
                                            child: Text(
                                              controller.billsPlayer[index]
                                                          .visaAmount ==
                                                      0
                                                  ? '-'
                                                  : controller
                                                      .billsPlayer[index]
                                                      .visaAmount
                                                      .toStringAsFixed(2),
                                              // style: ConstApp.getTextStyle(context: context,color: textColor,fontWeight:FontWeight.w400),
                                            ),
                                          )),
                                        ],
                                      ),
                                    ),
                                    dividerThickness: 2,
                                  );
                                }),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    shape: OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    //   color: Colors.grey[400]!.withOpacity(1),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Cash Amount : ',
                           style: TextStyle(fontWeight: FontWeight.bold,color: textColor),),
                              Text('Visa Amount : ',
                           style: TextStyle(fontWeight: FontWeight.bold,color: textColor),),
                              Text('Debt : ',
                           style: TextStyle(fontWeight: FontWeight.bold,color: textColor),),
                              Text('Total : ',
                                style: TextStyle(fontWeight: FontWeight.bold,color: primaryColor,fontSize: 20),),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  '${controller.totalCash.value.toStringAsFixed(1)} AED',
                           style: TextStyle(fontWeight: FontWeight.bold,color: textColor),),
                              Text(
                                  '${controller.totalVisa.value.toStringAsFixed(1)} AED',
                           style: TextStyle(fontWeight: FontWeight.bold,color: textColor),),
                              Text(
                                  '${(controller.totalS.value - controller.totalCash.value - controller.totalVisa.value).toStringAsFixed(1)} AED',
                           style: TextStyle(fontWeight: FontWeight.bold,color: textColor),),
                              Text(
                                  '${controller.totalS.value.toStringAsFixed(1)} AED',
                                style: TextStyle(fontWeight: FontWeight.bold,color: primaryColor,fontSize: 20),),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
