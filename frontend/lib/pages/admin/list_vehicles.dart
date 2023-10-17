import 'package:flutter/material.dart';
import 'package:frontend/components/vehicle/data_table.dart';

import 'package:frontend/components/vehicle/store_update_vehicle.dart';
import 'package:frontend/components/shared/responsive.dart';
import 'package:frontend/models/vehicle_model.dart';
import 'package:frontend/mocks/vehicle.dart';
import 'package:frontend/services/vehicle_services.dart';

class AdminListVehiclePage extends StatefulWidget {
  const AdminListVehiclePage({super.key});

  @override
  State<AdminListVehiclePage> createState() => _AdminListVehiclePageState();
}

class _AdminListVehiclePageState extends State<AdminListVehiclePage> {
  List<Vehicle> vehicles = getMockVehicles();

  @override
  Widget build(BuildContext context) {
    void openVehicleFormModal(BuildContext context, Vehicle? vehicle) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              vehicle == null ? "Cadastro de Veículo" : "Edição de Veículo",
            ),
            content: VehicleForm(
              vehicle: vehicle,
              onSubmit: (newVehicle) {
                Navigator.of(context).pop();
                if (vehicle == null) {
                  setState(() {
                    vehicles.add(newVehicle);
                  });
                } else {
                  final index = vehicles.indexWhere((v) => v.id == vehicle.id);
                  if (index >= 0) {
                    setState(() {
                      vehicles[index] = newVehicle;
                    });
                  }
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

    return Scaffold(
      appBar: AppBar(
        title: const Text("Administrador - Veículos Cadastrados"),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              "Sair do Admin",
              style: TextStyle(color: Colors.white),
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
              openVehicleFormModal,
              vehicles,
              context,
              handleModalDeleteVehicle,
            ),
            smallScreen: buildVehicleDataTable(
              400,
              openVehicleFormModal,
              vehicles,
              context,
              handleModalDeleteVehicle,
            ),
            mediumScreen: buildVehicleDataTable(
              double.infinity,
              openVehicleFormModal,
              vehicles,
              context,
              handleModalDeleteVehicle,
            ),
            largeScreen: buildVehicleDataTable(
              double.infinity,
              openVehicleFormModal,
              vehicles,
              context,
              handleModalDeleteVehicle,
            ),
            extraLargeScreen: buildVehicleDataTable(
              double.infinity,
              openVehicleFormModal,
              vehicles,
              context,
              handleModalDeleteVehicle,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openVehicleFormModal(context, null);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
