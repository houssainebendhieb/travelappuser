import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelappuser/viewmodel/form/formrestaurentservice.dart';

class FormRestaurant extends StatelessWidget {
  final bool isEdit;
  FormRestaurant({super.key, required this.isEdit});
  final controller = Get.put(FormRestaurentService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const Text('Nombre de personnes',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w500)),
          TextFormField(
            controller: controller.controllerNomberTable,
            keyboardType: TextInputType.number,
          ),
          const Text("Time",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w500)),
          TextFormField(controller: controller.controllerTime),
          const SizedBox(
            height: 100,
          ),
          isEdit == false
              ? ElevatedButton(
                  onPressed: () {
                    controller.addResevation(context);
                  },
                  child: const Text('Resever'))
              : ElevatedButton(
                  onPressed: () {
                    controller.updateReservation(context);
                  },
                  child: const Text('Update'))
        ],
      ),
    );
  }
}
