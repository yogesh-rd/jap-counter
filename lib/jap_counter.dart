import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'routes.dart';
import 'stores/counter_store.dart';

class JapCounter extends StatelessWidget {
  const JapCounter({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CounterStore(),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData.dark(), // Standard dark theme
        themeMode: ThemeMode.system,
        initialRoute: '/counter',
        routes: routes,
      ),
    );
  }
}
