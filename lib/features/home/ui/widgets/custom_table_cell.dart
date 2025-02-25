import 'package:flutter/material.dart';
import 'package:to_allah/core/utils/app_styles.dart';

class CustomTableCell extends StatelessWidget {
  const CustomTableCell({
    super.key,
    required this.username,
  });
  final String username;
  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Text(
          username,
          style: AppStyles.kufamStyle14,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
