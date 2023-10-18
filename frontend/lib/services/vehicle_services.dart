import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:frontend/utils/secure_storage.dart';
import 'package:frontend/models/vehicle_model.dart';

class VehicleService {
  String apiUrl = 'http://127.0.0.1:3333';
  String endpoint = 'vehicles';

  Future<List<Vehicle>?> index() async {
    final uri = Uri.parse('$apiUrl/$endpoint');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = await json.decode(response.body);

      List<Vehicle> vehicles =
          jsonData.map((data) => Vehicle.fromJson(data)).toList();
      return vehicles;
    } else if (response.statusCode == 404) {
      return null;
    } else {
      print("Erro não tratado");
    }
    return null;
  }

  Future<Vehicle?> store(Vehicle vehicle) async {
    var token = await getToken("token");

    final uri = Uri.parse('$apiUrl/$endpoint');

    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    final vehicleData = {
      'brand': vehicle.brand,
      'model': vehicle.model,
      'photo': vehicle.photo,
      'value': vehicle.value,
    };

    final jsonBody = jsonEncode(vehicleData);

    final response = await http.post(uri, headers: headers, body: jsonBody);

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      final vehicle = Vehicle(
        brand: responseData['brand'],
        model: responseData['model'],
        photo: responseData['photo'],
        value: double.parse(responseData['value'].toString()),
      );

      return vehicle;
    }

    return null;
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

  Future<dynamic> update(Vehicle vehicle) async {
    var token = await getToken("token");

    final uri = Uri.parse('$apiUrl/$endpoint/${vehicle.id}');

    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    final vehicleData = {
      'brand': vehicle.brand,
      'model': vehicle.model,
      'photo': vehicle.photo,
      'value': vehicle.value,
    };

    final jsonBody = jsonEncode(vehicleData);

    final response = await http.put(uri, headers: headers, body: jsonBody);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  Future<void>? destroy(int vehicleId) async {
    var token = await getToken("token");

    final uri = Uri.parse('$apiUrl/$endpoint/$vehicleId');
    final response = await http.delete(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
    } else {
      return;
    }
  }
}
