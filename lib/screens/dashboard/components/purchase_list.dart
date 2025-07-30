import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:izo_report/controllers/info_controllers.dart';
import 'package:izo_report/utils/responsive.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import '../../../utils/constants.dart';

class PurchaseList extends StatefulWidget {
  const PurchaseList({
    Key? key,
  }) : super(key: key);

  @override
  State<PurchaseList> createState() => _PurchaseListState();
}

final controller = Get.find<InfoController>();

class _PurchaseListState extends State<PurchaseList> {
  @override
  Widget build(BuildContext context) {
    controller.totalP.value = 0;
    for (var i in controller.purchasePlayer) {
      controller.totalP.value += i.finalTotal;
    }
    return Scaffold(
      appBar: AppBar(
      //  backgroundColor: Colors.grey.withOpacity(0.3),
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
                  await controller.getAllPurchase();
                } else if (value == 'd') {
                  controller.purchasePlayer.value = controller.purchase
                      .where((p0) =>
                          p0.date.day == DateTime.now().day &&
                          p0.date.month == DateTime.now().month &&
                          p0.date.year == DateTime.now().year)
                      .toList();
                } else if (value == 'm') {
                  controller.purchasePlayer.value = controller.purchase
                      .where((p0) =>
                          p0.date.month == DateTime.now().month &&
                          p0.date.year == DateTime.now().year)
                      .toList();
                } else if (value == 'y') {
                  controller.purchasePlayer.value = controller.purchase
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
         //   decoration: BoxDecoration(color: Colors.grey.withOpacity(0.3)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5 , left: defaultPadding , right: defaultPadding),
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
                            "Purchase",
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
                                  await Get.find<InfoController>()
                                      .getAllPurchase();
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
                                    columns:  [
                                      DataColumn(
                                        label: Text(
                                          "Purchase Number",
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
                                            "Supplier",
                                                style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: textColor),
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Center(
                                          child: Text(
                                            "Payment Status",
                                                style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: textColor),
                                          ),
                                        ),
                                      ),
                                    ],
                                    rows: List.generate(
                                      controller.purchasePlayer.length,
                                      (index) => DataRow(
                                        cells: [
                                          DataCell(
                                            Text(controller
                                                .purchasePlayer[index].purNo),
                                          ),
                                          DataCell(Center(
                                            child: Text(
                                                DateFormat('dd-MM-yyyy hh:mm a')
                                                    .format(controller
                                                        .purchasePlayer[index]
                                                        .date),style: const TextStyle(fontSize:13,),),
                                          )),
                                          DataCell(Center(
                                            child: Text(controller
                                                .purchasePlayer[index].finalTotal
                                                .toStringAsFixed(2)),
                                          )),
                                          DataCell(Center(
                                            child: Text(
                                              controller
                                                  .purchasePlayer[index].type
                                                  .toUpperCase(),
                                              style: TextStyle(
                                                  color: controller
                                                              .purchasePlayer[
                                                                  index]
                                                              .type ==
                                                          'purchase'
                                                      ? Colors.black54
                                                      : Colors.red,fontSize: 12,),
                                            ),
                                          )),
                                          DataCell(Center(
                                            child: Text(
                                              controller
                                                  .purchasePlayer[index].supplier,
                                            ),
                                          )),
                                          DataCell(Center(
                                            child: Text(
                                              controller
                                                  .purchasePlayer[index].payType
                                                  .toUpperCase(),
                                              style: TextStyle(
                                                  color: controller
                                                              .purchasePlayer[
                                                                  index]
                                                              .payType ==
                                                          'due'
                                                      ? Colors.red
                                                      : controller
                                                                  .purchasePlayer[
                                                                      index]
                                                                  .payType ==
                                                              'paid'
                                                          ? Colors.green
                                                          : primaryColor),
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
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                           Text('Total : ',
                            style: TextStyle(fontWeight: FontWeight.bold,color: primaryColor,fontSize: 20),),
                          Text(
                              '${controller.totalP.value.toStringAsFixed(1)} AED',
                            style: TextStyle(fontWeight: FontWeight.bold,color: primaryColor,fontSize: 20),),
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
