import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void showEnterNumberDialog(
  BuildContext context, {
  required void Function(int) onValidValueSubmitted,
  required String hintText,
  String? initialValue,
}) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      content: _EnterCustomValueForm(
        onValidValueSubmitted: onValidValueSubmitted,
        hintText: hintText,
        initialValue: initialValue,
      ),
    ),
  );
}

class _EnterCustomValueForm extends StatefulWidget {
  final void Function(int) onValidValueSubmitted;
  final String hintText;
  final String? initialValue;

  const _EnterCustomValueForm({
    required this.onValidValueSubmitted,
    required this.hintText,
    this.initialValue,
  });

  @override
  State<_EnterCustomValueForm> createState() => __EnterCustomValueFormState();
}

class __EnterCustomValueFormState extends State<_EnterCustomValueForm> {
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.text = widget.initialValue ?? '';
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onSubmit() {
    final num = int.tryParse(controller.value.text);
    if (num != null) {
      widget.onValidValueSubmitted(num);
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  @override
  Widget build(BuildContext context) => Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controller,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24),
              keyboardType: const TextInputType.numberWithOptions(),
              decoration: InputDecoration(hintText: widget.hintText),
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(r'^[1-9][0-9]*$'),
                ),
              ],
              onSubmitted: (_) {
                onSubmit();
              },
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FilledButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  child: const Text('Cancel'),
                ),
                FilledButton(
                  onPressed: onSubmit,
                  child: const Text('Submit'),
                ),
              ],
            ),
          ],
        ),
      );
}
