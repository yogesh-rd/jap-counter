import 'package:flutter/material.dart';

import 'jap_counter.dart';
import 'stores/local_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.init();
  await LocalStorage.setInitialDefaults();
  runApp(const JapCounter());
}
