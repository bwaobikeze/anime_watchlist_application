// ignore_for_file: void_checks

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../repositories/firebase_auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async{
      // TODO: implement event handler
      if (event is LoginEvent) {
        print(' it is a login LoginEvent');
        FieAuth fieAuth = FieAuth();
        User? user = await fieAuth.signIn(event.email, event.password);
        if (user != null) {
          emit(Authenticated());
        } else {
          emit(Unauthenticated());
        }
      } else if (event is RegisterEvent) {
        FieAuth fieAuth = FieAuth();
        User? user = await fieAuth.createAccount(event.email, event.password, event.username, event.Name, event.LastName);
        if (user != null) {
          emit(Authenticated());
        } else {
          emit(Unauthenticated());
        }
      } else if (event is LogoutEvent) {
        FieAuth fieAuth = FieAuth();
        fieAuth.signout();
        emit(Unauthenticated());
      }
    });
  }
}
