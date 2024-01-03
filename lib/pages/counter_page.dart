import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../dialogs/enter_number_dialog.dart';
import '../widgets/popup_menu.dart';
import '/stores/counter_store.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Counter',
          ),
          actions: [
            Consumer<CounterStore>(
              builder: (_, store, child) => store.inEditMode
                  ? IconButton(
                      iconSize: 32,
                      onPressed: () {
                        store.setInEditMode(false);
                      },
                      icon: const Icon(
                        Icons.done,
                      ),
                    )
                  : const PopupMenu(),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Consumer<CounterStore>(
                  builder: (_, store, __) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '  ${store.totalCount} / ',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        ),
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          if (store.inEditMode) {
                            showEnterNumberDialog(
                              context,
                              onValidValueSubmitted: store.setGoal,
                              hintText: 'Goal',
                              initialValue: store.goal.toString(),
                            );
                          }
                        },
                        child: Stack(
                          alignment: AlignmentDirectional.topEnd,
                          fit: StackFit.passthrough,
                          children: [
                            Text(
                              '${store.goal}  ',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 28,
                              ),
                            ),
                            if (store.inEditMode)
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade500,
                                  borderRadius: BorderRadius.circular(22),
                                ),
                                child: const Icon(
                                  Icons.edit,
                                  size: 22,
                                  color: Colors.white,
                                ),
                              )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Consumer<CounterStore>(
                  builder: (_, store, __) => Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      ...store.increments
                          .map(
                            (increment) => _IncrementButton(
                              key: Key('Increment $increment'),
                              value: increment,
                              onTap: (value) {
                                store.logJaps(value);
                              },
                            ),
                          )
                          .toList(),
                      if (store.inEditMode)
                        IconButton(
                          onPressed: () {
                            showEnterNumberDialog(
                              context,
                              onValidValueSubmitted: store.addIncrement,
                              hintText: 'Number of japs',
                            );
                          },
                          icon: Icon(
                            Icons.add_circle,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Consumer<CounterStore>(
                  builder: (_, store, __) => FilledButton(
                    onPressed: store.inEditMode
                        ? null
                        : () {
                            showEnterNumberDialog(
                              context,
                              onValidValueSubmitted: store.logJaps,
                              hintText: 'Custom count',
                            );
                          },
                    child: const Text('Custom Value'),
                  ),
                )
              ],
            ),
          ),
        ),
      );
}

class _IncrementButton extends StatelessWidget {
  final int value;
  final void Function(int) onTap;

  const _IncrementButton({super.key, required this.value, required this.onTap});

  @override
  Widget build(BuildContext context) => Consumer<CounterStore>(
        builder: (_, store, __) => Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            FilledButton(
              onPressed: () {
                if (store.inEditMode) {
                  store.removeIncrement(value);
                } else {
                  onTap.call(value);
                }
              },
              child: Text('+$value'),
            ),
            if (store.inEditMode)
              Container(
                decoration: BoxDecoration(
                  color: Colors.red.shade600,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Icon(
                  Icons.cancel,
                  color: Colors.white,
                ),
              )
          ],
        ),
      );
}
