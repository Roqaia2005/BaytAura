import 'package:flutter/material.dart';
import '../logic/recommendation_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';
import 'package:bayt_aura/core/widgets/app_circular_indicator.dart';

class RecommendationsScreen extends StatefulWidget {
  final int entityId; // Could be propertyId or userId
  final String mode; // "location", "price", "user"

  const RecommendationsScreen({
    super.key,
    required this.entityId,
    required this.mode,
  });

  @override
  State<RecommendationsScreen> createState() => _RecommendationsScreenState();
}

class _RecommendationsScreenState extends State<RecommendationsScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch recommendations automatically when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchRecommendations();
    });
  }

  void fetchRecommendations() {
    final cubit = context.read<RecommendationCubit>();
    switch (widget.mode) {
      case "location":
        cubit.fetchLocationBased(widget.entityId);
        break;
      case "price":
        cubit.fetchPriceBased(widget.entityId);
        break;
      case "user":
        cubit.fetchUserBased(widget.entityId);
        break;
      default:
        // Optional: show an error or fallback
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AppColors.blue,
        title: Text(
          "Recommended Properties",
          style: TextStyles.font20WhiteBold,
        ),
      ),
      body: BlocBuilder<RecommendationCubit, RecommendationState>(
        builder: (context, state) {
          if (state is RecommendationLoading) {
            return const Center(child: AppCircularIndicator());
          } else if (state is RecommendationLoaded) {
            if (state.properties.isEmpty) {
              return const Center(
                child: Text("No recommended properties found"),
              );
            }
            return GridView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: state.properties.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                final prop = state.properties[index];
                final imageUrl =
                    (prop.images?.isNotEmpty == true &&
                        prop.images!.first.url != null)
                    ? prop.images!.first.url!
                    : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3i7u-qKtMbAXynJmBf8ag-QB2voTrNt490A&s";

                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            errorBuilder: (_, __, ___) =>
                                const Icon(Icons.home, size: 80),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              prop.title ?? "No Title",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "${prop.price?.toStringAsFixed(0) ?? 'N/A'} EGP",
                              style: const TextStyle(
                                color: AppColors.blue,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              prop.address ?? "No Address",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is RecommendationError) {
            return Center(child: Text("Error: ${state.message}"));
          }
          return const Center(child: Text("Choose a recommendation type"));
        },
      ),
      floatingActionButton: _buildFABs(),
    );
  }

  Widget _buildFABs() {
    final cubit = context.read<RecommendationCubit>();
    List<Widget> buttons = [];

    if (widget.mode == "location" || widget.mode == "all") {
      buttons.add(
        FloatingActionButton.extended(
          backgroundColor: AppColors.beige,
          heroTag: "loc",
          onPressed: () => cubit.fetchLocationBased(widget.entityId),
          label: Text("Location", style: TextStyles.font14BlueRegular),
          icon: Icon(Icons.location_on, color: AppColors.blue),
        ),
      );
    }
    if (widget.mode == "price" || widget.mode == "all") {
      buttons.add(const SizedBox(height: 10));
      buttons.add(
        FloatingActionButton.extended(
          backgroundColor: AppColors.beige,

          heroTag: "price",
          onPressed: () => cubit.fetchPriceBased(widget.entityId),
          label: Text("Price", style: TextStyles.font14BlueRegular),
          icon: const Icon(Icons.price_change, color: AppColors.blue),
        ),
      );
    }
    if (widget.mode == "user" || widget.mode == "all") {
      buttons.add(const SizedBox(height: 10));
      buttons.add(
        FloatingActionButton.extended(
          backgroundColor: AppColors.beige,
          heroTag: "user",
          onPressed: () => cubit.fetchUserBased(widget.entityId),
          label: Text("User", style: TextStyles.font14BlueRegular),
          icon: const Icon(Icons.person, color: AppColors.blue),
        ),
      );
    }

    return Column(mainAxisAlignment: MainAxisAlignment.end, children: buttons);
  }
}
