import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelappuser/view/homepage/servicedetail.dart';
import 'package:travelappuser/view/widgets/favoritecard.dart';
import 'package:travelappuser/viewmodel/authentification.dart';
import 'package:travelappuser/viewmodel/homepage/detailservice.dart';

class Favorites extends StatelessWidget {
  final controller = Get.put(Authentification());
  final controllerDetailService = Get.put(DetailService());

  Favorites({super.key});
  @override
  Widget build(context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text("Favorites List",
              style: TextStyle(color: Colors.black, fontSize: 25)),
          const SizedBox(
            height: 25,
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("favorites")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.requireData.docs;
                  List<Map<String, dynamic>> list = [];
                  for (var a in data) {
                    if (a.data()["email"] == controller.user!.email) {
                      list.add(a.data());
                    }
                  }
                  return ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return FutureBuilder(
                          future: FirebaseFirestore.instance
                              .collection("service")
                              .where("id", isEqualTo: list[index]['idservice'])
                              .get(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final aux = snapshot.data!.docs.first.data();
                              return GestureDetector(
                                child: FavoriteCard(data: aux),
                                onTap: () async {
                                  await controllerDetailService
                                      .checkFavorite(aux["id"]);
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return ServiceDetail(
                                      data: aux,
                                    );
                                  }));
                                },
                              );
                            }
                            return const Center(
                                child: CircularProgressIndicator());
                          },
                        );
                      });
                }
                return const CircularProgressIndicator();
              },
            ),
          ),
        ]),
      ),
    );
  }
}
