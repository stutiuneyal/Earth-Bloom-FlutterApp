// ignore_for_file: file_names, must_be_immutable, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_interpolation_to_compose_strings, unused_local_variable, avoid_print, prefer_const_declarations, deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_comm/models/product-model.dart';
import 'package:e_comm/utils/app-constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:e_comm/models/service-detail-model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/cart-model.dart';
import 'cart-screen.dart';

class ServiceDetailsScreen extends StatefulWidget {
  ServicedetailModel servicedetailModel;
  ServiceDetailsScreen({super.key, required this.servicedetailModel});

  @override
  State<ServiceDetailsScreen> createState() => _ServiceDetailsScreenState();
}

class _ServiceDetailsScreenState extends State<ServiceDetailsScreen> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppConstant.appTextColor),
        backgroundColor: AppConstant.appMainColor,
        title: Text(
          "Servies Details",
          style: TextStyle(color: AppConstant.appTextColor),
        ),
        actions: [
          GestureDetector(
            onTap: () => Get.to(() => CartScreen()),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.shopping_cart,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child:Container(
          child: Column(
            children: [
              //product images
              SizedBox(
                height: Get.height / 60,
              ),
              CarouselSlider(
                items: widget.servicedetailModel.servicedImg
                    .map(
                      (imageUrls) => ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: CachedNetworkImage(
                      imageUrl: imageUrls,
                      fit: BoxFit.cover,
                      width: Get.width - 10,
                      placeholder: (context, url) => ColoredBox(
                        color: Colors.white,
                        child: Center(
                          child: CupertinoActivityIndicator(),
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                )
                    .toList(),
                options: CarouselOptions(
                  scrollDirection: Axis.horizontal,
                  autoPlay: true,
                  aspectRatio: 1.25,
                  viewportFraction: 1,
                ),
              ),

              Padding(
                padding: EdgeInsets.all(8.0),
                child: Card(
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  widget.servicedetailModel.serviceName,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              widget.servicedetailModel.serviceDescription,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Material(
                                child: Container(
                                  width: Get.width / 3.0,
                                  height: Get.height / 16,
                                  decoration: BoxDecoration(
                                    color: AppConstant.appScendoryColor,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: TextButton(
                                    child: Text(
                                      "WhatsApp",
                                      style: TextStyle(
                                          color: AppConstant.appTextColor),
                                    ),
                                    onPressed: () {
                                      sendMessageOnWhatsApp(
                                        servicedetailModel: widget
                                            .servicedetailModel,
                                      );
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


  static Future<void> sendMessageOnWhatsApp({
    required ServicedetailModel servicedetailModel,
  }) async {
    final number = "+919901946869";
    final message =
        "Hello GrowPro \n I want to know about this design \n ${servicedetailModel
        .serviceName} \n ${servicedetailModel.servicedID}";

    final url = 'https://wa.me/$number?text=${Uri.encodeComponent(message)}';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

//checkl prooduct exist or not
}
