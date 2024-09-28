import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pannable_rating_bar/flutter_pannable_rating_bar.dart';
import 'package:get/get.dart';
import 'package:travelappuser/view/homepage/servicedetail.dart';
import 'package:travelappuser/view/homepage/widgets/travelcard.dart';
import 'package:travelappuser/viewmodel/homepage/detailservice.dart';
import 'package:travelappuser/viewmodel/homepage/homepageservice.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var search = "";
  var stars = "";
  double starsdouble = 0;
  var location = "location";
  final controller = Get.put(HomePageService());

  final controllerDetailService = Get.put(DetailService());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.only(top: 40.0, left: 24.0, right: 24),
          child: Obx(() {
            print(controller.homePageSelectedCategory.value);
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Let's start by adding the text
                const Text(
                  "Welcome To Our App",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 26.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Text(
                  "Pick your destination",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                //Now let's add some elevation to our text field
                //to do this we need to wrap it in a Material widget
                Material(
                  elevation: 10.0,
                  borderRadius: BorderRadius.circular(30.0),
                  shadowColor: const Color(0x55434343),
                  child: TextField(
                    controller: controller.searchController,
                    onChanged: (String value) {
                      setState(() {
                        search = value;
                      });
                    },
                    textAlign: TextAlign.start,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: const InputDecoration(
                      hintText: "Search for Hotel, Flight...",
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.black54,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 30.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    controller.homePageSelectedCategory.value == "hotel"
                        ? PannableRatingBar(
                            rate: starsdouble,
                            onChanged: (value) {
                              setState(() {
                                print(value.ceil());
                                starsdouble = value;
                                if (starsdouble.ceil() == 0) {
                                  stars = "";
                                } else {
                                  stars = starsdouble.ceil().toString();
                                }
                              });
                            },
                            items: List.generate(
                              5,
                              (index) => const RatingWidget(
                                selectedColor: Colors.yellowAccent,
                                unSelectedColor: Colors.grey,
                                child: Icon(
                                  Icons.star,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              ),
                            ),
                          )
                        /*PopupMenuButton(
                            initialValue: "",
                            onSelected: (value) {
                              setState(() {
                                stars = value;
                              });
                            },
                            itemBuilder: (context) {
                              return [
                                const PopupMenuItem(
                                  value: "1",
                                  child: Text("1 Stars"),
                                ),
                                const PopupMenuItem(
                                  value: "2",
                                  child: Text("2 stars"),
                                ),
                                const PopupMenuItem(
                                  value: "3",
                                  child: Text("3 stars"),
                                ),
                                const PopupMenuItem(
                                  value: "4",
                                  child: Text("4 stars"),
                                ),
                                const PopupMenuItem(
                                  value: "5",
                                  child: Text("5 stars"),
                                ),
                                const PopupMenuItem(
                                  value: "",
                                  child: Text("All"),
                                )
                              ];
                            })*/
                        : Container(),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: const Border(
                            top: BorderSide(color: Colors.grey),
                            right: BorderSide(color: Colors.grey),
                            left: BorderSide(color: Colors.grey),
                            bottom: BorderSide(color: Colors.grey),
                          )),
                      child: Row(
                        children: [
                          const Icon(Icons.location_on, color: Colors.blue),
                          const SizedBox(
                            width: 5,
                          ),
                          DropdownButton(
                              hint: Text(location == "" ? "location" : location,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              items: const [
                                DropdownMenuItem(
                                  value: "location",
                                  child: Text("location"),
                                ),
                                DropdownMenuItem(
                                  value: "name",
                                  child: Text("name"),
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  location = value!;
                                });
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                //categories
                SizedBox(
                  height: 60,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.categories.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          controller.homePageSelectedCategory.value =
                              controller.categories[index];
                        },
                        child:
                            /*   getButtonUI(controller.categories[index],  controller.homePageSelectedCategory.value ==
                                            controller.categories[index] )*/
                            Container(
                          margin: const EdgeInsets.all(8.0),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFF00B6F0)),
                            color: controller.homePageSelectedCategory.value ==
                                    controller.categories[index]
                                ? Colors.blue
                                : Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Center(
                            child: Text(
                              controller.categories[index],
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                letterSpacing: 0.27,
                                color:
                                    controller.homePageSelectedCategory.value ==
                                            controller.categories[index]
                                        ? Colors.white
                                        : Color(0xFF00B6F0),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 50 / 2,
                ),
                //all services
                SizedBox(
                    height: 250,
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("service")
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            controller.allService = snapshot.data!.docs
                                .map((e) {
                                  return {
                                    ...e.data(),
                                  };
                                })
                                .toList()
                                .obs;
                            /* controller.allService =
                                controller.sortUsersByProximity(
                                    UserPosition(
                                        latitude:
                                            controller.userPosition!.latitude,
                                        longitude:
                                            controller.userPosition!.altitude),
                                    controller.allService);*/
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.allService
                                  .where((e) => e["category"]
                                      .toLowerCase()
                                      .contains(controller
                                          .homePageSelectedCategory.value
                                          .toLowerCase()))
                                  .where((e) {
                                    return ((controller.homePageSelectedCategory
                                                    .value ==
                                                "hotel" &&
                                            e['rating']
                                                .toLowerCase()
                                                .contains(stars)) ||
                                        controller.homePageSelectedCategory
                                                .value !=
                                            "hotel");
                                  })
                                  .where((e) => e['$location']
                                      .toLowerCase()
                                      .contains(search.toLowerCase()))
                                  .toList()
                                  .length,
                              itemBuilder: (context, index) {
                                final dataService = controller.allService
                                    .where((e) => e["category"]
                                        .toLowerCase()
                                        .contains(controller
                                            .homePageSelectedCategory.value
                                            .toLowerCase()))
                                    .where((e) {
                                      return ((controller
                                                      .homePageSelectedCategory
                                                      .value ==
                                                  "hotel" &&
                                              e['rating']
                                                  .toLowerCase()
                                                  .contains(stars)) ||
                                          controller.homePageSelectedCategory
                                                  .value !=
                                              "hotel");
                                    })
                                    .where((e) => e["$location"]
                                        .toLowerCase()
                                        .contains(search.toLowerCase()))
                                    .toList()[index];
                                List<dynamic> listImages =
                                    dataService["urlImages"];
                                return GestureDetector(
                                  onTap: () {
                                    print("tap");
                                    controllerDetailService
                                        .checkFavorite(dataService["id"]);
                                    print(controllerDetailService.isFavorite);
                                    // ignore: use_build_context_synchronously
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return ServiceDetail(data: dataService);
                                    }));
                                  },
                                  child: travelCard(
                                      listImages.length > 0
                                          ? dataService['urlImages'][0]
                                          : "",
                                      dataService['name'],
                                      dataService['location'],
                                      dataService['rating'] != null
                                          ? int.parse(dataService['rating'])
                                          : 0,
                                      dataService['category']),
                                );
                              },
                            );
                          }
                          return Container();
                        })),
                const SizedBox(
                  height: 25,
                ),

                const Text(
                  "Top Rating",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                // top rating
                FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection("service")
                        .where("favorite", isEqualTo: true)
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          shrinkWrap:
                              true, // Needed to avoid infinite height error
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data!.docChanges.length,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> dataService = {};
                            dataService = snapshot.data!.docChanges[index].doc
                                .data() as Map<String, dynamic>;

                            return GestureDetector(
                                onTap: () async {
                                  await controllerDetailService
                                      .checkFavorite(dataService["id"]);
                                  // ignore: use_build_context_synchronously
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return ServiceDetail(data: dataService);
                                  }));
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Material(
                                    elevation: 5.0,
                                    borderRadius: BorderRadius.circular(10.0),
                                    shadowColor: const Color(0x55434343),
                                    child: Container(
                                        padding: EdgeInsets.all(10),
                                        child: Row(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              height: 120,
                                              width: 120,
                                              child: Image.network(
                                                  dataService['urlImages'][0]),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      dataService["category"] ==
                                                              "hotel"
                                                          ? Row(
                                                              children: [
                                                                const Icon(
                                                                    Icons
                                                                        .star_sharp,
                                                                    color: Colors
                                                                        .yellow),
                                                                const SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Text(
                                                                    "${dataService['rating']}",
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .blue))
                                                              ],
                                                            )
                                                          : Row(
                                                              children: [
                                                                const Icon(
                                                                    Icons
                                                                        .star_sharp,
                                                                    color: Colors
                                                                        .white),
                                                                const SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Text("")
                                                              ],
                                                            )
                                                    ],
                                                  ),
                                                  Text(
                                                    "${dataService["name"]}",
                                                    style: const TextStyle(
                                                        color: Colors.black87,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Row(children: [
                                                    const Icon(
                                                        Icons.location_on,
                                                        color: Colors.blue),
                                                    const SizedBox(
                                                      width: 1,
                                                    ),
                                                    Text(
                                                      '${dataService["location"]}',
                                                      style: const TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  ]),
                                                  dataService['pricepernight'] !=
                                                          null
                                                      ? Row(
                                                          children: [
                                                            Text(
                                                                "${dataService['pricepernight']} ",
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .blue)),
                                                            const Text(
                                                                "\$ /per night",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold))
                                                          ],
                                                        )
                                                      : const Text(""),
                                                ],
                                              ),
                                            )
                                          ],
                                        )),
                                  ),
                                ));

                            /* ServiceCard(
                                  images: dataService['urlImages'],
                                  name: dataService["name"],
                                  location: dataService['location'],
                                ))*/
                          },
                        );
                      }
                      return Container(
                        height: 250,
                      );
                    }),
              ],
            );
          }),
        )),
      ),
    );
  }
}
