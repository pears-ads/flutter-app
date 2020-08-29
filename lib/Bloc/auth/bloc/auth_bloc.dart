import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../../../repository/auth/firebase_auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth_Google firebaseAuth_Google;
  AuthBloc({@required this.firebaseAuth_Google}) : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    //sign in with google event
    if (event is SignInWithGoogle) {
     try {
      final user = await firebaseAuth_Google.sign();
      yield AuthLoaded();
     } catch (_) {
       yield AuthErrorState();
     }
    }
   
    
  }
}
