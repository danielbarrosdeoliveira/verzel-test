import 'package:flutter/material.dart';

class AlertUtils {
  static void showSuccessDialog(BuildContext context) {
    AlertDialogUtils.showAlert(
      context,
      "Sucesso",
      "Usuário cadastrado com sucesso, utilize e-mail e senha fornecidos no cadastro para realizar o login",
    );
  }

  static void showErrorDialog(BuildContext context, String message) {
    AlertDialogUtils.showAlert(
      context,
      "Erro",
      message,
    );
  }
}

class AlertDialogUtils {
  static void showAlert(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
