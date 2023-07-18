import 'package:flutter/material.dart';
import 'package:flutter_docbook/utilities/dialogs/generic_dialog.dart';

Future<void> showPasswordResetSentDialog(BuildContext context) {
  return showGenericDialog<void>(
      context: context,
      title: 'Password Reset',
      content:
          'We have now sent you a password reset link. please check your email for more information.',
      optionsBuilder: () => {
            'OK': null,
          });
}
