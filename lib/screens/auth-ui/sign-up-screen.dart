import 'package:e_comm/screens/auth-ui/sign-in-screen.dart';
import 'package:e_comm/utils/app-constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';

import '../../controllers/sign-up-controller.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignUpController signUpController = Get.put(SignUpController());
  TextEditingController username = TextEditingController();
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPhone = TextEditingController();
  TextEditingController userCity = TextEditingController();
  TextEditingController userPassword = TextEditingController();

  // Regular expression for Indian phone numbers (10 digits starting with 6, 7, 8, or 9)
  RegExp indianPhoneNumberRegExp = RegExp(r'^[6-9]\d{9}$');

  // Function to validate email
  bool isValidEmail(String email) {
    String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regExp = RegExp(emailPattern);
    return regExp.hasMatch(email);
  }

  // Function to validate username
  bool isValidUsername(String username) {
    RegExp usernameRegExp = RegExp(r'^[a-zA-Z][a-zA-Z0-9_]{5,29}$');
    return usernameRegExp.hasMatch(username);
  }

  // Function to validate Indian phone numbers
  bool isValidIndianPhoneNumber(String phone) {
    return indianPhoneNumberRegExp.hasMatch(phone);
  }

  // Function to validate city (contains only alphabets)
  bool isValidCity(String city) {
    RegExp cityRegExp = RegExp(r'^[a-zA-Z]+$');
    return cityRegExp.hasMatch(city);
  }

  // Function to validate password
  bool isValidPassword(String password) {
    // Password should be at least 8 characters long
    if (password.length < 8) {
      return false;
    }
    // Password should contain at least one uppercase letter, one lowercase letter, one number, and one special character
    RegExp upperCaseRegExp = RegExp(r'[A-Z]');
    RegExp lowerCaseRegExp = RegExp(r'[a-z]');
    RegExp digitRegExp = RegExp(r'[0-9]');
    RegExp specialCharRegExp = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
    return upperCaseRegExp.hasMatch(password) &&
        lowerCaseRegExp.hasMatch(password) &&
        digitRegExp.hasMatch(password) &&
        specialCharRegExp.hasMatch(password);
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppConstant.appMainColor,
          centerTitle: true,
          title: Text(
            "Sign Up",
            style: TextStyle(color: AppConstant.appTextColor),
          ),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: Get.height / 20,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Welcome to Earth & Bloom",
                    style: TextStyle(
                        color: AppConstant.appScendoryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0),
                  ),
                ),
                SizedBox(
                  height: Get.height / 20,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  width: Get.width,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: userEmail,
                      cursorColor: AppConstant.appScendoryColor,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Email",
                        prefixIcon: Icon(Icons.email),
                        contentPadding: EdgeInsets.only(top: 2.0, left: 8.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  width: Get.width,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: username,
                      cursorColor: AppConstant.appScendoryColor,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        hintText: "UserName",
                        prefixIcon: Icon(Icons.person),
                        contentPadding: EdgeInsets.only(top: 2.0, left: 8.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  width: Get.width,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: userPhone,
                      cursorColor: AppConstant.appScendoryColor,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Phone",
                        prefixIcon: Icon(Icons.phone),
                        contentPadding: EdgeInsets.only(top: 2.0, left: 8.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  width: Get.width,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: userCity,
                      cursorColor: AppConstant.appScendoryColor,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: "City",
                        prefixIcon: Icon(Icons.location_pin),
                        contentPadding: EdgeInsets.only(top: 2.0, left: 8.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your city';
                        }
                        if (!isValidCity(value)) {
                          return 'City should contain only alphabets';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  width: Get.width,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Obx(
                          () => TextFormField(
                        controller: userPassword,
                        obscureText: signUpController.isPasswordVisible.value,
                        cursorColor: AppConstant.appScendoryColor,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          hintText: "Password",
                          prefixIcon: Icon(Icons.password),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              signUpController.isPasswordVisible.toggle();
                            },
                            child: signUpController.isPasswordVisible.value
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility),
                          ),
                          contentPadding: EdgeInsets.only(top: 2.0, left: 8.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a password';
                          }
                          if (!isValidPassword(value)) {
                            return 'Password should be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, one number, and one special character';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height / 20,
                ),
                Material(
                  child: Container(
                    width: Get.width / 2,
                    height: Get.height / 18,
                    decoration: BoxDecoration(
                      color: AppConstant.appScendoryColor,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: TextButton(
                      child: Text(
                        "SIGN UP",
                        style: TextStyle(color: AppConstant.appTextColor),
                      ),
                      onPressed: () async {
                        String name = username.text.trim();
                        String email = userEmail.text.trim();
                        String phone = userPhone.text.trim();
                        String city = userCity.text.trim();
                        String password = userPassword.text.trim();
                        String userDeviceToken = '';

                        if (name.isEmpty) {
                          Get.snackbar(
                            "Error",
                            "Please enter your username",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: AppConstant.appScendoryColor,
                            colorText: AppConstant.appTextColor,
                          );
                        } else if (!isValidUsername(name)) {
                          Get.snackbar(
                            "Error",
                            "Username must be between 6 to 30 characters and can only contain alphanumeric characters and underscores (_), and must start with an alphabetic character",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: AppConstant.appScendoryColor,
                            colorText: AppConstant.appTextColor,
                          );
                        } else if (email.isEmpty) {
                          Get.snackbar(
                            "Error",
                            "Please enter your email",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: AppConstant.appScendoryColor,
                            colorText: AppConstant.appTextColor,
                          );
                        } else if (!isValidEmail(email)) {
                          Get.snackbar(
                            "Error",
                            "Please enter a valid email",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: AppConstant.appScendoryColor,
                            colorText: AppConstant.appTextColor,
                          );
                        } else if (!isValidIndianPhoneNumber(phone)) {
                          Get.snackbar(
                            "Error",
                            "Please enter a valid Indian phone number",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: AppConstant.appScendoryColor,
                            colorText: AppConstant.appTextColor,
                          );
                        } else if (city.isEmpty) {
                          Get.snackbar(
                            "Error",
                            "Please enter your city",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: AppConstant.appScendoryColor,
                            colorText: AppConstant.appTextColor,
                          );
                        } else if (!isValidCity(city)) {
                          Get.snackbar(
                            "Error",
                            "City should contain only alphabets",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: AppConstant.appScendoryColor,
                            colorText: AppConstant.appTextColor,
                          );
                        } else if (password.isEmpty) {
                          Get.snackbar(
                            "Error",
                            "Please enter a password",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: AppConstant.appScendoryColor,
                            colorText: AppConstant.appTextColor,
                          );
                        } else if (!isValidPassword(password)) {
                          Get.snackbar(
                            "Error",
                            "Password should be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, one number, and one special character",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: AppConstant.appScendoryColor,
                            colorText: AppConstant.appTextColor,
                          );
                        } else {
                          UserCredential? userCredential =
                          await signUpController.signUpMethod(
                            name,
                            email,
                            phone,
                            city,
                            password,
                            userDeviceToken,
                          );

                          if (userCredential != null) {
                            Get.snackbar(
                              "Verification email sent.",
                              "Please check your email.",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: AppConstant.appScendoryColor,
                              colorText: AppConstant.appTextColor,
                            );

                            FirebaseAuth.instance.signOut();
                            Get.offAll(() => SignInScreen());
                          }
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height / 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(color: AppConstant.appScendoryColor),
                    ),
                    GestureDetector(
                      onTap: () => Get.offAll(() => SignInScreen()),
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                            color: AppConstant.appScendoryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
      });
  }
}