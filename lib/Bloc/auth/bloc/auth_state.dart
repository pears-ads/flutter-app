part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
   @override
  List<Object> get props => [];
}

//loaded state[Success] [google sign in]
class AuthLoadedGoogle extends AuthState{
  const AuthLoadedGoogle();
  @override
  List<Object> get props => [];
}


//error 
class AuthErrorState extends AuthState{
  const AuthErrorState();
  @override
  List<Object> get props => [];
}