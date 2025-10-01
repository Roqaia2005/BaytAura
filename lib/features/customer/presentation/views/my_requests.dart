import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/core/routing/routes.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:bayt_aura/core/helpers/extensions.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';
import 'package:bayt_aura/core/helpers/app_circular_indicator.dart';
import 'package:bayt_aura/features/customer/logic/customer_cubit.dart';
import 'package:bayt_aura/features/customer/logic/customer_state.dart';
import 'package:bayt_aura/core/networking/local_notification_service.dart';

class MyRequestsView extends StatefulWidget {
  const MyRequestsView({super.key});

  @override
  State<MyRequestsView> createState() => _MyRequestsViewState();
}

class _MyRequestsViewState extends State<MyRequestsView> {
  @override
  void initState() {
    super.initState();
    context.read<CustomerRequestCubit>().getMyRequests();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppColors.blue,
          title: Text("My Requests", style: TextStyles.font24WhiteBold),
          centerTitle: true,
          elevation: 2,
          bottom: TabBar(
            labelStyle: TextStyles.font16WhiteBold,
            indicatorColor: AppColors.beige,
            labelColor: AppColors.beige,
            unselectedLabelColor: Colors.grey,
            tabs: const [
              Tab(text: "All"),
              Tab(text: "Pending"),
              Tab(text: "Accepted"),
              Tab(text: "Rejected"),
            ],
          ),
        ),
        body: BlocConsumer<CustomerRequestCubit, CustomerRequestState>(
          listener: (context, state) {
            if (state is RequestStatusChanged) {
              // Show local notification
              LocalNotificationService.showBasicNotification(
                title: "Request Status Updated",
                body: state
                    .message, // you can customize with request title or status
              );

              // Optional: refresh the request list
              context.read<CustomerRequestCubit>().getMyRequests();
            }
            if (state is CustomerRequestAdded) {
              if (state.uploadErrors.isNotEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Request created, but some images failed: ${state.uploadErrors.length}",
                    ),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Request created successfully")),
                );
              }

              // تحديث القائمة تلقائيًا
              context.read<CustomerRequestCubit>().getMyRequests();
            }

            if (state is CustomerRequestError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Error: ${state.message}")),
              );
            }
          },
          builder: (context, state) {
            if (state is CustomerRequestLoading) {
              return const Center(child: AppCircularIndicator());
            }

            if (state is CustomerRequestsLoaded) {
              final requests = state.requests;
              return TabBarView(
                children: [
                  _buildList(requests),
                  _buildList(
                    requests.where((r) => r.status == "PENDING").toList(),
                  ),
                  _buildList(
                    requests.where((r) => r.status == "ACCEPTED").toList(),
                  ),
                  _buildList(
                    requests.where((r) => r.status == "REJECTED").toList(),
                  ),
                ],
              );
            }

            return const Center(child: AppCircularIndicator());
          },
        ),
      ),
    );
  }

  Widget _buildList(List requests) {
    if (requests.isEmpty) {
      return const Center(child: Text("No requests found"));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: requests.length,
      itemBuilder: (context, index) {
        final req = requests[index];

        return Card(
          elevation: 3,
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: const Icon(Icons.home, color: AppColors.blue, size: 32),
            title: Text(req.title, style: TextStyles.font14BlueBold),
            subtitle: Text(
              "${req.type} - ${req.purpose} - ${req.status}",
              style: TextStyles.font12DarkBeigeRegular,
            ),
            onTap: () {
              context.pushNamed(Routes.customerRequestDetails, arguments: req);
            },
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text(
                      "Confirm Deletion",
                      style: TextStyles.font16BlueBold,
                    ),
                    content: Text(
                      "Are you sure you want to delete this request permanently?",
                      style: TextStyles.font14BlueRegular,
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop(false);
                        },
                        child: Text("Cancel", style: TextStyles.font14BlueBold),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop(true);
                        },
                        child: Text(
                          'Yes, Delete',
                          style: TextStyles.font14BlueBold.copyWith(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                );

                if (confirm == true) {
                  context.read<CustomerRequestCubit>().deleteRequest(req.id);
                }
              },
            ),
          ),
        );
      },
    );
  }
}
