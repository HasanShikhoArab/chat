import 'package:chat/Pages/chatapp.dart';
import 'package:chat/cubit/cubits/register_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../Constes.dart';
import '../weights/Custom_Textfiled.dart';
import '../weights/Custom_button.dart';


class Register extends StatelessWidget {
  String? email;
  static String id = 'RegisterPage';
  String? password;

  GlobalKey<FormState> fromkey = GlobalKey();

  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(

      listener: (context, state) {
        if (state is RegisterLoading) {
          isloading = true;
        } else if (state is RegisterSucces) {
          Navigator.pushNamed(context, chat.id);
          isloading = false;
        }
        else if (state is RegisterFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errormessage)));
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isloading,
          child: Scaffold(
            backgroundColor: kprimaryColor.shade700,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Form(
                key: fromkey,

                child: ListView(children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 50,
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
                      Row(mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Register',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            )
                          ]),
                      SizedBox(
                        height: 5,
                      ),
                      CustomTextFild(
                        hinText: 'Email',
                        onchange: (p0) {
                          email = p0;
                        },
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      CustomTextFild(
                        obs: true,
                        hinText: 'Password',
                        onchange: (p0) {
                          password = p0;
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      CustomButton(
                          text1: 'Register',
                          ontap: () async {
                            //   try {
                            //     await Registergion();
                            //   }  on FirebaseAuthException catch (e) {
                            //     if (e.code == 'weak-password') {
                            //      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('weak-password')));
                            //     } else if
                            //
                            //     (e.code == 'email-already-in-use') {
                            //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('weak-password')));
                            //     }
                            //   }catch(ex){
                            //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('error')));
                            //
                            //   }
                            //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Succes')));
                            //
                            // },

                            if (fromkey.currentState!.validate()) {
                              BlocProvider.of<RegisterCubit>(context)
                                  .Registergion(
                                  email: email!, password: password!);
                            }

                            else {}
                          }
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'already have an account ?',
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white),
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
      },
    );
  }

  Future<void> Registergion() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
        email: email!, password: password!);
  }
}
