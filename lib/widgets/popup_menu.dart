import 'package:flutter/material.dart';
import '/stores/counter_store.dart';
import '/routes.dart';
import 'package:provider/provider.dart';

import '../types.dart';

class PopupMenu extends StatelessWidget {
  const PopupMenu({super.key});

  void onSelected(PopupMenuOption option, BuildContext context) {
    switch (option) {
      case PopupMenuOption.history:
        Navigator.of(context).pushNamed(Routes.history.path).then((_) {
          ScaffoldMessenger.of(context).clearSnackBars();
        });
      case PopupMenuOption.edit:
        Provider.of<CounterStore>(context, listen: false).setInEditMode(true);
      case PopupMenuOption.reset:
        Provider.of<CounterStore>(context, listen: false).reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<PopupMenuOption>(
      onSelected: (option) {
        onSelected(option, context);
      },
      itemBuilder: (BuildContext context) {
        return PopupMenuOption.values
            .map(
              (option) => PopupMenuItem<PopupMenuOption>(
                key: Key(option.name),
                value: option,
                child: Text(option.displayText),
              ),
            )
            .toList();
      },
    );
  }
}
