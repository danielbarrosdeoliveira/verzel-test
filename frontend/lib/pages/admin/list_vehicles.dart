import 'package:flutter/material.dart';
import 'package:frontend/components/vehicle/data_table.dart';
import 'package:frontend/components/vehicle/form_store.dart';

import 'package:frontend/components/shared/responsive.dart';
import 'package:frontend/components/vehicle/form_update.dart';
import 'package:frontend/models/vehicle_model.dart';
import 'package:frontend/pages/page_login.dart';
import 'package:frontend/services/auth_services.dart';
import 'package:frontend/services/vehicle_services.dart';

class AdminListVehiclePage extends StatefulWidget {
  const AdminListVehiclePage({super.key});

  @override
  State<AdminListVehiclePage> createState() => _AdminListVehiclePageState();
}

class _AdminListVehiclePageState extends State<AdminListVehiclePage> {
  List<Vehicle>? vehicles = [];

  @override
  void initState() {
    super.initState();

    handleGetVehicle();
  }

  void handleGetVehicle() async {
    VehicleService vehicleService = VehicleService();

    var result = await vehicleService.index();

    if (result != null) {
      setState(() {
        vehicles = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    void openVehicleFormStore(BuildContext context) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Cadastro de Veículo"),
            content: VehicleFormStore(
              onSubmit: (newVehicle) {
                Navigator.pop(context);
                if (newVehicle.brand.isNotEmpty) {
                  setState(() {
                    vehicles!.add(newVehicle);
                  });
                }
              },
            ),
          );
        },
      );
    }

    void openVehicleFormUpdate(BuildContext context, Vehicle? vehicle) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Atualização de Veículo"),
            content: VehicleFormUpdate(
              vehicle: vehicle!,
              onUpdate: (dataToUpdateVehicle) async {
                final responseVehicleUpdated =
                    await VehicleService().update(dataToUpdateVehicle);

                if (responseVehicleUpdated != null) {
                  handleGetVehicle();
                }
              },
            ),
          );
        },
      );
    }

    deleteVehicle(int? vehicleId) async {
      VehicleService vehicleServices = VehicleService();

      if (vehicleId != null) {
        try {
          await vehicleServices.destroy(vehicleId);
        } catch (error) {
          print(error);
        }
      }
    }

    handleModalDeleteVehicle(BuildContext context, Vehicle? vehicle) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Deseja realmente apagar o veículo ${vehicle?.brand} ${vehicle?.model}',
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancelar"),
                ),
                ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.red),
                  ),
                  onPressed: () {
                    deleteVehicle(vehicle?.id);
                    Navigator.of(context).pop();
                    setState(() {
                      vehicles!.remove(vehicle);
                    });
                  },
                  child: const Text(
                    "Confirmar",
                    style: TextStyle(fontSize: 18),
                  ),
                )
              ],
            ),
          );
        },
      );
    }

    void handleLogout(BuildContext context) async {
      AuthService authService = AuthService();

      await authService.destroy();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginAdminPage(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Administrador - Veículos Cadastrados"),
        actions: [
          TextButton(
            onPressed: () {
              handleLogout(context);
            },
            child: const Text(
              "Deslogar",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 16),
          ResponsiveWidget(
            extraSmallScreen: buildVehicleDataTable(
              300,
              openVehicleFormUpdate,
              vehicles!,
              context,
              handleModalDeleteVehicle,
            ),
            smallScreen: buildVehicleDataTable(
              400,
              openVehicleFormUpdate,
              vehicles!,
              context,
              handleModalDeleteVehicle,
            ),
            mediumScreen: buildVehicleDataTable(
              double.infinity,
              openVehicleFormUpdate,
              vehicles!,
              context,
              handleModalDeleteVehicle,
            ),
            largeScreen: buildVehicleDataTable(
              double.infinity,
              openVehicleFormUpdate,
              vehicles!,
              context,
              handleModalDeleteVehicle,
            ),
            extraLargeScreen: buildVehicleDataTable(
              double.infinity,
              openVehicleFormUpdate,
              vehicles!,
              context,
              handleModalDeleteVehicle,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openVehicleFormStore(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
