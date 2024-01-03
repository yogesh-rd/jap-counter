import 'package:flutter/material.dart';
import 'package:jap_counter/stores/local_storage.dart';

import 'jap_counter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.init();
  await LocalStorage.setInitialDefaults();
  runApp(const JapCounter());
}
