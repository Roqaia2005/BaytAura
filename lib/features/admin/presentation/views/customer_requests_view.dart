import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/core/routing/routes.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:bayt_aura/core/helpers/extensions.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';
import 'package:bayt_aura/features/admin/logic/admin_cubit.dart';
import 'package:bayt_aura/features/admin/logic/admin_state.dart';

class CustomerRequestsView extends StatefulWidget {
  const CustomerRequestsView({super.key});

  @override
  State<CustomerRequestsView> createState() => _CustomerRequestsViewState();
}

class _CustomerRequestsViewState extends State<CustomerRequestsView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> tabs = ["ALL", "PENDING", "ACCEPTED", "REJECTED"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    context.read<AdminCubit>().getCustomerRequests();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Customer Requests", style: TextStyles.font17BlueBold),
        centerTitle: true,
        elevation: 2,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.blue,
          labelColor: AppColors.blue,
          unselectedLabelColor: Colors.grey,
          labelStyle: TextStyles.font14BlueBold, // أصغر شوية
          tabs: tabs
              .map(
                (t) => Tab(
                  child: Text(t, maxLines: 1, overflow: TextOverflow.ellipsis),
                ),
              )
              .toList(),
        ),
      ),
      body: BlocConsumer<AdminCubit, AdminState>(
        listener: (context, state) {
          if (state is RequestStatusChanged) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
            context.read<AdminCubit>().getCustomerRequests();
          }
          if (state is AdminError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("Error: ${state.message}")));
          }
        },
        builder: (context, state) {
          if (state is AdminLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is CustomerRequestsLoaded) {
            final allRequests = state.requests;

            return TabBarView(
              controller: _tabController,
              children: tabs.map((status) {
                var filtered = allRequests;
                if (status != "ALL") {
                  filtered = allRequests
                      .where((req) => req.status == status)
                      .toList();
                }

                if (filtered.isEmpty) {
                  return const Center(child: Text("No requests found"));
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final req = filtered[index];
                    return Card(
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          context.pushNamed(
                            Routes.customerRequestDetails,
                            arguments: req,
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.home,
                                color: AppColors.blue,
                                size: 32,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      req.title,
                                      style: TextStyles.font14BlueBold,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "${req.type} - ${req.purpose} - ${req.status}",
                                      style: TextStyles.font12DarkBeigeRegular,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "Customer: ${req.customerName}",
                                      style: TextStyles.font12DarkBeigeRegular,
                                    ),
                                  ],
                                ),
                              ),
                              _buildActions(context, req.id, req.status),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            );
          }
          return const Center(child: Text("Loading requests..."));
        },
      ),
    );
  }

  /// Actions for pending requests
  Widget _buildActions(BuildContext context, int? id, String? status) {
    if (status == "PENDING") {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            tooltip: "Accept",
            icon: const Icon(Icons.check_circle, color: Colors.green),
            onPressed: () {
              context.read<AdminCubit>().changeRequestStatus(
                id ?? 0,
                "ACCEPTED",
              );
            },
          ),
          IconButton(
            tooltip: "Reject",
            icon: const Icon(Icons.cancel, color: Colors.red),
            onPressed: () {
              context.read<AdminCubit>().changeRequestStatus(
                id ?? 0,
                "REJECTED",
              );
            },
          ),
        ],
      );
    }
    return const SizedBox();
  }
}
