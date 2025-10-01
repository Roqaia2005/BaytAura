import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:bayt_aura/core/helpers/spacing.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';
import 'package:bayt_aura/features/admin/logic/admin_cubit.dart';
import 'package:bayt_aura/features/admin/logic/admin_state.dart';
import 'package:bayt_aura/core/widgets/app_circular_indicator.dart';

class ProviderRequestsView extends StatefulWidget {
  const ProviderRequestsView({super.key});

  @override
  State<ProviderRequestsView> createState() => _ProviderRequestsViewState();
}

class _ProviderRequestsViewState extends State<ProviderRequestsView> {
  @override
  void initState() {
    super.initState();
    context.read<AdminCubit>().getProviderRequests();
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
          title: Text("Provider Requests", style: TextStyles.font24WhiteBold),
          bottom: TabBar(
            labelStyle: TextStyles.font16WhiteBold,
            indicatorColor: AppColors.beige,
            labelColor: AppColors.beige,
            unselectedLabelColor: Colors.grey,

            tabs: [
              Tab(text: "All"),
              Tab(text: "Pending"),
              Tab(text: "Accepted"),
              Tab(text: "Rejected"),
            ],
          ),
        ),
        body: BlocConsumer<AdminCubit, AdminState>(
          listener: (context, state) {
            if (state is ProviderApproved) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.green,
                ),
              );
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

            if (state is ProviderRequestsLoaded) {
              final providers = state.requests;

              if (providers.isEmpty) {
                return Center(
                  child: Text(
                    "No provider requests found",
                    style: TextStyles.font16DarkBeigeRegular,
                  ),
                );
              }

              return TabBarView(
                children: [
                  _buildList(providers), // All
                  _buildList(
                    providers.where((p) => p.status == "PENDING").toList(),
                  ),
                  _buildList(
                    providers.where((p) => p.status == "ACCEPTED").toList(),
                  ),
                  _buildList(
                    providers.where((p) => p.status == "REJECTED").toList(),
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

  Widget _buildList(List providers) {
    if (providers.isEmpty) {
      return Center(
        child: Text("No requests", style: TextStyles.font16DarkBeigeRegular),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: providers.length,
      itemBuilder: (context, index) {
        final provider = providers[index];

        return Card(
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
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: AppColors.beige,
                        child: Icon(
                          Icons.person,
                          color: AppColors.blue,
                          size: 28,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  provider.firstName ?? "",
                  style: TextStyles.font16BlueBold,
                ),
                verticalSpace(10),
                Text(
                  provider.email ?? "",
                  style: TextStyles.font14DarkBeigeBold,
                ),
                verticalSpace(10),

                provider.status == "PENDING"
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _actionButton(
                            text: "Accept",
                            color: Colors.green,
                            onPressed: () {
                              context.read<AdminCubit>().approveProvider(
                                provider.id!,
                                "ACCEPTED",
                              );
                            },
                          ),
                          const SizedBox(width: 8),
                          _actionButton(
                            text: "Reject",
                            color: Colors.red,
                            onPressed: () {
                              context.read<AdminCubit>().approveProvider(
                                provider.id!,
                                "REJECTED",
                              );
                            },
                          ),
                        ],
                      )
                    : Text(
                        provider.status == "ACCEPTED"
                            ? "Accepted ✅"
                            : "Rejected ❌",
                        style: TextStyles.font14BlueBold,
                      ),
              ],
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
