import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'sign_in_state.dart';

enum SignInStatus { login, signUp }

class SignInCubit extends Cubit<SignInStatus> {
  SignInCubit() : super(SignInStatus.login);

  void showLogin() => emit(SignInStatus.login);
  void showSignup() => emit(SignInStatus.signUp);
}
