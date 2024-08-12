import 'package:e_comm/screens/user-panel/all-orders-screen.dart';
import 'package:e_comm/screens/user-panel/all-products-screen.dart';
import 'package:e_comm/screens/user-panel/main-screen.dart';
import 'package:e_comm/utils/app-constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../screens/auth-ui/welcome-screen.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  late User? _user;

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  Future<void> _getUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    String? identifier = _user?.email;
    String firstLetter = identifier != null && identifier.isNotEmpty ? identifier[0] : "";

    return Padding(
      padding: EdgeInsets.only(top: Get.height / 25),
      child: Drawer(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        child: Wrap(
          runSpacing: 10,
          children: [
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  _user?.displayName ?? "",
                  style: TextStyle(color: AppConstant.appTextColor),
                ),
                leading: CircleAvatar(
                  radius: 22.0,
                  backgroundColor: AppConstant.appMainColor,
                  child: Text(
                    firstLetter.toUpperCase(),
                    style: TextStyle(color: AppConstant.appTextColor),
                  ),
                ),
              ),
            ),
            Divider(
              indent: 10.0,
              endIndent: 10.0,
              thickness: 1.5,
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  "Home",
                  style: TextStyle(color: AppConstant.appTextColor),
                ),
                leading: Icon(
                  Icons.home,
                  color: AppConstant.appTextColor,
                ),
                trailing: Icon(
                  Icons.arrow_forward,
                  color: AppConstant.appTextColor,
                ),
                onTap: () {
                  Get.back();
                  Get.to(() => MainScreen());
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  "Products",
                  style: TextStyle(color: AppConstant.appTextColor),
                ),
                leading: Icon(
                  Icons.production_quantity_limits,
                  color: AppConstant.appTextColor,
                ),
                trailing: Icon(
                  Icons.arrow_forward,
                  color: AppConstant.appTextColor,
                ),
                onTap: () {
                  Get.back();
                  Get.to(() => AllProductsScreen());
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  "Orders",
                  style: TextStyle(color: AppConstant.appTextColor),
                ),
                leading: Icon(
                  Icons.shopping_bag,
                  color: AppConstant.appTextColor,
                ),
                trailing: Icon(
                  Icons.arrow_forward,
                  color: AppConstant.appTextColor,
                ),
                onTap: () {
                  Get.back();
                  Get.to(() => AllOrdersScreen());
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                onTap: () async {
                  GoogleSignIn googleSignIn = GoogleSignIn();
                  FirebaseAuth _auth = FirebaseAuth.instance;
                  await _auth.signOut();
                  await googleSignIn.signOut();
                  Get.offAll(() => WelcomeScreen());
                },
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  "Logout",
                  style: TextStyle(color: AppConstant.appTextColor),
                ),
                leading: Icon(
                  Icons.logout,
                  color: AppConstant.appTextColor,
                ),
                trailing: Icon(
                  Icons.arrow_forward,
                  color: AppConstant.appTextColor,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: AppConstant.appScendoryColor,
      ),
    );
  }
}
