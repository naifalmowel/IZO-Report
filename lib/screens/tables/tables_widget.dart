import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:izo_report/models/table_model.dart';
import '../../controllers/info_controllers.dart';
import '../../utils/constants.dart';

class HallWidget extends StatefulWidget {
  const HallWidget(
      {required this.number,
      required this.tables,
      super.key,
      required this.name});
  final List<TableModel> tables;
  final int number;
  final String name;

  @override
  State<HallWidget> createState() => _HallWidgetState();
}

class _HallWidgetState extends State<HallWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Container(
          height: 40,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: primaryColor.withOpacity(0.5)),
          child: Center(
              child: Text(
            widget.number <= 0
                ? Get.find<InfoController>().appType.value == 'REST'
                    ? widget.name
                    : widget.name == "TakeAway"
                        ? "Sales"
                        : widget.name
                : '${'Hall ${widget.number}'} - ${widget.name}',
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 17),
          )),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          child: GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: Get.width > 650 ? 5 : 3,
                childAspectRatio:
                    Get.height < 1000 && Get.width < 650 ? 2.2 : 2),
            itemCount: widget.tables.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  if (widget.tables[index].cost != 0 ||
                      widget.tables[index].bookingTable!) {
                    Get.dialog(Dialog(
                      shape: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      insetPadding: const EdgeInsets.all(16),
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Text(
                                  'Information',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                      color: primaryColor),
                                ),
                                Divider(
                                  color: primaryColor,
                                  thickness: 4,
                                ),
                                Row(
                                  children: [
                                    widget.tables[index].cost != 0
                                        ? Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: primaryColor),
                                                      borderRadius:
                                                          const BorderRadius.all(
                                                              Radius.circular(
                                                                  20))),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(8.0),
                                                    child: Column(
                                                      crossAxisAlignment: widget
                                                              .tables[index]
                                                              .bookingTable!
                                                          ? CrossAxisAlignment
                                                              .center
                                                          : CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          'Table information',
                                                          style: TextStyle(
                                                              fontSize: 19,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              color:
                                                                  primaryColor),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Divider(
                                                            thickness: 4,
                                                            color: secondaryColor,
                                                          ),
                                                        ),
                                                        Text(
                                                            'Hall : ${Get.find<InfoController>().appType.value == 'REST'
                                                                ? widget.name
                                                                : widget.name == "TakeAway"
                                                                ? "Sales"
                                                                : widget.name}'),
                                                        Text(
                                                            'Table : ${widget.tables[index].number}'),
                                                        Text(
                                                            'Time : ${DateFormat('hh:mm aaa').format(widget.tables[index].time!)}'),
                                                        Text(
                                                            'Amount : ${widget.tables[index].cost.toStringAsFixed(2)}'),
                                                      ],
                                                    ),
                                                  )),
                                            ),
                                          )
                                        : const SizedBox(),
                                    widget.tables[index].bookingTable!
                                        ? Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: primaryColor),
                                                      borderRadius:
                                                          const BorderRadius.all(
                                                              Radius.circular(
                                                                  20))),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(8.0),
                                                    child: Column(
                                                      crossAxisAlignment: widget
                                                                  .tables[index]
                                                                  .cost !=
                                                              0
                                                          ? CrossAxisAlignment
                                                              .center
                                                          : CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          'Booking',
                                                          style: TextStyle(
                                                              fontSize: 19,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              color:
                                                                  primaryColor),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10.0),
                                                          child: Divider(
                                                            thickness: 4,
                                                            color: secondaryColor,
                                                          ),
                                                        ),
                                                        Text(
                                                          'Date : ${DateFormat('dd/MM hh:mm a').format(widget.tables[index].bookingDate ?? DateTime.now())}',
                                                          style: const TextStyle(
                                                              fontSize: 15),
                                                        ),
                                                        Text(
                                                            'Guest Name : ${widget.tables[index].guestName}',
                                                            style:
                                                                const TextStyle(
                                                                    fontSize: 15))
                                                      ],
                                                    ),
                                                  )),
                                            ),
                                          )
                                        : const SizedBox(),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ));
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: widget.tables[index].cost != 0
                                ? Colors.green.withOpacity(0.7)
                                : Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black54.withOpacity(0.1),
                                spreadRadius: 3,
                                blurRadius: 5,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              )
                            ]),
                        child: Center(child: Text(widget.tables[index].number)),
                      ),
                      widget.tables[index].bookingTable!
                          ? const Icon(
                              Icons.lock,
                              color: Colors.redAccent,
                              size: 20,
                            )
                          : const SizedBox()
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
