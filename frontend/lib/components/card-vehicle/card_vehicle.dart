import 'package:flutter/material.dart';

import 'package:frontend/models/vehicle_model.dart';
import 'package:frontend/utils/vehicle.dart';

class CardVehicle extends StatefulWidget {
  final Vehicle vehicle;

  const CardVehicle({super.key, required this.vehicle});

  @override
  State<CardVehicle> createState() => _CardVehicleState();
}

class _CardVehicleState extends State<CardVehicle> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 4,
      child: Card(
        elevation: 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.network(
              widget.vehicle.photo,
              fit: BoxFit.contain,
              width: getCardWidth(context),
              height: getCardHeight(context),
            ),
            SizedBox(height: getSpaceBetweenCards(context)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.vehicle.brand,
                  style: TextStyle(fontSize: getTitleFontSize(context)),
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  widget.vehicle.model,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: getTitleFontSize(context),
                  ),
                ),
              ],
            ),
            SizedBox(height: getSpaceBetweenCards(context)),
            Container(
              width: getCardWidth(context),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.black12, width: 1),
                ),
              ),
            ),
            SizedBox(height: getSpaceBetweenCards(context)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "R\$",
                  style: TextStyle(fontSize: 16, color: Colors.black45),
                ),
                Text(
                  priceFormat.format(widget.vehicle.value),
                  style: TextStyle(fontSize: getPriceFontSize(context)),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
