import 'package:flutter_bloc/flutter_bloc.dart';

part 'secure_password_state.dart';

class SecurePasswordCubit extends Cubit<SecurePasswordState> {
  SecurePasswordCubit() : super(SecurePasswordInitial());

  void setPasswordUnvisible() {
    emit(PasswordIsUnVisible());
  }
    void setPasswordvisible() {
    emit(PasswordIsVisible());
  }
}
