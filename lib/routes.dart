import 'package:flutter/material.dart';

import 'pages/counter_page.dart';
import 'pages/history_page.dart';

enum Routes {
  counter('/counter'),
  history('/history');

  final String path;
  const Routes(this.path);
}

Map<String, Widget Function(BuildContext)> get routes => {
      Routes.counter.path: (context) => const CounterPage(),
      Routes.history.path: (context) => const HistoryPage(),
    };
