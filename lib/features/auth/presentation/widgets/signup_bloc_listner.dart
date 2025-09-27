import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/core/routing/routes.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:bayt_aura/core/helpers/extensions.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';
import 'package:bayt_aura/features/auth/logic/cubits/sign_up_cubit.dart';
import 'package:bayt_aura/features/auth/logic/cubits/sign_up_state.dart';
import 'package:bayt_aura/features/auth/data/models/sign_up_response.dart';

class SignupBlocListener extends StatelessWidget {
  const SignupBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupCubit, SignupState>(
      listenWhen: (previous, current) =>
          current is SignupLoading ||
          current is SignupSuccess ||
          current is SignupError,
      listener: (context, state) {
        state.whenOrNull(
          signupLoading: () {
            showDialog(
              context: context,
              builder: (context) => const Center(
                child: CircularProgressIndicator(color: AppColors.blue),
              ),
            );
          },
          signupSuccess: (signupResponse) {
            context.pop(); // close loading
            showSuccessDialog(context, signupResponse);
          },
          signupError: (error) {
            setupErrorState(context, error);
          },
        );
      },
      child: const SizedBox.shrink(),
    );
  }

  void showSuccessDialog(BuildContext context, SignupResponse signupResponse) {
    String message;

    if (signupResponse.role == 'CUSTOMER') {
      message = 'Congratulations, you have signed up successfully!';
    } else if (signupResponse.role == 'PROVIDER') {
      context.pushNamed(Routes.providerRequestSubmittedView);
      message =
          'Account created! An admin will review your request before you can login.';
    } else {
      message = 'Signup completed!';
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Signup Successful', style: TextStyles.font16BlueBold),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message, style: TextStyles.font14BlueRegular),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                if (signupResponse.role == 'customer') {
                  context.pushNamedAndRemoveUntil(Routes.customerScreen);
                } else {
                  context.pop();
                }
              },
              child: Text('Continue', style: TextStyles.font14BlueBold),
            ),
          ],
        );
      },
    );
  }

  void setupErrorState(BuildContext context, String error) {
    context.pop(); // close loading
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        icon: const Icon(Icons.error, color: Colors.red, size: 32),
        content: Text(error, style: TextStyles.font14BlueRegular),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: Text('Got it', style: TextStyles.font14BlueBold),
          ),
        ],
      ),
    );
  }
}
