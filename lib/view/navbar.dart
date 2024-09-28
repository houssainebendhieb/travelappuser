import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelappuser/view/event.dart';
import 'package:travelappuser/view/favorites.dart';
import 'package:travelappuser/view/homepage/homepage.dart';
import 'package:travelappuser/view/reservation.dart';
import 'package:travelappuser/view/settings.dart';
import 'package:travelappuser/view/settingsguest.dart';
import 'package:travelappuser/viewmodel/authentification.dart';
import 'package:travelappuser/viewmodel/navbarservice.dart';

class NavigationBarApp extends StatelessWidget {
  NavigationBarApp({super.key});

  final controllerAuthentification = Get.find<Authentification>();
  final controllerNavBarService = Get.put(NavBarService());

  @override
  Widget build(BuildContext context) {
    var list = controllerAuthentification.isConnected!.isTrue
        ? [
            /// Home page
            HomePage(),

            /// Notifications page
            Favorites(),

            /// Messages page
            Reservation(),
            EventScreen(),

            Settings(),
          ]
        : [HomePage(), SettingsGuest()];
    return Obx(() => Scaffold(
          bottomNavigationBar: BottomNavigationBar(
              onTap: (int index) {
                controllerNavBarService.changeIndex(index);
              },
              unselectedItemColor: const Color(0xFFB7B7B7),
              currentIndex: controllerNavBarService.selectedIndex.value,
              selectedItemColor: Colors.blue,
              items: controllerAuthentification.isConnected!.isTrue
                  ? [
                      const BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        label: "Home",
                      ),
                      const BottomNavigationBarItem(
                        icon: Icon(Icons.favorite),
                        label: "Favorite",
                      ),
                      const BottomNavigationBarItem(
                        icon: Icon(Icons.list),
                        label: "Reservations",
                      ),
                      const BottomNavigationBarItem(
                        icon: Icon(Icons.stars),
                        label: "Events",
                      ),
                      const BottomNavigationBarItem(
                        icon: Icon(Icons.settings),
                        label: "Settings",
                      ),
                    ]
                  : [
                      const BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        label: "Home",
                      ),
                      const BottomNavigationBarItem(
                        icon: Icon(Icons.settings),
                        label: "Setttings",
                      ),
                    ]),
          body: list[controllerNavBarService.selectedIndex.value],
        ));
  }
}
