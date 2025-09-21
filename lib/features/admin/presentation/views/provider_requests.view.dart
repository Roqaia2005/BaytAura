// import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:bayt_aura/features/admin/logic/admin_cubit.dart';
// import 'package:bayt_aura/features/admin/logic/admin_state.dart';
// import 'package:bayt_aura/features/admin/logic/request_state.dart';

// class ProviderRequestsView extends StatelessWidget {
//   const ProviderRequestsView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Provider Requests"), centerTitle: true),
//       body: BlocConsumer<AdminCubit, RequestState>(
//         listener: (context, state) {
//           if (state is ApproveProviderSuccess) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(content: Text("Provider approved ✅")),
//             );
//           }
//           if (state is ApproveProviderError) {
//             ScaffoldMessenger.of(
//               context,
//             ).showSnackBar(SnackBar(content: Text("Error: ${state.message}")));
//           }
//         },
//         builder: (context, state) {
//           if (state is GetProvidersLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (state is GetProvidersError) {
//             return Center(child: Text("Error: ${state.message}"));
//           }
//           if (state is GetProvidersSuccess) {
//             final providers = state.providers;

//             if (providers.isEmpty) {
//               return const Center(child: Text("No providers found"));
//             }

//             return ListView.builder(
//               itemCount: providers.length,
//               itemBuilder: (context, index) {
//                 final provider = providers[index];
//                 return Card(
//                   margin: const EdgeInsets.symmetric(
//                     horizontal: 12,
//                     vertical: 6,
//                   ),
//                   child: ListTile(
//                     leading: const CircleAvatar(child: Icon(Icons.person)),
//                     title: Text(provider.name ?? ""),
//                     subtitle: Text(provider.email ?? ""),
//                     trailing: ElevatedButton(
//                       onPressed: () {
//                         context.read<AdminCubit>().approveProvider(provider.id);
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.green,
//                         minimumSize: const Size(90, 36),
//                       ),
//                       child: const Text("Approve"),
//                     ),
//                   ),
//                 );
//               },
//             );
//           }
//           return const Center(child: Text("Press refresh to load providers"));
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           context.read<AdminCubit>().getProviders();
//         },
//         child: const Icon(Icons.refresh),
//       ),
//     );
//   }
// }


// //should have endpoint return providers , display them and call approve provider method (^_^)