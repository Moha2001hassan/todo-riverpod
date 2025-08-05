import 'package:flutter/material.dart';

import '../../../../utils/size_config.dart';
import '../../../../utils/styles.dart';

class CommonButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Color? color;

  const CommonButton({
    super.key,
    required this.title,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color ?? Colors.blue,
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          alignment: Alignment.center,
          height: SizeConfig.getProportionateHeight(50),
          width: SizeConfig.screenWidth,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
          child: Text(
            title,
            style: AppStyles.titleTextStyle.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
