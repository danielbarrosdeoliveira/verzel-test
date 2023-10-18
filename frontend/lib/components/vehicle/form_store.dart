import 'package:flutter/material.dart';
import 'package:frontend/models/vehicle_model.dart';
import 'package:frontend/services/vehicle_services.dart';

class VehicleFormStore extends StatefulWidget {
  final Function(Vehicle) onSubmit;

  const VehicleFormStore({Key? key, required this.onSubmit}) : super(key: key);

  @override
  _VehicleFormStoreState createState() => _VehicleFormStoreState();
}

class _VehicleFormStoreState extends State<VehicleFormStore> {
  late TextEditingController brandController;
  late TextEditingController modelController;
  late TextEditingController valueController;
  late TextEditingController photoUrlController;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    brandController = TextEditingController();
    modelController = TextEditingController();
    valueController = TextEditingController();
    photoUrlController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.height / 2.5,
      child: Column(
        children: [
          TextFormField(
            controller: photoUrlController,
            decoration: const InputDecoration(labelText: 'URL da Foto'),
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
            onPressed: () async {
              final photoUrl = photoUrlController.text;
              final brand = brandController.text;
              final model = modelController.text;
              final value = valueController.text;

              if (photoUrl.isNotEmpty &&
                  brand.isNotEmpty &&
                  model.isNotEmpty &&
                  value.isNotEmpty) {
                final vehicle = Vehicle(
                  brand: brand,
                  model: model,
                  photo: photoUrl,
                  value: double.parse(value),
                );

                try {
                  isLoading = true;
                  final vehicleStore = await VehicleService().store(vehicle);

                  if (vehicleStore != null) {
                    widget.onSubmit(vehicle);
                  }
                } catch (e) {
                  // ignore: avoid_print
                  print(e);
                } finally {
                  setState(() {
                    isLoading = false;
                  });
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Por favor, preencha todos os campos obrigatórios e forneça uma URL da imagem.',
                    ),
                  ),
                );
              }
            },
            child: const Text('Cadastrar', style: TextStyle(fontSize: 18)),
          ),
        ],
      ),
    );
  }
}
