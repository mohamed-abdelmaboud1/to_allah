import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:to_allah/core/routing/app_router.dart';
import 'package:to_allah/features/login/local_data/local_data.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        LocalData.setIsLogin(false);
        context.go(AppRouter.login);
      },
      child: const Text(
        'تسجيل الخروج',
        style: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
