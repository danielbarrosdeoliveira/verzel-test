import 'package:flutter/material.dart';
import 'package:frontend/models/vehicle_model.dart';
import 'package:frontend/utils/vehicle.dart';

Widget buildVehicleDataTable(
  double width,
  Function(BuildContext, Vehicle) openVehicleFormUpdateModal,
  List<Vehicle> vehicles,
  BuildContext context,
  Function(BuildContext, Vehicle?) openDeleteVehicleModel,
) {
  return SizedBox(
    width: width,
    height: MediaQuery.of(context).size.height / 1.2,
    child: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('Foto')),
          DataColumn(label: Text('Marca')),
          DataColumn(label: Text('Modelo')),
          DataColumn(label: Text('Preço')),
          DataColumn(label: Text('Ações')),
        ],
        rows: vehicles.map((vehicle) {
          return DataRow(cells: [
            DataCell(
              SizedBox(
                width: 80,
                child: Image.network(vehicle.photo),
              ),
            ),
            DataCell(Text(vehicle.brand)),
            DataCell(Text(vehicle.model)),
            DataCell(
              Text(
                priceFormat.format(vehicle.value),
              ),
            ),
            DataCell(Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.amber,
                  ),
                  onPressed: () {
                    openVehicleFormUpdateModal(context, vehicle);
                  },
                ),
                IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    openDeleteVehicleModel(context, vehicle);
                  },
                ),
              ],
            )),
          ]);
        }).toList(),
      ),
    ),
  );
}
