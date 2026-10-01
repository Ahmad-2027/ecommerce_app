import 'package:ecommerce_app/models/user_data.dart';
import 'package:ecommerce_app/services/auth_services.dart';
import 'package:ecommerce_app/services/firestore_services.dart';
import 'package:ecommerce_app/utitlities/api_paths.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final AuthServices authService = AuthServicesImp();
  final FirestoreServices _firestoreServices = FirestoreServices.instance;
  Future<void> loginWithPasswordAndEmail({
    required String email,
    required String password,
  }) async {
    try {
      emit(const AuthChecking());
      final result = await authService.loginWithPasswordandEmail(
        email,
        password,
      );
      if (result) {
        emit(const AuthDone());
      } else {
        emit(AuthFailed(message: "Login credentials"));
      }
    } catch (e) {
      emit(AuthFailed(message: e.toString()));
    }
  }

  Future<void> registerWithPasswordAndEmail({
    required String email,
    required String password,
    required String userName,
  }) async {
    try {
      emit(const AuthChecking());
      final result = await authService.registerWithPasswordandEmail(
        email,
        password,
      );
      if (result) {
        await saveUserData(email: email, userName: userName);
        emit(const AuthDone());
      } else {
        emit(AuthFailed(message: "Reister failed"));
      }
    } catch (e) {
      emit(AuthFailed(message: e.toString()));
    }
  }

  Future<void> saveUserData({
    required String email,
    required String userName,
  }) async {
    final currentUser = authService.currentUser();
    final user = User(
      id: currentUser!.uid,
      userName: userName,
      email: email,
      createdAt: DateTime.now().toIso8601String(),
    );
    await _firestoreServices.setData(
      path: ApiPaths.users(user.id),
      data: user.toMap(),
    );
  }

  void checkAuth() {
    try {
      final user = authService.currentUser();
      if (user == null) {
        emit(AuthFailed(message: "Failed"));
      } else {
        emit(AuthDone());
      }
    } catch (e) {
      emit(AuthFailed(message: e.toString()));
    }
  }

  Future<void> logOut() async {
    try {
      emit(AuthLoggingOut());
      await authService.logOut();
      emit(AuthLoggedout());
    } catch (e) {
      emit(AuthLoggingOutFailed(message: e.toString()));
    }
  }

  Future<void> authnticateWithGoogle() async {
    try {
      emit(const GoogleAuthinticating());
      final result = await authService.authinicateWithGoogle();
      if (result) {
        emit(const GoogleAuthDone());
      } else {
        emit(GoogleAuthFailed(message: "Failed"));
      }
    } catch (e) {
      emit(GoogleAuthFailed(message: e.toString()));
    }
  }
}
