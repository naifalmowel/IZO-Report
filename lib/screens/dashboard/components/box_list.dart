import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:izo_report/controllers/info_controllers.dart';
import 'package:izo_report/utils/responsive.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import '../../../utils/constants.dart';

class BoxList extends StatefulWidget {
  const BoxList({
    Key? key,
  }) : super(key: key);

  @override
  State<BoxList> createState() => _BoxListState();
}
final controller = Get.find<InfoController>();
class _BoxListState extends State<BoxList> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
         // decoration: BoxDecoration(color: Colors.grey.withOpacity(0.3)),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(defaultPadding),
                  decoration: BoxDecoration(
                   //   color: secondaryColor.withOpacity(0.5),
                      borderRadius:
                      const BorderRadius.all(Radius.circular(10)),
                      border:
                      Border.all(color: primaryColor.withOpacity(0.8))),
                  child: SizedBox(
                    height: Responsive.isMobile(context)
                        ? MediaQuery.of(context).size.height / 2
                        : MediaQuery.of(context).size.width / 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Boxes",
                          style: TextStyle(
                              color: primaryColor,
                              fontSize: 25,
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
                                    .getAllBoxes();
                              },
                              color: primaryColor,
                              showChildOpacityTransition: true,
                              borderWidth: 2,
                              child: GetBuilder<InfoController>(
                                  builder: (controller) {
                                    return DataTable2(
                                      columnSpacing: defaultPadding,
                                      minWidth: 350,
                                      columns: const [
                                        DataColumn(
                                          label: Text(
                                            "Code",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Text(
                                            "Name",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        DataColumn(
                                          tooltip: 'Amount(AED)',
                                          label: Text(
                                            "Amount(AED)",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                      rows: List.generate(
                                        controller.box.length,
                                            (index) => DataRow(
                                          cells: [
                                            DataCell(
                                              Text(controller
                                                  .box[index].code),
                                            ),
                                            DataCell(Text(controller
                                                .box[index].name)),
                                            DataCell(Text((controller
                                                .box[index].balance > 0 ? '${controller
                                                .box[index].balance.toStringAsFixed(2)}/Debit' : '${(controller
                                                .box[index].balance*-1).toStringAsFixed(2)}/Credit')
                                              , style: TextStyle(color: controller
                                                .box[index].balance > 0 ? Colors.green : Colors.red),)),
                                          ],
                                        ),
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
              ],
            ),
          ),
        ),
      ],
    );
  }
}
