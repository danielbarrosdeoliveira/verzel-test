import 'package:flutter/material.dart';
import 'package:frontend/models/vehicle_model.dart';
import 'package:image_picker/image_picker.dart';

class VehicleForm extends StatefulWidget {
  final Vehicle? vehicle;
  final Function(Vehicle) onSubmit;

  const VehicleForm({Key? key, this.vehicle, required this.onSubmit})
      : super(key: key);

  @override
  _VehicleFormState createState() => _VehicleFormState();
}

class _VehicleFormState extends State<VehicleForm> {
  late TextEditingController photoController;
  late TextEditingController brandController;
  late TextEditingController modelController;
  late TextEditingController priceController;

  @override
  void initState() {
    super.initState();
    if (widget.vehicle != null) {
      final vehicle = widget.vehicle!;
      photoController = TextEditingController(text: vehicle.photo);
      brandController = TextEditingController(text: vehicle.brand);
      modelController = TextEditingController(text: vehicle.model);
      priceController = TextEditingController(text: vehicle.price.toString());
    } else {
      photoController = TextEditingController();
      brandController = TextEditingController();
      modelController = TextEditingController();
      priceController = TextEditingController();
    }
  }

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        photoController.text = pickedFile.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.height / 3,
      child: Column(
        children: [
          ElevatedButton(
            onPressed: _pickImage,
            style: const ButtonStyle(
              padding: MaterialStatePropertyAll<EdgeInsets>(
                EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
            ),
            child: const Text(
              'Escolher Foto',
              style: TextStyle(fontSize: 18),
            ),
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
            controller: priceController,
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
              final price = double.tryParse(priceController.text) ?? 0.0;

              if (photo.isNotEmpty && brand.isNotEmpty && model.isNotEmpty) {
                final vehicle = Vehicle(
                  id: 4,
                  brand: brand,
                  model: model,
                  photo: photo,
                  price: price,
                );
                widget.onSubmit(vehicle);
                Navigator.of(context).pop();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Por favor, preencha todos os campos obrigatórios.',
                    ),
                  ),
                );
              }
            },
            child: const Text(
              'Cadastrar',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
