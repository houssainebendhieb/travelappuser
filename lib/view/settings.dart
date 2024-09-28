import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelappuser/view/widgets/buildtextfield.dart';
import 'package:travelappuser/viewmodel/settingsservice.dart';

class Settings extends StatelessWidget {
  Settings({super.key});
  final controller = Get.find<SettingsService>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FF),
      body: Container(
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Edit Profile",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                  ),
                  IconButton(
                      onPressed: () {
                        controller.SingOut(context);
                      },
                      icon: const Icon(Icons.logout, color: Colors.blue))
                ],
              ),
              const SizedBox(
                height: 35,
              ),
              buildTextField(
                  "Full Name",
                  false,
                  Icon(Icons.person, color: Colors.blue),
                  controller.nameController),
              buildTextField(
                  "E-mail",
                  false,
                  Icon(Icons.mail, color: Colors.blue),
                  controller.emailController),
              buildTextField(
                  "Password",
                  true,
                  Icon(Icons.password, color: Colors.blue),
                  controller.passwordController),
              buildTextField(
                  "Location",
                  false,
                  Icon(Icons.location_city, color: Colors.blue),
                  controller.locationController),
              buildTextField(
                  "Phone",
                  false,
                  Icon(Icons.phone, color: Colors.blue),
                  controller.phoneController),
              const SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    onPressed: () {
                      controller.cancel();
                    },
                    child: const Text("CANCEL",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.black)),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    onPressed: () {
                      controller.updateUser(context);
                    },
                    child: const Text(
                      "SAVE",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
