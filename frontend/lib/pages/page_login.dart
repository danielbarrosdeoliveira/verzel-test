import 'package:flutter/material.dart';

import 'package:frontend/components/shared/responsive.dart';
import 'package:frontend/pages/admin/list_vehicles.dart';
import 'package:frontend/pages/page_main.dart';
import 'package:frontend/services/auth_services.dart';
import 'package:frontend/utils/alert_utils.dart';
import 'package:frontend/utils/secure_storage.dart';

class LoginAdminPage extends StatefulWidget {
  const LoginAdminPage({Key? key}) : super(key: key);

  @override
  State<LoginAdminPage> createState() => _LoginAdminPageState();
}

class _LoginAdminPageState extends State<LoginAdminPage> {
  TextEditingController userTextEditController = TextEditingController();
  TextEditingController passwordTextEditController = TextEditingController();

  AuthService authService = AuthService();
  bool showPassword = false;
  bool isLoading = false;

  handleLogin() async {
    if (userTextEditController.text.isEmpty ||
        passwordTextEditController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'Atenção',
              style: TextStyle(color: Colors.amber),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
              )
            ],
            content: const Text("Usuário e Senha são obrigatórios!"),
          );
        },
      );

      return;
    }

    try {
      setState(() {
        isLoading = true;
      });

      var result = await authService.store(
        userTextEditController.text,
        passwordTextEditController.text,
      );

      if (result == null) {
        alertError("Usuário ou senha inválido!");
      } else {
        navigateToListVehicles();
      }
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void alertError(String error) {
    AlertUtils.showErrorDialog(context, error);
  }

  void navigateToListVehicles() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const AdminListVehiclePage(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    verifyToken();
  }

  void verifyToken() async {
    var token = await getToken("token");

    if (token != null) {
      Future.delayed(Duration.zero, () {
        navigateToListVehicles();
      });
    }

    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const MainPage(),
              ));
            },
            child: const Text(
              "Voltar",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ],
      ),
      body: Center(
        child: ResponsiveWidget(
          extraSmallScreen: _buildForm(300),
          smallScreen: _buildForm(400),
          mediumScreen: _buildForm(600),
          largeScreen: _buildForm(600),
          extraLargeScreen: _buildForm(600),
        ),
      ),
    );
  }

  Widget _buildForm(double width) {
    return SizedBox(
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Login de Administrador",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 64),
          Form(
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                    labelText: 'Usuário',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.greenAccent,
                        width: 2,
                      ),
                    ),
                  ),
                  controller: userTextEditController,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    icon: const Icon(
                      Icons.lock,
                      color: Colors.black,
                    ),
                    labelText: 'Senha',
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.greenAccent,
                        width: 2,
                      ),
                    ),
                    suffixIcon: GestureDetector(
                      child: Icon(
                        showPassword == false
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.black,
                      ),
                      onTap: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                    ),
                  ),
                  controller: passwordTextEditController,
                  obscureText: showPassword == false ? true : false,
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  style: const ButtonStyle(
                    padding: MaterialStatePropertyAll<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    ),
                  ),
                  onPressed: () {
                    handleLogin();
                  },
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : const Text(
                          "Entrar",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
