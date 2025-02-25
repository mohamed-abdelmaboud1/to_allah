import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

import '../../data/cubits/home_cubit.dart';
import 'home_table_body.dart';
import 'home_table_date.dart';
import 'table_shimmer.dart';

class HomeTablePageView extends HookWidget {
  const HomeTablePageView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = usePageController();
    return BlocConsumer<HomeCubit, HomeCubitState>(
      listener: (context, state) {
        if (state is HomeLoadedState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            controller.jumpToPage(
              context.read<HomeCubit>().currentDayIndex,
            );
          });
        }
      },
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();
        if (state is HomeLoadingState) {
          return const Padding(
            padding: EdgeInsets.all(12),
            child: TableShimmer(),
          );
        }

        return ExpandablePageView.builder(
          controller: controller,
          reverse: true,
          itemBuilder: (context, index) {
            return const Column(
              children: [
                HomeTableDate(),
                Gap(10),
                HomeTableBody(),
              ],
            );
          },
          onPageChanged: cubit.updateDayIndex,
          itemCount: cubit.daysInfo.length,
        );
      },
    );
  }
}
