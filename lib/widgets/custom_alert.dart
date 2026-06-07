import 'package:flutter/material.dart';

/// Shows a beautiful, theme-matching alert box (dialog) instead of standard snackbars.
///
/// Uses the app's green theme color (#4F7D6A) for success messages, and the
/// orange theme color (#E8AC73) for error/warning messages.
void showCustomAlert(BuildContext context, String message, {bool isSuccess = false}) {
  final theme = Theme.of(context);
  
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      backgroundColor: theme.colorScheme.surface,
      title: Row(
        children: [
          Icon(
            isSuccess ? Icons.check_circle_rounded : Icons.warning_amber_rounded,
            color: isSuccess ? const Color(0xFF4F7D6A) : const Color(0xFFE8AC73),
            size: 30,
          ),
          const SizedBox(width: 12),
          Text(
            isSuccess ? 'Success' : 'Alert',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: isSuccess ? const Color(0xFF4F7D6A) : const Color(0xFFE8AC73),
            ),
          ),
        ],
      ),
      content: Text(
        message,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurface,
        ),
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: isSuccess ? const Color(0xFF4F7D6A) : const Color(0xFFE8AC73),
          ),
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'Got it',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ],
    ),
  );
}
