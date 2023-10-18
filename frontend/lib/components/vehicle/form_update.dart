import 'package:flutter/material.dart';
import 'package:frontend/models/vehicle_model.dart';

class VehicleFormUpdate extends StatefulWidget {
  final Vehicle vehicle;
  final Function(Vehicle) onUpdate;

  const VehicleFormUpdate(
      {Key? key, required this.vehicle, required this.onUpdate})
      : super(key: key);

  @override
  _VehicleFormUpdateState createState() => _VehicleFormUpdateState();
}

class _VehicleFormUpdateState extends State<VehicleFormUpdate> {
  late TextEditingController photoController;
  late TextEditingController brandController;
  late TextEditingController modelController;
  late TextEditingController valueController;

  @override
  void initState() {
    super.initState();

    final Vehicle vehicle = widget.vehicle;

    photoController = TextEditingController(text: vehicle.photo);
    brandController = TextEditingController(text: vehicle.brand);
    modelController = TextEditingController(text: vehicle.model);
    valueController = TextEditingController(text: vehicle.value.toString());
  }

  @override
  void dispose() {
    photoController.dispose();
    brandController.dispose();
    modelController.dispose();
    valueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.height / 2.5,
      child: Column(
        children: [
          TextFormField(
            controller: photoController,
            decoration: const InputDecoration(labelText: 'Foto'),
          ),
          TextFormField(
            controller: brandController,
            decoration: const InputDecoration(labelText: 'Marca'),
          ),
          TextFormField(
            controller: modelController,
            decoration: const InputDecoration(labelText: 'Modelo'),
          ),
          TextFormField(
            controller: valueController,
            decoration: const InputDecoration(labelText: 'Preço'),
          ),
          const SizedBox(
            height: 32,
          ),
          ElevatedButton(
            style: const ButtonStyle(
              padding: MaterialStatePropertyAll<EdgeInsets>(
                EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
            ),
            onPressed: () {
              final photo = photoController.text;
              final brand = brandController.text;
              final model = modelController.text;
              final value = valueController.text;

              final dataToUpdateVehicle = Vehicle(
                id: widget.vehicle.id,
                brand: brand,
                model: model,
                photo: photo,
                value: double.parse(value),
              );

              widget.onUpdate(dataToUpdateVehicle);

              Navigator.of(context).pop();
            },
            child: const Text(
              'Atualizar',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
