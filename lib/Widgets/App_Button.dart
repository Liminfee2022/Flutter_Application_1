import 'package:flutter/material.dart';
import 'package:flutter_project/assets/app_Style.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const AppButton({Key? key, required this.label, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black87,
              offset: Offset(3, 6),
              blurRadius: 6,
            )
          ],
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Text(label, style: AppStyles.h3),
      ),
    );
  }
}
