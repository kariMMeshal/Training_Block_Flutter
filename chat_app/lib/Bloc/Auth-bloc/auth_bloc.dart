import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        emit(LoginLoading());
        try {
          print("trying-----------");
          UserCredential user = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: event.email, password: event.password);
          emit(LoginSuccess());
        } on FirebaseAuthException catch (ex) {
          if (ex.code == 'user-not-found') {
            emit(
              LoginFailure(errorMessage: "User-Not-Found"),
            );
          } else if (ex.code == 'wrong-password') {
            emit(
              LoginFailure(errorMessage: "Wrong-Pass"),
            );
          } else {
            emit(LoginFailure(errorMessage: "Login Failed: ${ex.message}"));
          }
        } catch (ex) {
          emit(LoginFailure(errorMessage: "Something Went Wrong "));
        }
      }
      if (event is RegisterEvent) {
        emit(RegisterLoading());
        try {
          UserCredential user = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: event.email, password: event.password);
          emit(RegisterSuccess());
        } on FirebaseAuthException catch (ex) {
          if (ex.code == 'weak-password') {
            emit(RegisterFailure(errorMessage: "Weak-Pass"));
          } else if (ex.code == 'email-already-in-use') {
            emit(RegisterFailure(errorMessage: "email-already-in-use"));
          }
        } catch (ex) {
          emit(RegisterFailure(errorMessage: " Something Went Wrong :( "));
        }
      }
    });
  }

}
