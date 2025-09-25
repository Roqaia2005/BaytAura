import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:bayt_aura/features/admin/logic/admin_cubit.dart';
import 'package:bayt_aura/features/admin/logic/admin_state.dart';

class ProviderRequestsView extends StatefulWidget {
  const ProviderRequestsView({super.key});

  @override
  State<ProviderRequestsView> createState() => _ProviderRequestsViewState();
}

class _ProviderRequestsViewState extends State<ProviderRequestsView> {
  @override
  void initState() {
    context.read<AdminCubit>().getProviderRequests();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Provider Requests"), centerTitle: true),
      body: BlocConsumer<AdminCubit, AdminState>(
        listener: (context, state) {
          if (state is ProviderApproved) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
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
          if (state is ProviderRequestsLoaded) {
            final providers = state.requests;

            if (providers.isEmpty) {
              return const Center(child: Text("No provider requests found"));
            }
            return ListView.builder(
              itemCount: providers.length,
              itemBuilder: (context, index) {
                final provider = providers[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: ListTile(
                    leading: const CircleAvatar(child: Icon(Icons.person)),
                    title: Text(provider.firstName ?? ""),
                    subtitle: Text(provider.email ?? ""),
                    trailing: (provider.status == "PENDING")
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  context.read<AdminCubit>().approveProvider(
                                    provider.id!,
                                    "ACCEPTED",
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  minimumSize: const Size(90, 36),
                                ),
                                child: const Text("Accept"),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: () {
                                  context.read<AdminCubit>().approveProvider(
                                    provider.id!,
                                    "REJECTED",
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  minimumSize: const Size(90, 36),
                                ),
                                child: const Text("Reject"),
                              ),
                            ],
                          )
                        : Text(
                            provider.status == "ACCEPTED"
                                ? "Accepted ✅"
                                : "Rejected ❌",
                          ),
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(color: AppColors.blue),
          );
        },
      ),
    );
  }
}
