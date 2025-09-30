import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/core/routing/routes.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:bayt_aura/core/helpers/extensions.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';
import 'package:bayt_aura/core/helpers/app_circular_indicator.dart';
import 'package:bayt_aura/features/customer/logic/customer_cubit.dart';
import 'package:bayt_aura/features/customer/logic/customer_state.dart';

class MyRequestsView extends StatefulWidget {
  const MyRequestsView({super.key});

  @override
  State<MyRequestsView> createState() => _MyRequestsViewState();
}

class _MyRequestsViewState extends State<MyRequestsView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> tabs = ["All", "Pending", "Accepted", "Rejected"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    context.read<CustomerRequestCubit>().getMyRequests();
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
        backgroundColor: AppColors.blue,
        title: Text("My Requests", style: TextStyles.font24WhiteBold),
        centerTitle: true,
        elevation: 2,
        bottom: TabBar(
          controller: _tabController,
          labelStyle: TextStyles.font16WhiteBold,
          indicatorColor: AppColors.beige,
          labelColor: AppColors.beige,
          unselectedLabelColor: Colors.grey,
          tabs: tabs.map((t) => Tab(text: t)).toList(),
        ),
      ),
      body: BlocBuilder<CustomerRequestCubit, CustomerRequestState>(
        builder: (context, state) {
          if (state is CustomerRequestLoading) {
            return const Center(child: AppCircularIndicator());
          }
          if (state is CustomerRequestsLoaded) {
            final allRequests = state.requests;

            return TabBarView(
              controller: _tabController,
              children: tabs.map((status) {
                var filtered = allRequests;
                if (status != "ALL") {
                  filtered = allRequests
                      .where((r) => r.status == status)
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
                                  ],
                                ),
                              ),
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
}
