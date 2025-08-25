import 'package:flutter/material.dart';

import '../../../../utils/size_config.dart';
import '../../../../utils/styles.dart';

class TitleDescription extends StatelessWidget {
  const TitleDescription({
    super.key,
    required this.title,
    required this.prefixIcon,
    required this.hintText,
    this.maxLines,
    required this.controller,
  });

  final String title;
  final IconData prefixIcon;
  final String hintText;
  final int? maxLines;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppStyles.headingTextStyle.copyWith(fontSize: 18)),
        SizedBox(height: SizeConfig.getProportionateHeight(8)),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          style: AppStyles.normalTextStyle.copyWith(
            color: Colors.black,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            hintText: hintText,
            hintStyle: AppStyles.normalTextStyle.copyWith(
              color: Colors.black54,
              fontSize: 14,
            ),
            prefixIcon: Icon(prefixIcon),
            filled: true,
            fillColor: Colors.grey,
          ),
        ),
      ],
    );
  }
}
