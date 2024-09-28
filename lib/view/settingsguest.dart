import 'package:flutter/material.dart';
import 'package:travelappuser/view/login.dart';

class SettingsGuest extends StatelessWidget {
  const SettingsGuest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: ElevatedButton(
                  child: const Text("Sign In"),
                  onPressed: () {
                    while (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return const Login();
                      },
                    ));
                  }))
        ],
      ),
    );
  }
}
