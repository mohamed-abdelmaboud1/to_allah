import 'package:to_allah/features/home/data/models/day_info.dart';
import 'package:to_allah/features/login/models/user_auth.dart';

class UserModel {
  final UserAuth userAuth;
  final List<DayInfo> daysInfo;

  UserModel({
    required this.userAuth,
    required this.daysInfo,
  });
}
