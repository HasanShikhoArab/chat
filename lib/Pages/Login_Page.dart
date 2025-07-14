import 'package:chat/Pages/chatapp.dart';
import 'package:chat/cubit/cubits/login_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../Constes.dart';
import '../weights/Custom_Textfiled.dart';
import '../weights/Custom_button.dart';
import 'Register_page.dart';



class loginApp extends StatelessWidget {
  loginApp({super.key});
  static String id = 'LoginPage';
  GlobalKey<FormState> fromkey = GlobalKey();

  bool isloading = false;

     String? email;

  String? password;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit,LoginState>(
      listener: (context, state) {
        if(state is LoginLoading){

          isloading=true;
        }else if(state is LoginSucces){

          Navigator.pushNamed(context,chat.id,arguments: email);
          isloading=false;

        }
        else if(state is LoginFailure){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errormessage)));
        }
      },
   builder:(context, state) =>  ModalProgressHUD(
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

BlocProvider.of<LoginCubit>(context).Logination(email: email!, password: password!);

                          }
                       else {}
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
      ),
    );
  }

  Future<void> Logination() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
