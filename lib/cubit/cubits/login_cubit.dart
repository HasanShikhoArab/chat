

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> Logination(
      {required String email, required String password}) async {
    emit(LoginLoading());
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(LoginSucces());}
      on FirebaseAuthException catch (e) {
      if (e.code == 'user not found') {
       emit(LoginFailure(errormessage: 'user not found'));
      } else if

      (e.code == 'wrong password') {
        emit(LoginFailure(errormessage: 'wrong password'));
      }
    }catch(e){
      emit(LoginFailure(errormessage: 'some thing wrong'));
    }
    } 
  }
