import 'dart:collection';

import 'package:flutter/material.dart';

import '../models/jap_entry.dart';
import 'local_storage.dart';

class CounterStore extends ChangeNotifier {
  CounterStore() {
    _init();
  }

  Future<void> _init() async {
    await Future.wait(
      [
        _setIncrementsFromLocalStorage(),
        _setHistoryFromLocalStorage().then(
          (_) => _setTotalCountFromHistory(),
        ),
      ],
    );

    notifyListeners();
  }

  int _totalCount = 0;
  int get totalCount => _totalCount;
  void setTotalCount(int count) {
    _totalCount = count;
    LocalStorage.setTotalCount(_totalCount);
    notifyListeners();
  }

  int _goal = 200000;
  int get goal => _goal;
  void setGoal(int newGoal) {
    _goal = newGoal;
    LocalStorage.setGoal(newGoal);
    notifyListeners();
  }

  void _setTotalCountFromHistory() {
    var sum = 0;
    for (final el in _history) {
      sum += el.count;
    }
    _totalCount = sum;
  }

  SplayTreeSet<int> _increments = SplayTreeSet<int>();
  List<int> get increments => _increments.toList();

  void addIncrement(int i) {
    final wasAdded = _increments.add(i);
    if (wasAdded) {
      notifyListeners();
      _saveIncrementsToLocalStorage();
    }
  }

  void removeIncrement(int i) {
    final wasRemoved = _increments.remove(i);
    if (wasRemoved) {
      notifyListeners();
      _saveIncrementsToLocalStorage();
    }
  }

  void _saveIncrementsToLocalStorage() {
    LocalStorage.setIncrements(_increments);
  }

  Future<void> _setIncrementsFromLocalStorage() async {
    final incrementsIterable = await LocalStorage.getIncrements();
    _increments = SplayTreeSet.from(incrementsIterable ?? <int>[]);
  }

  Set<JapEntry> _history = {};
  List<JapEntry> get history => _history.toList();

  void addJapEntry(JapEntry entry) {
    _history = {entry, ..._history};
    notifyListeners();
    _saveHistoryToLocalStorage();
  }

  void removeJapEntry(JapEntry entry) {
    final wasRemoved = _history.remove(entry);
    if (wasRemoved) {
      notifyListeners();
      setTotalCount(_totalCount - entry.count);
      _saveHistoryToLocalStorage();
    }
  }

  void clearHistory() {
    _history.clear();
    _saveHistoryToLocalStorage();
    notifyListeners();
  }

  void _saveHistoryToLocalStorage() {
    LocalStorage.setHistory(_history);
  }

  Future<void> _setHistoryFromLocalStorage() async {
    final japEntriesIterable = await LocalStorage.getHistory();
    _history = Set.from(japEntriesIterable ?? <JapEntry>[]);
  }

  Future<void> logJaps(int count) async {
    final now = DateTime.now();
    setTotalCount(_totalCount + count);
    final japEntry = JapEntry(timestamp: now, count: count);
    addJapEntry(japEntry);
  }

  void reset() {
    setTotalCount(0);
    clearHistory();
    notifyListeners();
  }

  bool _inEditMode = false;
  bool get inEditMode => _inEditMode;
  void setInEditMode(bool flag) {
    _inEditMode = flag;
    notifyListeners();
  }
}
