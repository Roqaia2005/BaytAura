import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';
import 'package:bayt_aura/core/di/dependency_injection.dart';
import 'package:bayt_aura/core/helpers/app_circular_indicator.dart';
import 'package:bayt_aura/features/customer/logic/customer_cubit.dart';
import 'package:bayt_aura/features/customer/logic/customer_state.dart';
import 'package:bayt_aura/features/property/data/repos/media_repo.dart';
import 'package:bayt_aura/features/customer/data/repo/customer_repo.dart';

class CustomerRequestsScreen extends StatelessWidget {
  const CustomerRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          CustomerRequestCubit(getIt<CustomerRepo>(), getIt<MediaRepository>())
            ..getMyRequests(),
      child: BlocBuilder<CustomerRequestCubit, CustomerRequestState>(
        builder: (context, state) {
          final cubit = context.read<CustomerRequestCubit>();

          if (state is CustomerRequestLoading) {
            return const Center(child: AppCircularIndicator());
          } else if (state is CustomerRequestsLoaded) {
            final requests = state.requests;
            if (requests.isEmpty) {
              return Center(
                child: Text(
                  "No requests yet.",
                  style: TextStyles.font16BlueBold,
                ),
              );
            }
            return Scaffold(
              backgroundColor: Colors.white,

              appBar: AppBar(
                centerTitle: true,
                title: Text("My Requests", style: TextStyles.font24WhiteBold),
                backgroundColor: AppColors.blue,
              ),
              body: ListView.builder(
                itemCount: requests.length,
                itemBuilder: (context, index) {
                  final request = requests[index];
                  return Card(
                    color: Colors.white,

                    margin: const EdgeInsets.all(8),
                    child: ListTile(
                      title: Text(
                        request.title,
                        style: TextStyles.font14BlueBold,
                      ),
                      subtitle: Text(
                        style: TextStyles.font12DarkBeigeRegular,
                        "${request.type} - ${request.purpose} - ${request.status}",
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          cubit.deleteRequest(request.id!).then((_) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Request deleted",
                                  style: TextStyles.font14BlueBold,
                                ),
                              ),
                            );
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (state is CustomerRequestError) {
            return Center(child: Text("Error: ${state.message}"));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
