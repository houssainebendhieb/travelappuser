import 'package:flutter/material.dart';

class ReservationDetail extends StatelessWidget {
  final Map<String, dynamic> data;
  @override
  const ReservationDetail({super.key, required this.data});

  Widget build(context) {
    return Scaffold(
      body: Column(children: [
        Text("status  ${data['status']}"),
        data['type'] == "hotel"
            ? Column(
                children: [
                  Text('nomber enfants : ${data['nomberenfant']}'),
                  Text('nomber adults : ${data['nomberenfant']}'),
                  Text('pension : ${data['pension']}'),
                  Text('datearrive : ${data['datearrive']}'),
                  Text('datasortie : ${data['datesortie']}'),
                ],
              )
            : Column(
                children: [Text('table nomber : ${data['tablenomber']}')],
              )
      ]),
    );
  }
}
