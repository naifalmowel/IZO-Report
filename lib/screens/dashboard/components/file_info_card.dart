import 'package:flutter/material.dart';
import '../../../utils/constants.dart';

class FileInfoCard extends StatelessWidget {
  const FileInfoCard({
    super.key,
    required this.color,
    required this.title,
    required this.total,
    required this.percentage,
    required this.voucherSelected,
    required this.onSelected,
    required this.onTap,
    this.rTotal
  });

  final String title;
  final Color color;
  final int percentage;
  final double total;
  final double? rTotal;
  final Function(String value) voucherSelected;

  final Function(String value) onSelected;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    double textSize = 0.0;
    width > height ? textSize = width / height : textSize = height / width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
            color: secondaryColor.withOpacity(0.08),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            border: Border.all(color: primaryColor.withOpacity(0.8))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                title == 'Voucher'
                    ? PopupMenuButton(
                        tooltip: 'Type',
                        iconSize: 22,
                        icon:  Icon(
                          Icons.more_vert,
                          color: primaryColor,
                        ),
                        color: Colors.white,
                        onSelected: voucherSelected,
                        itemBuilder: (BuildContext bc) {
                          return [
                            const PopupMenuItem(
                              value: 'p',
                              child: Text("Payment"),
                            ),
                            const PopupMenuItem(
                              value: 'r',
                              child: Text("Receipt"),
                            ),
                          ];
                        })
                    : PopupMenuButton(
                        tooltip: 'Type',
                        iconSize: 22,
                        icon:  Icon(
                          Icons.more_vert,
                          color: primaryColor,
                        ),
                        color: Colors.white,
                        onSelected: onSelected,
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
                        }),
                Expanded(
                  flex: 5,
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: textSize * 7,
                      color: textColor,
                    ),
                  ),
                ),
              ],
            ),
          if(title != 'Voucher')  ProgressLine(
              color: color,
              percentage: percentage,
            ),
            title == 'Voucher' ?  Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(
                        "P: ${total.toStringAsFixed(2)}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: color,
                            fontSize: textSize * 7,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'AED',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color:textColor,
                          fontSize: textSize * 6),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(
                        "R: ${(rTotal??0.0).toStringAsFixed(2)}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: color,
                            fontSize: textSize * 7,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'AED',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color:textColor,
                          fontSize: textSize * 6),
                    ),
                  ],
                )
              ],
            ) : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Text(
                    total.toStringAsFixed(2),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: color,
                        fontSize: textSize * 7,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'AED',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color:textColor,
                      fontSize: textSize * 5),
                ),
              ],
            ) ,
          ],
        ),
      ),
    );
  }
}

class ProgressLine extends StatelessWidget {
  const ProgressLine({
    super.key,
    this.color,
    required this.percentage,
  });

  final Color? color;
  final int? percentage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 5,
          decoration: BoxDecoration(
            color: color!.withOpacity(0.1),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) => Container(
            width: constraints.maxWidth * (percentage! / 100),
            height: 5,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }
}
