import 'package:flutter/material.dart';
import 'package:frontend/pages/admin/list_vehicles.dart';
import 'package:frontend/pages/page_main.dart';
import 'package:frontend/components/shared/responsive.dart';

class LoginAdminPage extends StatefulWidget {
  const LoginAdminPage({Key? key}) : super(key: key);

  @override
  State<LoginAdminPage> createState() => _LoginAdminPageState();
}

class _LoginAdminPageState extends State<LoginAdminPage> {
  TextEditingController userTextEditController = TextEditingController();
  TextEditingController passwordTextEditController = TextEditingController();

  bool showPassword = false;

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
              "Página Principal",
              style: TextStyle(color: Colors.greenAccent, fontSize: 18),
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
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const AdminListVehiclePage(),
                      ),
                    );
                  },
                  child: const Text(
                    "Entrar",
                    style: TextStyle(fontSize: 18),
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
