import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/screens/register_screen.dart';
import 'package:flutter_login/screens/welcomeScreen.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class loginScreen extends StatefulWidget {

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  bool _isObscure = true;
  final formkey = GlobalKey<FormState>();
  TextEditingController phoneController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  String loginUrl = "http://136.244.90.233:5057/api/Auth/login";






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              children: [
                SizedBox(height: 100,),
                Center(
                  child: CircleAvatar(
                    radius: 80,
                  backgroundImage: AssetImage('assets/logo.png')
                  ),
                ),
                SizedBox(height: 50,),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 20),
                  child: TextFormField(
                    controller: phoneController,
                    validator: (value)
                    {
                      if(phoneController.text.isEmpty)
                        return('must enter phone number');
                      else
                        return null;
                    },
                    textAlign: TextAlign.end,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[300],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'رقم الهاتف',
                      hintStyle: TextStyle(
                        fontSize: 20
                      ),
                      suffixIcon: Icon(Icons.phone)
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 20),
                  child: TextFormField(
                    controller: passwordController,
                    validator: (value)
                    {
                      if(passwordController.text.isEmpty)
                        return('must enter password');
                      else
                        return null;
                    },
                    obscureText: _isObscure,
                    textAlign: TextAlign.end,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[300],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'كلمة المرور',
                        hintStyle: TextStyle(
                            fontSize: 20
                        ),
                        suffixIcon: Icon(Icons.lock),
                      prefixIcon:IconButton(
                    icon: Icon(
                    _isObscure ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      })),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20,top: 15,bottom: 5),
                  child: GestureDetector(
                    onTap: (){
                      if (formkey.currentState!.validate())
                        login(phoneController.text, passwordController.text);


                    },
                    child: Container(
                      alignment: AlignmentDirectional.center,
                      width: MediaQuery.of(context).size.width,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text('تسجيل الدخول',style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w700
                      ),),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>registerScreen()));
                        }
                        ,child: Text('أنشاء حساب الان'
                          ,style: TextStyle(
                            decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w800,
                          color: Colors.red,
                          fontSize: 18
                        ),),
                      ),
                      Text('ليس لديك حساب؟',style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> login(String phone,String pass) async
  {

    var response=await http.post(Uri.parse(loginUrl),body: ({
      "userName": phone,
      "password": pass
    }));
    if(response.statusCode==200)
      Navigator.push(context, MaterialPageRoute(builder: (context)=>WelcomeScreen()));
    else
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid')));
  }
  

}
