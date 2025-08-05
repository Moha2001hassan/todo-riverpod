import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../utils/size_config.dart';

class LoginIconBtn extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final Color color;

  const LoginIconBtn({
    super.key,
    required this.onTap,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: SizeConfig.getProportionateHeight(40),
        width: SizeConfig.screenWidth * 0.25,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.black,
            width: 2,
            style: BorderStyle.solid,
          ),
        ),
        child: FaIcon(icon, color: color),
      ),
    );
  }
}