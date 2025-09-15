import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/core/routing/routes.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:bayt_aura/core/helpers/extensions.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';
import 'package:bayt_aura/features/auth/logic/cubits/login_state.dart';
import 'package:bayt_aura/features/auth/logic/cubits/login_cubit.dart';

class LoginBlocListener extends StatelessWidget {
  const LoginBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (previous, current) =>
          current is Loading || current is Success || current is Error,
      listener: (context, state) {
        state.whenOrNull(
          loading: () {
            showDialog(
              context: context,
              builder: (context) => Center(
                child: CircularProgressIndicator(color: AppColors.blue),
              ),
            );
          },
          success: (loginResponse) {
            context.pop();
            showSuccessDialog(context);
          },
          error: (error) {
            setUpErrorState(context, error);
          },
        );
      },
      child: SizedBox.shrink(),
    );
  }

  void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Login Successful', style: TextStyles.font16BlueBold),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Congratulations, you have logged in successfully!',
                  style: TextStyles.font14BlueRegular,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,

                disabledForegroundColor: Colors.grey.withOpacity(0.38),
              ),
                onPressed: () {
                // Assuming loginResponse contains a 'role' field
                final loginState = context.read<LoginCubit>().state;
                loginState.whenOrNull(
                  success: (loginResponse) {
                  if (loginResponse.role == 'customer') {
                    context.pushNamed(Routes.customerScreen);
                  } else if(loginResponse.role == 'provider') {
                    context.pushNamed(Routes.providerScreen);
                  }

                  },
                );
                },
              child: Text('Continue', style: TextStyles.font14BlueBold),
            ),
          ],
        );
      },
    );
  }

  void setUpErrorState(BuildContext context, String error) {
    context.pop();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        icon: Icon(Icons.error, size: 32, color: Colors.red),
        content: Text(error, style: TextStyles.font14BlueRegular),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: Text("Got it", style: TextStyles.font14BlueBold),
          ),
        ],
      ),
    );
  }
}
