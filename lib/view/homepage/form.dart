import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelappuser/viewmodel/form/formservice.dart';

class FormReservation extends StatelessWidget {
  final bool isEdit;
  FormReservation({super.key, required this.isEdit});
  final controller = Get.put(FormService());

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
            controller: controller.nomberPersonneController,
            keyboardType: TextInputType.number,
          ),
          const Text("Comment",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w500)),
          TextFormField(controller: controller.commentController),
          const SizedBox(
            height: 100,
          ),
          isEdit == false
              ? ElevatedButton(
                  onPressed: () {
                    controller.addReservation(context);
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
