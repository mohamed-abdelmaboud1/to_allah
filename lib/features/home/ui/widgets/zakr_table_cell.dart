import 'package:flutter/material.dart';
import 'package:to_allah/core/utils/app_styles.dart';

class ZakrTableCell extends StatelessWidget {
  const ZakrTableCell({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const TableCell(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
        child: Text(
          'الذكر',
          style: AppStyles.kufamStyle14,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
