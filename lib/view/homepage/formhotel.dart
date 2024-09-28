import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:travelappuser/viewmodel/form/fomrhotelservice.dart';

class FormHotel extends StatelessWidget {
  final bool isEdit;
  const FormHotel({required this.isEdit, super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FormHotelService());

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(),
        body: Form(
          child: Obx(
            () => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Nombre de adults',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: Colors.blue)),
                      Text(
                        'Nombre de enfants',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Colors.blue),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                              fillColor: Colors.grey,
                              focusColor: Colors.blue,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          controller: controller.nomberAdultController,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          controller: controller.nomberEnfantsController,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text('Nombre de nuits',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Colors.blue)),
                  Padding(
                    padding: const EdgeInsets.only(right: 200),
                    child: TextFormField(
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                      controller: controller.nomberNuitsController,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      focusColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      splashColor: Colors.grey.withOpacity(0.2),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(4.0),
                      ),
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        // setState(() {
                        //   isDatePopupOpen = true;
                        // });
                        controller.showDemoDialog(context: context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8, right: 8, top: 4, bottom: 4),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              'Choose date',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 25,
                                  color: Colors.blue),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              '${DateFormat("dd, MMM").format(controller.startDate)} - ${DateFormat("dd, MMM").format(controller.endDate)}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ListTile(
                        title: const Text('Demi Pension'),
                        leading: Radio<String>(
                          value: 'Demi Pension',
                          groupValue: controller.selectedOption.value,
                          onChanged: controller.handleRadioValueChange,
                        ),
                      ),
                      ListTile(
                        title: const Text('Pension Complete'),
                        leading: Radio<String>(
                          value: 'Pension Complete',
                          groupValue: controller.selectedOption.value,
                          onChanged: controller.handleRadioValueChange,
                        ),
                      ),
                      ListTile(
                        title: const Text('All Inclusive'),
                        leading: Radio<String>(
                          value: 'All Inclusive',
                          groupValue: controller.selectedOption.value,
                          onChanged: controller.handleRadioValueChange,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                  const SizedBox(height: 100),
                  isEdit == false
                      ? Center(
                          child: ElevatedButton(
                              onPressed: () {
                                controller.addReservationHotel(context);
                              },
                              child: const Text('reserver',
                                  style: TextStyle(
                                    color: Colors.blue,
                                  ))),
                        )
                      : Center(
                          child: ElevatedButton(
                              onPressed: () {
                                controller.updateReservation(context);
                              },
                              child: const Text('UPDATE',
                                  style: TextStyle(
                                    color: Colors.blue,
                                  ))),
                        )
                ],
              ),
            ),
          ),
        ));
  }
}
