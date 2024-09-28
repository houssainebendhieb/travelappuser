import 'package:flutter/material.dart';

Widget travelCard(
    String imgUrl, String hotelName, String location, int rating, String type) {
  return Card(
    margin: const EdgeInsets.only(right: 22.0),
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30.0),
    ),
    elevation: 5.0,
    child: Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: imgUrl != ""
            ? NetworkImage(imgUrl)
            : const NetworkImage(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUrgu4a7W_OM8LmAuN7Prk8dzWXm7PVB_FmA&s"),
        fit: BoxFit.cover,
        scale: 2.0,
      )),
      width: 200.0,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            type == "hotel"
                ? Row(
                    children: [
                      for (var i = 0; i < rating; i++)
                        const Icon(
                          Icons.star,
                          color: Color(0xFFFE8C68),
                        ),
                    ],
                  )
                : Container(),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hotelName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(
                    height: 3.0,
                  ),
                  Text(
                    location,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
