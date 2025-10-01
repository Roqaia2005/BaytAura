import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/core/routing/routes.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:bayt_aura/core/helpers/spacing.dart';
import 'package:bayt_aura/core/helpers/extensions.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';
import 'package:bayt_aura/features/admin/logic/admin_cubit.dart';
import 'package:bayt_aura/features/admin/logic/admin_state.dart';
import 'package:bayt_aura/core/widgets/app_circular_indicator.dart';

class CustomerRequestsView extends StatefulWidget {
  const CustomerRequestsView({super.key});

  @override
  State<CustomerRequestsView> createState() => _CustomerRequestsViewState();
}

class _CustomerRequestsViewState extends State<CustomerRequestsView> {
  @override
  void initState() {
    super.initState();
    context.read<AdminCubit>().getCustomerRequests();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AppBar(
          backgroundColor: AppColors.blue,
          elevation: 0,
          centerTitle: true,
          title: Text("Customer Requests", style: TextStyles.font24WhiteBold),
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
        body: BlocConsumer<AdminCubit, AdminState>(
          listener: (context, state) {
            if (state is RequestStatusChanged) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.green,
                ),
              );
              context.read<AdminCubit>().getCustomerRequests();
            }
            if (state is AdminError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Error: ${state.message}"),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is AdminLoading) {
              return const Center(child: AppCircularIndicator());
            }

            if (state is CustomerRequestsLoaded) {
              final requests = state.requests;

              if (requests.isEmpty) {
                return Center(
                  child: Text(
                    "No customer requests found",
                    style: TextStyles.font16DarkBeigeRegular,
                  ),
                );
              }

              return TabBarView(
                children: [
                  _buildList(requests), // All
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
      return Center(
        child: Text("No requests", style: TextStyles.font16DarkBeigeRegular),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: requests.length,
      itemBuilder: (context, index) {
        final req = requests[index];

        return InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            context.pushNamed(Routes.customerRequestDetails, arguments: req);
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 3,
            color: Colors.white,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, top: 16),
                    child: Row(
                      children: [
                        const Icon(Icons.home, color: AppColors.blue, size: 36),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                req.title ?? "",
                                style: TextStyles.font16BlueBold,
                              ),
                              verticalSpace(6),
                              Text(
                                "${req.type} - ${req.purpose}",
                                style: TextStyles.font14DarkBeigeBold,
                              ),
                              verticalSpace(6),
                              Text(
                                "Customer: ${req.customerName ?? ""}",
                                style: TextStyles.font14DarkBeigeBold,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  verticalSpace(12),

                  req.status == "PENDING"
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _actionButton(
                              text: "Accept",
                              color: Colors.green,
                              onPressed: () {
                                context.read<AdminCubit>().changeRequestStatus(
                                  req.id!,
                                  "ACCEPTED",
                                );
                              },
                            ),
                            const SizedBox(width: 8),
                            _actionButton(
                              text: "Reject",
                              color: Colors.red,
                              onPressed: () {
                                context.read<AdminCubit>().changeRequestStatus(
                                  req.id!,
                                  "REJECTED",
                                );
                              },
                            ),
                          ],
                        )
                      : Text(
                          req.status == "ACCEPTED"
                              ? "Accepted ✅"
                              : "Rejected ❌",
                          style: TextStyles.font14BlueBold,
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _actionButton({
    required String text,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        minimumSize: const Size(90, 40),
        elevation: 2,
      ),
      onPressed: onPressed,
      child: Text(text, style: TextStyles.font14WhiteBold),
    );
  }
}
