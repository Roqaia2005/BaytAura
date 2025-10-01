import 'package:flutter/material.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.confirmMessage,
  });

  final String title;
  final String confirmMessage;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title, style: TextStyles.font20BlueBold),
      content: Text(style: TextStyles.font17BlueBold, confirmMessage),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text("Cancel", style: TextStyles.font16BlueBold),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text(
            "Delete",
            style: TextStyle(
              color: Colors.red,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}