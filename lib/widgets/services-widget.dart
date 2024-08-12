// ignore_for_file: file_names, prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations

//import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_comm/models/services-model.dart';
import 'package:e_comm/screens/user-panel/all-services.dart';
//import 'package:e_comm/utils/app-constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';

import '../screens/user-panel/single-service-screen.dart';
//import 'package:image_card/image_card.dart';

//import '../screens/user-panel/product-deatils-screen.dart';

class Services extends StatelessWidget {
  const Services({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection('Services').get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("Error"),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            height: Get.height / 5,
            child: Center(
              child: CupertinoActivityIndicator(),
            ),
          );
        }

        if (snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text("No services found!"),
          );
        }

        if (snapshot.data != null) {
          return Container(
            height: Get.height / 5,
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                ServicesModel serviceModel = ServicesModel(
                  serviceID: snapshot.data!.docs[index]['serviceID'],
                  serviceImg: snapshot.data!.docs[index]['serviceImg'],
                  serviceName: snapshot.data!.docs[index]['serviceName'],
                );
                return Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.to(() =>
                          SingleServicesScreen(serviceID: serviceModel.serviceID)),
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Container(
                          child: FillImageCard(
                            borderRadius: 20.0,
                            width: Get.width / 4.0,
                            heightImage: Get.height / 12,
                            imageProvider: CachedNetworkImageProvider(
                              serviceModel.serviceImg,
                            ),
                            title: Center(
                              child: Text(
                                serviceModel.serviceName,
                                style: TextStyle(fontSize: 12.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        }

        return Container();
      },
    );
  }
}
