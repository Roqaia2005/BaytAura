import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';
import 'package:bayt_aura/features/admin/logic/admin_cubit.dart';
import 'package:bayt_aura/features/admin/logic/request_state.dart';

class AllRequestsView extends StatelessWidget {
  const AllRequestsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Requests", style: TextStyles.font17BlueBold),
      ),
      body: BlocBuilder<AdminCubit, RequestState>(
        builder: (context, state) {
          if (state is RequestLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RequestLoaded) {
            final requests = state.requests;
            return ListView.builder(
              itemCount: requests.length,
              itemBuilder: (context, index) {
                final req = requests[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(req.title ?? ""),
                    subtitle: Text(
                      "${req.type} - ${req.purpose} - ${req.status}\nCustomer: ${req.customerName}",
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (req.status == "PENDING") ...[
                          IconButton(
                            icon: const Icon(Icons.check, color: Colors.green),
                            onPressed: () {
                              context.read<AdminCubit>().changeRequestStatus(
                                req.id ?? 0,
                                "ACCEPTED",
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, color: Colors.red),
                            onPressed: () {
                              context.read<AdminCubit>().changeRequestStatus(
                                req.id ?? 0,
                                "REJECTED",
                              );
                            },
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is RequestError) {
            return Center(child: Text("Error: ${state.message}"));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
