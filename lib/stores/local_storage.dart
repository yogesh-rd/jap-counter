import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../config.dart';
import '../models/jap_entry.dart';
import '../types.dart';

class LocalStorage {
  static late final SharedPreferences _preferences;
  static bool _isInitialised = false;

  static Future<void> init() async {
    if (_isInitialised) {
      throw Exception('Local storage already initialised.');
    }

    _preferences = await SharedPreferences.getInstance();
    _isInitialised = true;
  }

  static Future<void> setInitialDefaults() async {
    final wereSetBefore =
        _preferences.getBool(StorageKeys.wereDefaultsSet.name);
    if (wereSetBefore ?? false) return;

    await Future.wait([
      setHistory({}),
      setIncrements(AppConfig.defaultIncrements),
      setGoal(AppConfig.defaultGoal),
      setTotalCount(AppConfig.defaultTotalCount),
    ]);

    await _preferences.setBool(StorageKeys.wereDefaultsSet.name, true);
  }

  static T _safeFunctionCall<T>(T Function() func) {
    if (!_isInitialised) {
      throw Exception('Local storage not initialised.');
    }

    return func();
  }

  static Future<Iterable<int>?> getIncrements() async => _safeFunctionCall(
        () async {
          final incrementsJson =
              _preferences.getString(StorageKeys.increments.name);

          return incrementsJson == null
              ? null
              : (jsonDecode(incrementsJson) as Iterable? ?? [])
                  .map((e) => e as int);
        },
      );

  static Future<bool> setIncrements(Iterable<int> increments) async =>
      _safeFunctionCall(
        () async => await _preferences.setString(
          StorageKeys.increments.name,
          jsonEncode(increments.toList()),
        ),
      );

  static Future<Iterable<JapEntry>?> getHistory() async => _safeFunctionCall(
        () async {
          final historyJson = _preferences.getString(StorageKeys.history.name);

          return historyJson == null
              ? null
              : (jsonDecode(historyJson) as Iterable? ?? []).map(
                  (e) => JapEntry.fromJson(e as Map<String, dynamic>),
                );
        },
      );

  static Future<bool> setHistory(Iterable<JapEntry> history) async =>
      _safeFunctionCall(
        () async => await _preferences.setString(
          StorageKeys.history.name,
          jsonEncode(
            history.map((e) => e.toJson()).toList(),
          ),
        ),
      );

  static Future<int?> getGoal() async => _safeFunctionCall(
        () async => _preferences.getInt(StorageKeys.goal.name),
      );

  static Future<bool> setGoal(int goal) async => _safeFunctionCall(
        () async => await _preferences.setInt(StorageKeys.goal.name, goal),
      );

  static Future<int?> getTotalCount() async => _safeFunctionCall(
        () async => _preferences.getInt(StorageKeys.totalCount.name),
      );

  static Future<bool> setTotalCount(int count) async => _safeFunctionCall(
        () async =>
            await _preferences.setInt(StorageKeys.totalCount.name, count),
      );
}
