import 'package:chat/Pages/chatapp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../Constes.dart';
import '../weights/Custom_Textfiled.dart';
import '../weights/Custom_button.dart';
import 'Register_page.dart';

class loginApp extends StatefulWidget {
  loginApp({super.key});
  static String id = 'LoginPage';
  @override
  State<loginApp> createState() => _loginAppState();
}

class _loginAppState extends State<loginApp> {
  GlobalKey<FormState> fromkey = GlobalKey();

  bool isloading = false;

     String? email;

  String? password;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isloading,
      child: Scaffold(

        backgroundColor: kprimaryColor.shade800,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Form(
            key: fromkey,
            child: ListView(children: [
              Column(
                children: [
                  SizedBox(
                    height: 75,
                  ),
                  Image.asset(
                    'assets/j.png',
                    height: 200,
                    width: 200,
                  ),
                  Text(
                    'Scholar Chat',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Sign In',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CustomTextFild(

                    hinText: 'Email',
                    onchange: (data) {
                      email=data;
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CustomTextFild(
                    obs: true,
                    hinText: 'Password',
                    onchange: (data) {
                      password=data;
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CustomButton(
                      text1: 'Sign In',

                      ontap: () async {
                        if (fromkey.currentState!.validate()) {
                          isloading = true;
                          setState(() {});

                          try {
                            await Logination();
                          Navigator.pushNamed(context, chat.id,arguments: email);
                          }  on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('weak-password')));
                            } else if

                            (e.code == 'email-already-in-use') {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('weak-password')));
                            }
                          }catch(ex){
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('error')));

                          }
                          isloading = false;
                          setState(() {});
                        } else {}
                      }

                      ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'dont have an account ?',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, Register.id);
                          },
                          child: Text(
                            'Register',
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          )),


                    ],
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Future<void> Logination() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
