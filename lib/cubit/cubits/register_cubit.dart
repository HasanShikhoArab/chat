import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());


  Future<void> Registergion({required String email , required String password }) async {
    emit(RegisterLoading());


    try{  UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
        email: email, password: password)
    ;
    emit(RegisterSucces());
    }on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterFailure(errormessage: 'weak-password'));
      } else if

      (e.code == 'email-already-in-use') {
        emit(RegisterFailure(errormessage: 'email-already-in-use'));
      }
    }catch(e){
      emit(RegisterFailure(errormessage: 'some thing error'));
    }


  }
}
