import 'package:flutter/material.dart';

import 'package:frontend/components/card-vehicle/card_vehicle.dart';
import 'package:frontend/components/shared/responsive.dart';
import 'package:frontend/models/vehicle_model.dart';
import 'package:frontend/pages/page_login.dart';
import 'package:frontend/services/vehicle_services.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Vehicle>? vehicles;
  bool isLoading = false;

  VehicleService vehicleService = VehicleService();

  @override
  void initState() {
    super.initState();
    handleGetVehicles();
  }

  handleGetVehicles() async {
    try {
      setState(() {
        isLoading = true;
      });

      var result = await vehicleService.index();

      if (result != null) {
        setState(() {
          vehicles = result;
        });
      }
      return;
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Vertel Veículos Usados",
        ),
        centerTitle: true,
        actions: [
          ElevatedButton(
            style: const ButtonStyle(elevation: MaterialStatePropertyAll(0)),
            child: const Text(
              "Login",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const LoginAdminPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Carregando...'),
          ],
        ),
      );
    } else if (vehicles == null) {
      return const Center(
        child: Text(
          "Nenhum Veículo Cadastrado...\nFaça login para cadastrar novos veículos!",
          style: TextStyle(fontSize: 18),
        ),
      );
    } else {
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
            itemCount: vehicles!.length,
            itemBuilder: (context, index) {
              final vehicle = vehicles![index];
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
            itemCount: vehicles!.length,
            itemBuilder: (context, index) {
              final vehicle = vehicles![index];
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
            itemCount: vehicles!.length,
            itemBuilder: (context, index) {
              final vehicle = vehicles![index];
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
            itemCount: vehicles!.length,
            itemBuilder: (context, index) {
              final vehicle = vehicles![index];
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
            itemCount: vehicles!.length,
            itemBuilder: (context, index) {
              final vehicle = vehicles![index];
              return CardVehicle(
                vehicle: vehicle,
              );
            },
          ),
        );
      }
    }
  }
}
