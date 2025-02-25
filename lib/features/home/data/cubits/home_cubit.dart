import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_allah/features/home/data/models/day_info.dart';
import 'package:to_allah/features/home/data/models/user_model.dart';
import 'package:to_allah/features/login/models/user_auth.dart';

import '../../../../core/services/firestore_services.dart';
import '../../../../core/utils/app_images.dart';
import '../../../login/local_data/local_data.dart';
import '../models/table_row_info.dart';

part 'home_cubit_state.dart';

class HomeCubit extends Cubit<HomeCubitState> {
  HomeCubit() : super(HomeInitialState());

  String currentUsername = '';
  final List<UserModel> users = [];
  late int currentDayIndex;

  List<UserAuth> get usersAuth => users.map((user) => user.userAuth).toList();
  List<DayInfo> get daysInfo => users.first.daysInfo;
  DayInfo get currentDayInfo => daysInfo[currentDayIndex];

  Future<void> init() async {
    emit(HomeLoadingState());
    _initCurrentUsername();
    await _initUsers();
    _initCurrentDayIndex();
    emit(HomeLoadedState());
  }

  void updateDayIndex(int dayIndex) {
    currentDayIndex = dayIndex;
    emit(HomeSuccessState());
  }

  void _initCurrentDayIndex() {
    for (var i = 0; i < daysInfo.length; i++) {
      final date = daysInfo[i].date;
      final currentDate = DateTime.now();
      if (date.day == currentDate.day &&
          date.month == currentDate.month &&
          date.year == currentDate.year) {
        currentDayIndex = i;
        break;
      }
    }
  }

  void _initCurrentUsername() {
    currentUsername = LocalData.getUsername()!;
  }

  Future<void> _initUsersAuth() async {
    final result = await FirestoreServices.getUsersAuthList();
    result.fold(
      (failure) => emit(HomeErrorState(failure.message)),
      (usersAuth) {
        for (var userAuth in usersAuth) {
          users.add(
            UserModel(
              userAuth: userAuth,
              daysInfo: [],
            ),
          );
        }
      },
    );
  }

  Future<void> _sortUsersAuth() async {
    for (var user in users) {
      if (user.userAuth.username == currentUsername) {
        users.remove(user);
        users.insert(0, user);
        break;
      }
    }
  }

  Future<void> _initDaysInfo() async {
    for (var user in users) {
      final result = await FirestoreServices.getDaysInfo(
        userUid: user.userAuth.uid,
      );
      result.fold(
        (failure) => emit(HomeErrorState(failure.message)),
        (daysInfo) => user.daysInfo
          ..clear()
          ..addAll(daysInfo),
      );
    }
  }

  Future<void> _initUsers() async {
    await _initUsersAuth();
    await _sortUsersAuth();
    await _initDaysInfo();
  }

  Future<void> _updateDayInfo(int userIndex) async {
    await FirestoreServices.updateDayInfo(
      userUid: users[userIndex].userAuth.uid,
      dayInfo: users[userIndex].daysInfo[currentDayIndex],
    );
  }

  // ** Morning Azkar **
  TableRowInfo getTableMorningAzkarInfo() {
    return TableRowInfo(
      title: 'اذكار الصباح',
      imagePath: Assets.assetsImagesAzkar,
    );
  }

  List<String> getTableMorningAzkarValues() {
    return users
        .map((user) => user.daysInfo[currentDayIndex].morningAzkar.toString())
        .toList();
  }

  List<Function()> getTableMorningAzkarOnTaps() {
    return List.generate(
      users.length,
      (index) => () => _toggleMorningAzkar(userIndex: index),
    );
  }

  Future<void> _toggleMorningAzkar({required int userIndex}) async {
    if (!_isAllowToEdit(userIndex: userIndex)) return;
    users[userIndex].daysInfo[currentDayIndex].toggleMorningAzkar();
    await _updateDayInfo(userIndex);
    emit(HomeSuccessState());
  }

  // ** Pray In Masjid **
  TableRowInfo getTablePrayInMasjidInfo() {
    return TableRowInfo(
      title: 'الصلاة في المسجد',
      imagePath: Assets.assetsImagesPrayer,
    );
  }

  List<String> getTablePrayInMasjidValues() {
    return users
        .map((user) => user.daysInfo[currentDayIndex].prayInMasjid.toString())
        .toList();
  }

  List<Function()> getTablePrayInMasjidOnTaps() {
    return List.generate(
      users.length,
      (index) => () => _incrementPrayInMasjid(userIndex: index),
    );
  }

  Future<void> _incrementPrayInMasjid({required int userIndex}) async {
    if (!_isAllowToEdit(userIndex: userIndex)) return;
    users[userIndex].daysInfo[currentDayIndex].incrementPrayInMasjid();
    await _updateDayInfo(userIndex);
    emit(HomeSuccessState());
  }

  // ** Sunnah **
  TableRowInfo getTableSunnahInfo() {
    return TableRowInfo(
      title: 'السنن المؤكده',
      imagePath: Assets.assetsImagesBeads,
    );
  }

  List<String> getTableSunnahValues() {
    return users
        .map((user) => user.daysInfo[currentDayIndex].sunnah.toString())
        .toList();
  }

  List<Function()> getTableSunnahOnTaps() {
    return List.generate(
      users.length,
      (index) => () => _incrementSunnah(userIndex: index),
    );
  }

  Future<void> _incrementSunnah({required int userIndex}) async {
    if (!_isAllowToEdit(userIndex: userIndex)) return;
    users[userIndex].daysInfo[currentDayIndex].incrementSunnah();
    await _updateDayInfo(userIndex);
    emit(HomeSuccessState());
  }

  // ** Pray In Nabi **
  TableRowInfo getTablePrayInNabiInfo() {
    return TableRowInfo(
      title: 'الصلاة علي النبي',
      imagePath: Assets.assetsImagesPrayer,
    );
  }

  List<String> getTablePrayInNabiValues() {
    return users
        .map((user) => user.daysInfo[currentDayIndex].prayInNabi.toString())
        .toList();
  }

  List<Function()> getTablePrayInNabiOnTaps() {
    return List.generate(
      users.length,
      (index) => () => _togglePrayInNabi(userIndex: index),
    );
  }

  Future<void> _togglePrayInNabi({required int userIndex}) async {
    if (!_isAllowToEdit(userIndex: userIndex)) return;
    users[userIndex].daysInfo[currentDayIndex].togglePrayInNabi();
    await _updateDayInfo(userIndex);
    emit(HomeSuccessState());
  }

  // ** Quran Verse **
  TableRowInfo getTableQuranVerseInfo() {
    return TableRowInfo(
      title: 'ورد القرآن',
      imagePath: Assets.assetsImagesLogo,
    );
  }

  List<String> getTableQuranVerseValues() {
    return users
        .map((user) => user.daysInfo[currentDayIndex].quranVerse.toString())
        .toList();
  }

  List<Function()> getTableQuranVerseOnTaps() {
    return List.generate(
      users.length,
      (index) => () => _toggleQuranVerse(userIndex: index),
    );
  }

  Future<void> _toggleQuranVerse({required int userIndex}) async {
    if (!_isAllowToEdit(userIndex: userIndex)) return;
    users[userIndex].daysInfo[currentDayIndex].toggleQuranVerse();
    await _updateDayInfo(userIndex);
    emit(HomeSuccessState());
  }

  // ** Evening Azkar **
  TableRowInfo getTableEveningAzkarInfo() {
    return TableRowInfo(
      title: 'أذكار المساء',
      imagePath: Assets.assetsImagesAzkar,
    );
  }

  List<String> getTableEveningAzkarValues() {
    return users
        .map((user) => user.daysInfo[currentDayIndex].eveningAzkar.toString())
        .toList();
  }

  List<Function()> getTableEveningAzkarOnTaps() {
    return List.generate(
      users.length,
      (index) => () => _toggleEveningAzkar(userIndex: index),
    );
  }

  Future<void> _toggleEveningAzkar({required int userIndex}) async {
    if (!_isAllowToEdit(userIndex: userIndex)) return;
    users[userIndex].daysInfo[currentDayIndex].toggleEveningAzkar();
    await _updateDayInfo(userIndex);
    emit(HomeSuccessState());
  }

  // ** Midnight Qiam **
  TableRowInfo getTableMidnightQiamInfo() {
    return TableRowInfo(
      title: 'قيام الليل',
      imagePath: Assets.assetsImagesNight,
    );
  }

  List<String> getTableMidnightQiamValues() {
    return users
        .map((user) => user.daysInfo[currentDayIndex].midnightQiam.toString())
        .toList();
  }

  List<Function()> getTableMidnightQiamOnTaps() {
    return List.generate(
      users.length,
      (index) => () => _toggleMidnightQiam(userIndex: index),
    );
  }

  Future<void> _toggleMidnightQiam({required int userIndex}) async {
    if (!_isAllowToEdit(userIndex: userIndex)) return;
    users[userIndex].daysInfo[currentDayIndex].toggleMidnightQiam();
    await _updateDayInfo(userIndex);
    emit(HomeSuccessState());
  }

  // ** Read Tabark **
  TableRowInfo getTableReadTabarkInfo() {
    return TableRowInfo(
      title: 'سورة الملك قبل النوم',
      imagePath: Assets.assetsImagesLogo,
    );
  }

  List<String> getTableReadTabarkValues() {
    return users
        .map((user) => user.daysInfo[currentDayIndex].readTabark.toString())
        .toList();
  }

  List<Function()> getTableReadTabarkOnTaps() {
    return List.generate(
      users.length,
      (index) => () => _toggleReadTabark(userIndex: index),
    );
  }

  Future<void> _toggleReadTabark({required int userIndex}) async {
    if (!_isAllowToEdit(userIndex: userIndex)) return;
    users[userIndex].daysInfo[currentDayIndex].toggleReadTabark();
    await _updateDayInfo(userIndex);
    emit(HomeSuccessState());
  }

  bool _isAllowToEdit({required int userIndex}) {
    return currentUsername == users[userIndex].userAuth.username;
  }

  // We call it only one time to initialize the Firebase Days
  Future<void> _initializeFirebaseDays() async {
    final List<DayModel> days = [];
    final DateTime initialDate = DateTime(2025, 2, 25);
    final DateTime lastDate = DateTime(2030, 1, 1);
  // For data entry
  // Future<void> _insertDaysInfo() async {
  //   final List<DayInfo> days = [];
  //   final DateTime initialDate = DateTime(2024, 9, 7);
  //   final DateTime lastDate = DateTime(2025, 1, 1);

  //   // Add the days between initial date and last date
  //   DateTime date = initialDate;
  //   while (date.isBefore(lastDate)) {
  //     final dayModel = DayInfo(date: date);
  //     days.add(dayModel);
  //     date = date.add(const Duration(days: 1));
  //   }

  //   for (var user in usersAuth) {
  //     for (var day in days) {
  //       await FirestoreServices.addDayInfo(
  //         userUid: user.uid,
  //         dayInfo: day,
  //       );
  //     }
  //   }
  // }
}
