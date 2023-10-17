import 'package:flutter/material.dart';

import 'package:frontend/components/card-vehicle/card_vehicle.dart';
import 'package:frontend/components/shared/responsive.dart';
import 'package:frontend/mocks/vehicle.dart';
import 'package:frontend/models/vehicle_model.dart';
import 'package:frontend/pages/admin/login.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Vehicle> vehicles = getMockVehicles();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vertel Veículos Usados - Listagem de Veículos"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const LoginAdminPage(),
                ),
              );
            },
            child: const Text(
              "Adicionar Veículo",
              style: TextStyle(color: Colors.greenAccent, fontSize: 18),
            ),
          ),
        ],
      ),
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (ResponsiveWidget.isExtraLargeScreen(context)) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1,
          ),
          itemCount: vehicles.length,
          itemBuilder: (context, index) {
            final vehicle = vehicles[index];
            return CardVehicle(
              vehicle: vehicle,
            );
          },
        ),
      );
    } else if (ResponsiveWidget.isLargeScreen(context)) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1,
          ),
          itemCount: vehicles.length,
          itemBuilder: (context, index) {
            final vehicle = vehicles[index];
            return CardVehicle(
              vehicle: vehicle,
            );
          },
        ),
      );
    } else if (ResponsiveWidget.isMediumScreen(context)) {
      return Padding(
        padding: const EdgeInsets.all(8),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 1,
          ),
          itemCount: vehicles.length,
          itemBuilder: (context, index) {
            final vehicle = vehicles[index];
            return CardVehicle(
              vehicle: vehicle,
            );
          },
        ),
      );
    } else if (ResponsiveWidget.isSmallScreen(context)) {
      return Padding(
        padding: const EdgeInsets.all(8),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 1,
          ),
          itemCount: vehicles.length,
          itemBuilder: (context, index) {
            final vehicle = vehicles[index];
            return CardVehicle(
              vehicle: vehicle,
            );
          },
        ),
      );
    } else {
      // Extra Small Screen
      return Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1,
          ),
          itemCount: vehicles.length,
          itemBuilder: (context, index) {
            final vehicle = vehicles[index];
            return CardVehicle(
              vehicle: vehicle,
            );
          },
        ),
      );
    }
  }
}
