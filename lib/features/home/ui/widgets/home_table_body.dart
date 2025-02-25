import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_allah/core/utils/app_colors.dart';
import 'package:to_allah/core/utils/app_styles.dart';
import 'package:to_allah/features/home/data/cubits/home_cubit.dart';
import 'package:to_allah/features/home/data/models/table_row_info.dart';
import 'package:to_allah/features/home/ui/widgets/custom_table_cell.dart';
import 'package:to_allah/features/home/ui/widgets/zakr_item.dart';
import 'package:to_allah/features/home/ui/widgets/zakr_table_cell.dart';
import 'package:to_allah/features/login/models/user_auth.dart';

class HomeTableBody extends StatelessWidget {
  const HomeTableBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeCubitState>(
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Table(
            textDirection: TextDirection.rtl,
            defaultColumnWidth: const IntrinsicColumnWidth(),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            border: TableBorder.all(
              color: AppColors.secondaryColor.withOpacity(0.6),
            ),
            children: [
              _buildTableHeader(cubit.usersAuth),
              _buildMorningAzkar(cubit),
              _buildPrayInNabi(cubit),
              _buildQuranVerse(cubit),
              _buildEveningAzkar(cubit),
              _buildPrayInMasjid(cubit),
              _buildSunnah(cubit),
              _buildMidnightQiam(cubit),
              _buildReadTabark(cubit),
            ],
          ),
        );
      },
    );
  }

  TableRow _buildTableHeader(List<UserAuth> users) {
    return TableRow(
      children: [
        const ZakrTableCell(),
        ...users.map(
          (user) => CustomTableCell(username: user.name),
        ),
      ],
    );
  }

  TableRow _buildTableRow({
    required TableRowInfo tableRowInfo,
    required List<String> values,
    required List<Function()> onTaps,
    required int lengthOfUsers,
    required dynamic trueTarget,
    required dynamic falseTarget,
  }) {
    return TableRow(
      children: [
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: ZakrItem(
            azkarModel: tableRowInfo,
          ),
        ),
        ...List.generate(
          lengthOfUsers,
          (index) => TableCell(
            child: GestureDetector(
              onTap: onTaps[index],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  values[index] == trueTarget.toString()
                      ? '✅'
                      : values[index] == falseTarget.toString()
                          ? '❌'
                          : values[index],
                  style: AppStyles.kufamStyle14,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  TableRow _buildMorningAzkar(HomeCubit cubit) {
    return _buildTableRow(
      trueTarget: true,
      falseTarget: false,
      tableRowInfo: cubit.getTableMorningAzkarInfo(),
      values: cubit.getTableMorningAzkarValues(),
      onTaps: cubit.getTableMorningAzkarOnTaps(),
      lengthOfUsers: cubit.users.length,
    );
  }

  TableRow _buildPrayInMasjid(HomeCubit cubit) {
    return _buildTableRow(
      trueTarget: 5,
      falseTarget: 0,
      tableRowInfo: cubit.getTablePrayInMasjidInfo(),
      values: cubit.getTablePrayInMasjidValues(),
      onTaps: cubit.getTablePrayInMasjidOnTaps(),
      lengthOfUsers: cubit.users.length,
    );
  }

  TableRow _buildSunnah(HomeCubit cubit) {
    return _buildTableRow(
      trueTarget: 12,
      falseTarget: 0,
      tableRowInfo: cubit.getTableSunnahInfo(),
      values: cubit.getTableSunnahValues(),
      onTaps: cubit.getTableSunnahOnTaps(),
      lengthOfUsers: cubit.users.length,
    );
  }

  TableRow _buildPrayInNabi(HomeCubit cubit) {
    return _buildTableRow(
      trueTarget: true,
      falseTarget: false,
      tableRowInfo: cubit.getTablePrayInNabiInfo(),
      values: cubit.getTablePrayInNabiValues(),
      onTaps: cubit.getTablePrayInNabiOnTaps(),
      lengthOfUsers: cubit.users.length,
    );
  }

  TableRow _buildQuranVerse(HomeCubit cubit) {
    return _buildTableRow(
      trueTarget: true,
      falseTarget: false,
      tableRowInfo: cubit.getTableQuranVerseInfo(),
      values: cubit.getTableQuranVerseValues(),
      onTaps: cubit.getTableQuranVerseOnTaps(),
      lengthOfUsers: cubit.users.length,
    );
  }

  TableRow _buildEveningAzkar(HomeCubit cubit) {
    return _buildTableRow(
      trueTarget: true,
      falseTarget: false,
      tableRowInfo: cubit.getTableEveningAzkarInfo(),
      values: cubit.getTableEveningAzkarValues(),
      onTaps: cubit.getTableEveningAzkarOnTaps(),
      lengthOfUsers: cubit.users.length,
    );
  }

  TableRow _buildMidnightQiam(HomeCubit cubit) {
    return _buildTableRow(
      trueTarget: true,
      falseTarget: false,
      tableRowInfo: cubit.getTableMidnightQiamInfo(),
      values: cubit.getTableMidnightQiamValues(),
      onTaps: cubit.getTableMidnightQiamOnTaps(),
      lengthOfUsers: cubit.users.length,
    );
  }

  TableRow _buildReadTabark(HomeCubit cubit) {
    return _buildTableRow(
      trueTarget: true,
      falseTarget: false,
      tableRowInfo: cubit.getTableReadTabarkInfo(),
      values: cubit.getTableReadTabarkValues(),
      onTaps: cubit.getTableReadTabarkOnTaps(),
      lengthOfUsers: cubit.users.length,
    );
  }
}
