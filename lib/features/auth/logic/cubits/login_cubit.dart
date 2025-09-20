import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/core/networking/api_result.dart';
import 'package:bayt_aura/core/networking/dio_factory.dart'; 
import 'package:bayt_aura/core/helpers/shared_pref_helper.dart';
import 'package:bayt_aura/features/auth/data/repos/login_repo.dart';
import 'package:bayt_aura/features/auth/logic/cubits/login_state.dart';
import 'package:bayt_aura/features/auth/data/models/login_request_body.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepo _loginRepo;
  LoginCubit(this._loginRepo) : super(LoginState.initial());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void emitLoginStates() async {
    emit(const LoginState.loading());
    final response = await _loginRepo.login(
      LoginRequestBody(
        email: emailController.text,
        password: passwordController.text,
      ),
    );

    response.when(
      success: (loginResponse) async {
        emit(LoginState.success(loginResponse));

        await SharedPrefHelper.setSecuredString(
          "auth_token",
          loginResponse.token!,
        );

        DioFactory.setTokenIntoHeaderAfterLogin(loginResponse.token!);
      },
      failure: (error) {
        emit(LoginState.error(error: error.failure.message ?? ""));
      },
    );
  }
}
