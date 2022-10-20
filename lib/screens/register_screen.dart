import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/screens/login_screen.dart';
import 'package:http/http.dart' as http;

class registerScreen extends StatefulWidget {
  @override
  State<registerScreen> createState() => _registerScreenState();
}

class _registerScreenState extends State<registerScreen> {
  bool _isObscure = true;

  String regUrl = 'http://136.244.90.233:5057/api/User';

  final formkey = GlobalKey<FormState>();

  var _value = 0;

  TextEditingController nameController = TextEditingController();

  TextEditingController shopController = TextEditingController();

  TextEditingController addressController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>loginScreen()));
          },
        ),
        backgroundColor: Colors.red,
        title: Text(
          'أنشاء حساب',
          style: TextStyle(fontSize: 22),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: TextFormField(
                    controller: nameController,
                    validator: (value) {
                      if (nameController.text.isEmpty)
                        return ('يجب ادخال الاسم');
                      else
                        return null;
                    },
                    textAlign: TextAlign.end,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(15),
                        filled: true,
                        fillColor: Colors.grey[300],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'الاسم الكامل',
                        hintStyle: TextStyle(fontSize: 18),
                        suffixIcon: Icon(Icons.person)),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: TextFormField(
                    controller: shopController,
                    validator: (value) {
                      if (shopController.text.isEmpty)
                        return ('يرجى ادخال اسم المحل');
                      else
                        return null;
                    },
                    textAlign: TextAlign.end,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(15),
                        filled: true,
                        fillColor: Colors.grey[300],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'اسم المحل',
                        hintStyle: TextStyle(fontSize: 18),
                        suffixIcon: Icon(Icons.shopping_bag)),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: TextFormField(
                    controller: addressController,
                    validator: (value) {
                      if (addressController.text.isEmpty)
                        return ('يرجى ادخال العنوان');
                      else
                        return null;
                    },
                    textAlign: TextAlign.end,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(15),
                        filled: true,
                        fillColor: Colors.grey[300],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'العنوان',
                        hintStyle: TextStyle(fontSize: 18),
                        suffixIcon: Icon(Icons.location_on_outlined)),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: TextFormField(
                    controller: phoneController,
                    validator: (value) {
                      if (phoneController.text.isEmpty)
                        return ('يرجى اردخال رقم الهاتف');
                      else
                        return null;
                    },
                    textAlign: TextAlign.end,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(15),
                        filled: true,
                        fillColor: Colors.grey[300],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'رقم الهاتف',
                        hintStyle: TextStyle(fontSize: 18),
                        suffixIcon: Icon(Icons.phone)),
                  ),
                ),

                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: TextFormField(
                    controller: passwordController,
                    validator: (value) {
                      if (passwordController.text.isEmpty)
                        return ('يجب ادخال كلمة مرور');
                      else
                        return null;
                    },
                    obscureText: _isObscure,
                    textAlign: TextAlign.end,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(15),
                        filled: true,
                        fillColor: Colors.grey[300],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'كلمة المرور',
                        hintStyle: TextStyle(fontSize: 20),
                        suffixIcon: Icon(Icons.lock),
                        prefixIcon: IconButton(
                            icon: Icon(_isObscure
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            })),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 15, bottom: 5),
                  child: GestureDetector(
                    onTap: () {
                      if (formkey.currentState!.validate()) {
                        register(
                            nameController.text,
                            shopController.text,
                            addressController.text,
                            phoneController.text,
                            passwordController.text);
                      }
                    },
                    child: Container(
                      alignment: AlignmentDirectional.center,
                      width: MediaQuery.of(context).size.width,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'تسجيل الدخول',
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> register(String name, String shop, String address, String phone,
      String pass) async {
    final String encodedData = json.encode({
      "fullName": name,
      "password": pass,
      "phoneNumber": phone,
      "shop": {
        "name": shop,
        "address": address,
      }
    });
    var response = await http.post(Uri.parse(regUrl),
        body: encodedData);

    if (response.statusCode == 200)
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => loginScreen()));
    else
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Invalid')));
  }
}

