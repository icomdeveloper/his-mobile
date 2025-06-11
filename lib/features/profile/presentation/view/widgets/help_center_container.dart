import 'package:flutter/material.dart';
import 'package:his/core/utils/app_text_styles.dart';

class HelpCenterContainer extends StatelessWidget {
  const HelpCenterContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 17),
      margin: const EdgeInsets.symmetric(horizontal: 22),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: Color(0xffDFDFDF), width: 1)),
      ),
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Lorem ipsum dolor sit amet ', style: Styles.semiBoldPoppins16),
          SizedBox(
            height: 8,
          ),
          Text(
              'Lorem ipsum dolor sit amet consectetur. Porttitor magna vel faucibus ut id iaculis ac. Mauris nec eget libero bibendum tellus vestibulum amet. Purus ultrices nunc nibh morbi mauris lacus pellentesque velit arcu. Maecenas mattis elit quis enim morbi cum amet eget vulputate. In nibh tempus dictum aliquam felis placerat. ',
              style: Styles.regularPoppins12),
        ],
      ),
    );
  }
}
