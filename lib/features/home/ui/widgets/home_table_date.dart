import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_allah/core/helpers/date_to_string.dart';
import 'package:to_allah/core/utils/app_styles.dart';
import 'package:to_allah/features/home/data/cubits/home_cubit.dart';

class HomeTableDate extends StatelessWidget {
  const HomeTableDate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeCubitState>(
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();
        return Text(
          dateToString(
            cubit.currentDayInfo.date,
            isArabic: true,
          ), // Display the date
          style: AppStyles.kufamStyle14,
        );
      },
    );
  }
}
