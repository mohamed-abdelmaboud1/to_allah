import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:to_allah/core/helpers/date_to_string.dart';
import 'package:to_allah/core/helpers/print.dart';
import 'package:to_allah/core/models/failure.dart';
import 'package:to_allah/core/utils/app_keys.dart';
import 'package:to_allah/features/home/data/models/day_info.dart';
import 'package:to_allah/features/home/data/models/table_data_model.dart';
import 'package:to_allah/features/home/data/models/user_data_model.dart';

import '../../features/login/models/user_auth.dart';

class FirestoreServices {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<Either<Failure, List<UserAuth>>> getUsersAuthList() async {
    try {
      final snapshot = await _firestore.collection(AppKeys.usersAuth).get();
      final users =
          snapshot.docs.map((doc) => UserAuth.fromJson(doc.data())).toList();
      return right(users);
    } on Exception catch (e) {
      Print.error(e.toString());
      return left(Failure(e.toString()));
    }
  }

  static Future<Either<Failure, List<UserDataModel>>> getUsersData() async {
    try {
      // Get the list of users
      final usersSnapshot =
          await _firestore.collection(AppKeys.usersData).get();

      final List<UserDataModel> usersData = [];
      // Loop through each user
      for (final doc in usersSnapshot.docs) {
        // Get snapshot of table data sorted by dayIndex
        final userSnapshot = await _firestore
            .collection(AppKeys.usersData)
            .doc(doc.id) // doc.id is the username
            .collection(AppKeys.tablesData)
            .orderBy('dayIndex')
            .get();

        // Convert the table data snapshot to a list
        final tableData = userSnapshot.docs
            .map((doc) => TableDataModel.fromJson(doc.data()))
            .toList();

        // Create the user data model
        final userData = UserDataModel(
          username: doc.id,
          data: tableData,
        );

        // Add the user data to the list
        usersData.add(userData);
      }
      return right(usersData);
    } on Exception catch (e) {
      Print.error(e.toString());
      return left(Failure(e.toString()));
    }
  }

  static Future<Either<Failure, void>> addDayDoc({
    required String username,
    required TableDataModel tableData,
  }) async {
    try {
      _firestore
          .collection(AppKeys.usersData)
          .doc(username)
          .collection(AppKeys.tablesData)
          .doc(dateToString(tableData.dayDate))
          .set(tableData.toJson());
      return right(null);
    } on Exception catch (e) {
      Print.error(e.toString());
      return left(Failure(e.toString()));
    }
  }

  static Future<Either<Failure, void>> updateTableData({
    required String username,
    required TableDataModel tableData,
  }) async {
    try {
      _firestore
          .collection(AppKeys.usersData)
          .doc(username)
          .collection(AppKeys.tablesData)
          .doc(dateToString(tableData.dayDate))
          .update(tableData.toJson());
      return right(null);
    } on Exception catch (e) {
      Print.error(e.toString());
      return left(Failure(e.toString()));
    }
  }

  static Future<Either<Failure, List<DayInfo>>> getUserDays({
    required String uid,
  }) async {
    try {
      final snapshot = await _firestore
          .collection(AppKeys.usersData)
          .doc(uid)
          .collection(AppKeys.daysInfo)
          .get();
      final days =
          snapshot.docs.map((doc) => DayInfo.fromJson(doc.data())).toList();
      return right(days);
    } on Exception catch (e) {
      Print.error(e.toString());
      return left(Failure(e.toString()));
    }
  }

  static Future<Either<Failure, void>> addDayInfo({
    required String userUid,
    required DayInfo dayInfo,
  }) async {
    try {
      await _firestore
          .collection(AppKeys.usersAuth)
          .doc(userUid)
          .collection(AppKeys.daysInfo)
          .doc(dateToString(dayInfo.date))
          .set(dayInfo.toJson());
      return right(null);
    } on Exception catch (e) {
      Print.error(e.toString());
      return left(Failure(e.toString()));
    }
  }

  static Future<Either<Failure, void>> updateDayInfo({
    required String userUid,
    required DayInfo dayInfo,
  }) async {
    try {
      await _firestore
          .collection(AppKeys.usersAuth)
          .doc(userUid)
          .collection(AppKeys.daysInfo)
          .doc(dateToString(dayInfo.date))
          .update(dayInfo.toJson());
      return right(null);
    } on Exception catch (e) {
      Print.error(e.toString());
      return left(Failure(e.toString()));
    }
  }

  static Future<Either<Failure, List<DayInfo>>> getDaysInfo({
    required String userUid,
  }) async {
    try {
      final snapshot = await _firestore
          .collection(AppKeys.usersAuth)
          .doc(userUid)
          .collection(AppKeys.daysInfo)
          .orderBy('date', descending: false)
          .get();
      final days =
          snapshot.docs.map((doc) => DayInfo.fromJson(doc.data())).toList();
      return right(days);
    } on Exception catch (e) {
      Print.error(e.toString());
      return left(Failure(e.toString()));
    }
  }

  
}
