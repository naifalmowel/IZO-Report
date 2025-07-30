import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:izo_report/controllers/info_controllers.dart';
import 'package:izo_report/utils/responsive.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../../../utils/constants.dart';

class VoucherList extends StatefulWidget {
  const VoucherList({
    required this.type,
    Key? key,
  }) : super(key: key);
  final String type;

  @override
  State<VoucherList> createState() => _VoucherListState();
}

class _VoucherListState extends State<VoucherList> {
  final controller = Get.find<InfoController>();

  @override
  void initState() {
    controller.voucherPlayer.value = Get.find<InfoController>()
        .voucher
        .where((p0) => p0.type == widget.type)
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    controller.totalV.value = 0;
    for (var i in controller.voucherPlayer) {
      controller.totalV.value += i.total;
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
                if (widget.type == 'Payment') {
                  if (value == 'a') {
                    await controller.getAllVoucher();
                    controller.voucherPlayer.value = controller.voucher
                        .where((p0) => p0.type == 'Payment')
                        .toList();
                  } else if (value == 'd') {
                    controller.voucherPlayer.value = controller.voucher
                        .where((p0) => p0.type == 'Payment')
                        .toList()
                        .where((p0) =>
                            p0.date.day == DateTime.now().day &&
                            p0.date.month == DateTime.now().month &&
                            p0.date.year == DateTime.now().year)
                        .toList();
                  } else if (value == 'm') {
                    controller.voucherPlayer.value = controller.voucher
                        .where((p0) => p0.type == 'Payment')
                        .toList()
                        .where((p0) =>
                            p0.date.month == DateTime.now().month &&
                            p0.date.year == DateTime.now().year)
                        .toList();
                  } else if (value == 'y') {
                    controller.voucherPlayer.value = controller.voucher
                        .where((p0) => p0.type == 'Payment')
                        .toList()
                        .where((p0) => p0.date.year == DateTime.now().year)
                        .toList();
                  }
                } else {
                  if (value == 'a') {
                    await controller.getAllVoucher();
                    controller.voucherPlayer.value = controller.voucher
                        .where((p0) => p0.type != 'Payment')
                        .toList();
                  } else if (value == 'd') {
                    controller.voucherPlayer.value = controller.voucher
                        .where((p0) => p0.type != 'Payment')
                        .toList()
                        .where((p0) =>
                            p0.date.day == DateTime.now().day &&
                            p0.date.month == DateTime.now().month &&
                            p0.date.year == DateTime.now().year)
                        .toList();
                  } else if (value == 'm') {
                    controller.voucherPlayer.value = controller.voucher
                        .where((p0) => p0.type != 'Payment')
                        .toList()
                        .where((p0) =>
                            p0.date.month == DateTime.now().month &&
                            p0.date.year == DateTime.now().year)
                        .toList();
                  } else if (value == 'y') {
                    controller.voucherPlayer.value = controller.voucher
                        .where((p0) => p0.type == 'Payment')
                        .toList()
                        .where((p0) => p0.date.year == DateTime.now().year)
                        .toList();
                  }
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
            padding: const EdgeInsets.only(
                top: 5, left: defaultPadding, right: defaultPadding),
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
                            widget.type == 'Payment' ? "Payment" : "Receipt",
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
                                      .getAllVoucher();
                                },
                                color: primaryColor,
                                showChildOpacityTransition: true,
                                borderWidth: 2,
                                child: GetBuilder<InfoController>(
                                    builder: (controller) {
                                  var list = [];
                                  return DataTable2(
                                    columnSpacing: defaultPadding,
                                    minWidth: 700,
                                    dataRowHeight: 70,
                                    columns: [
                                      DataColumn(
                                        label: Text(
                                          "Voucher Number",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: textColor),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          widget.type == 'Payment'
                                              ? "Supplier"
                                              : "Customer",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: textColor),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          "Account",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: textColor),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          "Date",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: textColor),
                                        ),
                                      ),
                                      DataColumn(
                                        tooltip: 'Amount(AED)',
                                        label: Text(
                                          "Amount(AED)",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: textColor),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          "Note",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: textColor),
                                        ),
                                      ),
                                      // DataColumn(
                                      //   label: Text(
                                      //     widget.type == 'Payment'
                                      //         ? "Purchase No"
                                      //         : "Sales No",
                                      //     style:
                                      //         const TextStyle(fontWeight: FontWeight.bold),
                                      //   ),
                                      // ),
                                    ],
                                    rows: List.generate(
                                      controller.voucherPlayer.length,
                                      (index) {
                                        if (widget.type == 'Payment') {
                                          for (var i in controller.purchase) {
                                            if (controller.voucherPlayer[index]
                                                    .billId!
                                                    .contains(
                                                        i.id.toString()) &&
                                                !list.contains(i.purNo)) {
                                              list.add(i.purNo);
                                            }
                                          }
                                        } else {
                                          for (var i in controller.bills) {
                                            if (controller.voucherPlayer[index]
                                                    .billId!
                                                    .contains(
                                                        i.id.toString()) &&
                                                !list.contains(i.billNum)) {
                                              list.add(i.billNum);
                                            }
                                          }
                                        }
                                        return DataRow(
                                          cells: [
                                            DataCell(
                                              Text(controller
                                                  .voucherPlayer[index].vouNo),
                                            ),
                                            DataCell(
                                              Text(controller
                                                  .voucherPlayer[index]
                                                  .contact),
                                            ),
                                            DataCell(
                                              Text(controller
                                                  .voucherPlayer[index]
                                                  .account),
                                            ),
                                            DataCell(Text(
                                                DateFormat('dd-MM-yyyy hh:mm')
                                                    .format(controller
                                                        .voucherPlayer[index]
                                                        .date))),
                                            DataCell(Text(controller
                                                .voucherPlayer[index].total
                                                .toStringAsFixed(2))),
                                            DataCell(Text(controller
                                                .voucherPlayer[index].note)),
                                            //   DataCell(Text(list.toString())),
                                          ],
                                        );
                                      },
                                    ),
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
                   // color: Colors.grey[400],
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                           Text('Total : ',
                            style: TextStyle(fontWeight: FontWeight.bold,color: primaryColor,fontSize: 20),),
                          Text(
                              '${controller.totalV.value.toStringAsFixed(1)} AED',
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
