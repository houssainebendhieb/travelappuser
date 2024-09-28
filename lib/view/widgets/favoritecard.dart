import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelappuser/viewmodel/homepage/detailservice.dart';

class FavoriteCard extends StatelessWidget {
  final Map<String, dynamic> data;
  FavoriteCard({
    required this.data,
    Key? key,
  }) : super(key: key);
  final controllerDetailService = Get.find<DetailService>();
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 16),
        child: InkWell(
            splashColor: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.6),
                    offset: const Offset(4, 4),
                    blurRadius: 16,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                child: Stack(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        AspectRatio(
                          aspectRatio: 2,
                          child: Image.network(
                            data['urlImages'][0],
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16, top: 8, bottom: 8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        data['name'],
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 22,
                                        ),
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            data['location'],
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey
                                                    .withOpacity(0.8)),
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          const Icon(
                                            Icons.location_city,
                                            size: 12,
                                            color: Colors.blue,
                                          ),
                                          Expanded(
                                            child: Text(
                                              ' ',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey
                                                      .withOpacity(0.8)),
                                            ),
                                          ),
                                        ],
                                      ),
                                      /* Padding(
                                            padding:
                                                const EdgeInsets.only(top: 4),
                                            child: Row(
                                              children: <Widget>[
                                                RatingBar(
                                                  initialRating:
                                                      hotelData!.rating,
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  itemCount: 5,
                                                  itemSize: 24,
                                                  ratingWidget: RatingWidget(
                                                    full: Icon(
                                                      Icons.star_rate_rounded,
                                                      color: HotelAppTheme
                                                              .buildLightTheme()
                                                          .primaryColor,
                                                    ),
                                                    half: Icon(
                                                      Icons.star_half_rounded,
                                                      color: HotelAppTheme
                                                              .buildLightTheme()
                                                          .primaryColor,
                                                    ),
                                                    empty: Icon(
                                                      Icons
                                                          .star_border_rounded,
                                                      color: HotelAppTheme
                                                              .buildLightTheme()
                                                          .primaryColor,
                                                    ),
                                                  ),
                                                  itemPadding:
                                                      EdgeInsets.zero,
                                                  onRatingUpdate: (rating) {
                                                    print(rating);
                                                  },
                                                ),
                                                Text(
                                                  ' ${hotelData!.reviews} Reviews',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey
                                                          .withOpacity(0.8)),
                                                ),
                                              ],
                                            ),
                                          ),*/
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 16, top: 8),
                                child: data['pricepernight'] != null
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Text(
                                            "${data["pricepernight"]}\$",
                                            textAlign: TextAlign.left,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 22,
                                            ),
                                          ),
                                          Text(
                                            '/per night',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey
                                                    .withOpacity(0.8)),
                                          ),
                                        ],
                                      )
                                    : Container(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(32.0),
                          ),
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                              icon: const Icon(
                                Icons.favorite,
                                color: Colors.blue,
                              ),
                              onPressed: () {
                                controllerDetailService
                                    .deleteFavorite(data['id']);
                              },
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )));
  }
}
