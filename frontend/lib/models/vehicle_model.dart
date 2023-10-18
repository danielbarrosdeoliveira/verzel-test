class Vehicle {
  final int? id;
  final String brand;
  final String model;
  final String photo;
  final double value;

  Vehicle({
    this.id,
    required this.brand,
    required this.model,
    required this.value,
    required this.photo,
  });

  factory Vehicle.fromJson(Map<String, dynamic> data) {
    return Vehicle(
      id: data['id'],
      brand: data['brand'],
      model: data['model'],
      photo: data['photo'],
      value: data['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'brand': brand,
      'model': model,
      'photo': photo,
      'value': value,
    };
  }
}
