import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/core/networking/api_result.dart';
import 'package:bayt_aura/features/auth/data/repos/signup_repo.dart';
import 'package:bayt_aura/features/auth/logic/cubits/sign_up_state.dart';
import 'package:bayt_aura/features/auth/data/models/sign_up_request_body.dart';

class SignupCubit extends Cubit<SignupState> {
  final SignupRepo _signupRepo;
  SignupCubit(this._signupRepo) : super(const SignupState.initial());

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController companyAddressController = TextEditingController();

  TextEditingController passwordConfirmationController =
      TextEditingController();


  String selectedRole = "Customer"; 
  void setRole(String role) {
    selectedRole = role;
    emit(SignupRoleChanged(role)); 
  }



  final formKey = GlobalKey<FormState>();

  void signupCustomer() async {
    emit(const SignupState.signupLoading());
    final response = await _signupRepo.signupCustomer(
      SignupRequestBody(
        username: userNameController.text,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailController.text,
        phone: phoneController.text,
        password: passwordController.text,
      ),
    );
    response.when(
      success: (signupResponse) {
        emit(SignupState.signupSuccess(signupResponse));
      },
      failure: (error) {
        emit(SignupState.signupError(error: error.failure.message ?? ''));
      },
    );
  }

  void signupAdmin() async {
    emit(const SignupState.signupLoading());
    final response = await _signupRepo.signupAdmin(
      SignupRequestBody(
        username: userNameController.text,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailController.text,
        phone: phoneController.text,
        password: passwordController.text,
      ),
    );
    response.when(
      success: (signupResponse) {
        emit(SignupState.signupSuccess(signupResponse));
      },
      failure: (error) {
        emit(SignupState.signupError(error: error.failure.message ?? ''));
      },
    );
  }

  void signupProvider() async {
    emit(const SignupState.signupLoading());
    final response = await _signupRepo.signupProvider(
      SignupRequestBody(
        username: userNameController.text,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailController.text,
        phone: phoneController.text,
        password: passwordController.text,
        companyName: companyNameController.text,

        companyAddress: companyAddressController.text,
      ),
    );
    response.when(
      success: (signupResponse) {
        emit(SignupState.signupSuccess(signupResponse));
      },
      failure: (error) {
        emit(SignupState.signupError(error: error.failure.message ?? ''));
      },
    );
  }
}
