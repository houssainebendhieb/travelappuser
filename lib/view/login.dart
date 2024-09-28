import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelappuser/view/signup.dart';
import 'package:travelappuser/view/widgets/custombluebutton.dart';
import 'package:travelappuser/view/widgets/customtextfield.dart';
import 'package:travelappuser/viewmodel/loginservice.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
                Row(
                  children: [
                    const Text(
                      "Dont't have an account?",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return SignUp();
                        }));
                      },
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                /* Material(
                  elevation: 10.0,
                  
                  borderRadius: BorderRadius.circular(10),
                  shadowColor: const Color(0x55434343),
                  child: TextFormField(
                    
                    controller: controller.emailController,
                    textAlign: TextAlign.start,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      hintText: "Search for Hotel, Flight...",
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.black54,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),*/
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
                const Center(
                  child: Text('Forgot Password?',
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(
                  height: 70,
                ),
                CustomBlueButton(
                    text: 'Sign In',
                    color: Colors.blue.shade700,
                    ontap: () async {
                      controller.SignIn(context);
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
