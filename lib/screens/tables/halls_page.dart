import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:izo_report/controllers/info_controllers.dart';
import 'package:izo_report/screens/tables/tables_widget.dart';
import 'package:izo_report/utils/responsive.dart';
import '../../../utils/constants.dart';

class HallPage extends StatelessWidget {
  const HallPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
            //  color: secondaryColor.withOpacity(0.5),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: primaryColor.withOpacity(0.8))),
        child: SizedBox(
          height: Responsive.isMobile(context)
              ? MediaQuery.of(context).size.height / 2
              : Get.find<InfoController>().appType.value == 'REST'
                  ? MediaQuery.of(context).size.width / 2
                  : Get.find<InfoController>().appType.value == 'RETAIL'
                      ? MediaQuery.of(context).size.width / 4.5
                      : MediaQuery.of(context).size.width / 3,
          child: RefreshIndicator(
            color: primaryColor,
            onRefresh: ()async{
              await Get.find<InfoController>().getIzoReportInfo();
              await Get.find<InfoController>().getInformation();
              await Get.find<InfoController>().getAllHalls();
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Tables",
                          style: TextStyle(
                              color: primaryColor,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    IconButton(
                        onPressed: () async {
                          await Get.find<InfoController>().getIzoReportInfo();
                          await Get.find<InfoController>().getInformation();
                        },
                        icon: Icon(
                          Icons.refresh,
                          color: primaryColor,
                        ))
                  ],
                ),
                Divider(
                  color: primaryColor,
                  thickness: 4,
                ),
              Obx(()=>  Get.find<InfoController>().isLoadingHall.value
                  ? CircularProgressIndicator(
                color: primaryColor,
              )
                  : Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child:
                  GetBuilder<InfoController>(builder: (controller) {
                    return SingleChildScrollView(
                      child: Column(
                        children: Get.find<InfoController>()
                            .appType
                            .value ==
                            'REST'
                            ? controller.halls
                            .where((p0) => p0.id > -2)
                            .map((element) => HallWidget(
                            number: element.id,
                            tables: element.tables,
                            name: element.name))
                            .toList()
                            : Get.find<InfoController>().appType.value ==
                            'RETAIL'
                            ? controller.halls
                            .where((p0) =>
                        p0.id > -2 &&
                            (p0.name == "TakeAway"))
                            .map((element) => HallWidget(
                            number: element.id,
                            tables: element.tables,
                            name: element.name))
                            .toList()
                            : controller.halls
                            .where((p0) =>
                        p0.id > -2 &&
                            (p0.name == "TakeAway" ||
                                p0.name == "Delivery"))
                            .map((element) => HallWidget(
                            number: element.id,
                            tables: element.tables,
                            name: element.name))
                            .toList(),
                      ),
                    );
                  }),
                ),
              ),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//Get.find<InfoController>().appType.value =='REST'
