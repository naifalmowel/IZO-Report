import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/constants.dart';

class CardProfitWidget extends StatelessWidget {
  const CardProfitWidget({
    Key? key,
    required this.title,
    required this.svgSrc,
    required this.amountOfFiles,
    required this.numOfFiles,
    required this.color,
  }) : super(key: key);

  final String title, svgSrc, amountOfFiles;
  final int numOfFiles;
  final Color color;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      margin: const EdgeInsets.only(top: defaultPadding),
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: primaryColor.withOpacity(0.15)),
        borderRadius: const BorderRadius.all(
          Radius.circular(defaultPadding),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: SizedBox(
              height: width > height ? 20 : 40,
              width: width > height ? 20 : 40,
              child: SvgPicture.asset(svgSrc),
            ),
          ),
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  CircleAvatar(
                    backgroundColor: color,
                    radius: 5,
                  ),
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:  TextStyle(
                      color: Colors.black,
                      fontSize: width < height ? 10 : 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              flex:2 ,child: Text('$amountOfFiles  AED' , style: TextStyle(fontSize: width < height ? 10 : 13))),
        ],
      ),
    );
  }
}
