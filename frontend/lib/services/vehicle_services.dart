import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:frontend/models/vehicle_model.dart';

class VehicleService {
  String apiUrl = 'http://localhost:3333';
  String endpoint = 'vehicles';

  Future<List<Vehicle>> index() async {
    final uri = Uri.parse('$apiUrl/$endpoint');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<Vehicle> vehicles =
          jsonData.map((data) => Vehicle.fromJson(data)).toList();
      return vehicles;
    } else {
      throw Exception('Falha ao buscar veículos da API');
    }
  }

  Future<void> store(Vehicle vehicle, String photoPath) async {
    final uri = Uri.parse('$apiUrl/$endpoint');
    final request = http.MultipartRequest('POST', uri);

    request.fields['brand'] = vehicle.brand;
    request.fields['model'] = vehicle.model;
    request.fields['price'] = vehicle.price.toString();

    final file = await http.MultipartFile.fromPath('photo', photoPath);
    request.files.add(file);

    final response = await request.send();

    if (response.statusCode == 200) {
    } else {}
  }

  Future<Vehicle> show(int vehicleId) async {
    final uri = Uri.parse('$apiUrl/$endpoint/$vehicleId');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final dynamic jsonData = json.decode(response.body);
      final Vehicle vehicle = Vehicle.fromJson(jsonData);
      return vehicle;
    } else {
      throw Exception('Falha ao buscar detalhes do veículo da API');
    }
  }

  Future<void> update(Vehicle vehicle, String photoPath) async {
    if (vehicle.id == null) {
      throw Exception('O veículo deve ter um ID para ser atualizado.');
    }

    final uri = Uri.parse('$apiUrl/$endpoint/${vehicle.id}');
    final request = http.MultipartRequest('PUT', uri);

    request.fields['brand'] = vehicle.brand;
    request.fields['model'] = vehicle.model;
    request.fields['price'] = vehicle.price.toString();

    final file = await http.MultipartFile.fromPath('photo', photoPath);
    request.files.add(file);

    final response = await request.send();

    if (response.statusCode == 200) {
    } else {}
  }

  Future<void> destroy(int vehicleId) async {
    final uri = Uri.parse('$apiUrl/$endpoint/$vehicleId');
    final response = await http.delete(uri);

    if (response.statusCode == 200) {
    } else {}
  }
}
