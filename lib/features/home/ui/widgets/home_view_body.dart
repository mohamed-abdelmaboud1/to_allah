import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:to_allah/features/home/ui/widgets/table_logo.dart';

import 'home_table_page_view.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TableLogo(),
        Gap(20),
        HomeTablePageView(),
        Gap(20),
        // LogoutButton(),
      ],
    );
  }
}
