// ignore_for_file: file_names, prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, prefer_interpolation_to_compose_strings

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_comm/models/product-model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';

import '../models/service-detail-model.dart';
import '../screens/user-panel/service-details-screen.dart';

class AllServicesWidget extends StatelessWidget {
  const AllServicesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('servicedetail')
          .get(),
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
          return GridView.builder(
            itemCount: snapshot.data!.docs.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              childAspectRatio: 0.80,
            ),
            itemBuilder: (context, index) {
              final serviceData = snapshot.data!.docs[index];
              ServicedetailModel servicedetailModel = ServicedetailModel(
                servicedID: serviceData['servicedID'],
                serviceID: serviceData['serviceID'],
                serviceName: serviceData['serviceName'],
                servicedImg: serviceData['servicedImg'],
                serviceDescription: serviceData['serviceDescription'],
              );

              // CategoriesModel categoriesModel = CategoriesModel(
              //   categoryId: snapshot.data!.docs[index]['categoryId'],
              //   categoryImg: snapshot.data!.docs[index]['categoryImg'],
              //   categoryName: snapshot.data!.docs[index]['categoryName'],
              //   createdAt: snapshot.data!.docs[index]['createdAt'],
              //   updatedAt: snapshot.data!.docs[index]['updatedAt'],
              // );
              return Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.to(
                            () => ServiceDetailsScreen(servicedetailModel: servicedetailModel)),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(
                        child: FillImageCard(
                          borderRadius: 20.0,
                          width: Get.width / 2.3,
                          heightImage: Get.height / 6,
                          imageProvider: CachedNetworkImageProvider(
                            servicedetailModel.servicedImg[0],
                          ),
                          title: Center(
                            child: Text(
                              servicedetailModel.serviceName,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
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
          );
        }

        return Container();
      },
    );
  }
}
