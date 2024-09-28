import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelappuser/view/widgets/custombluebutton.dart';
import 'package:travelappuser/view/widgets/customtextfield.dart';
import 'package:travelappuser/viewmodel/loginservice.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});

  final controller = Get.put(LoginService());
  @override
  Widget build(BuildContext context) {
    final globalKey2 = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FF),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 30),
          child: Form(
            key: globalKey2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                const Row(
                  children: [
                    Text('Welcome to our ',
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.w600)),
                    SizedBox(
                      width: 2,
                    ),
                    Text('TravelApp',
                        style: TextStyle(
                            fontSize: 26,
                            color: Colors.blue,
                            fontWeight: FontWeight.w600))
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text('Sign In to Continue. ',
                    style:
                        TextStyle(fontSize: 26, fontWeight: FontWeight.w600)),
                const SizedBox(
                  height: 30,
                ),
                const Text('Make your travel moments beautiful with ',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 17,
                        fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 2,
                ),
                const Text('the comforable and affordable services',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 17,
                        fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 25,
                ),
                customTextField(
                  controller: controller.emailController,
                  hintText: 'Email',
                  icon: const Icon(
                    Icons.mail_outline,
                    color: Colors.blue,
                  ),
                  preicon: null,
                ),
                const SizedBox(
                  height: 25,
                ),
                customTextField(
                  controller: controller.nameController,
                  hintText: 'Name',
                  icon: const Icon(
                    Icons.person,
                    color: Colors.blue,
                  ),
                  preicon: null,
                ),
                const SizedBox(
                  height: 25,
                ),
                customTextField(
                  controller: controller.locationController,
                  hintText: 'Location',
                  icon: const Icon(
                    Icons.location_on,
                    color: Colors.blue,
                  ),
                  preicon: null,
                ),
                const SizedBox(
                  height: 25,
                ),
                customTextField(
                  
                  controller: controller.phoneController,
                  hintText: 'Phone',
                  icon: const Icon(
                    Icons.phone,
                    color: Colors.blue,
                  ),
                  preicon: null,
                ),
                const SizedBox(
                  height: 25,
                ),
                customTextField(
                  controller: controller.passwordController,
                  hintText: 'Password',
                  icon: const Icon(
                    Icons.lock_outline_rounded,
                    color: Colors.blue,
                  ),
                  preicon: const Icon(Icons.visibility),
                ),
                const SizedBox(
                  height: 30,
                ),
                const SizedBox(
                  height: 70,
                ),
                CustomBlueButton(
                    text: 'Sign Up',
                    color: Colors.blue.shade700,
                    ontap: () async {
                      controller.SingUp(context);
                    }),
                const SizedBox(
                  height: 35,
                ),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
