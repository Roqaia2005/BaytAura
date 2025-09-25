import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/core/routing/routes.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:bayt_aura/core/helpers/extensions.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';
import 'package:bayt_aura/features/property/logic/property_state.dart';
import 'package:bayt_aura/features/property/logic/property_cubit.dart';
import 'package:bayt_aura/features/property/presentation/widgets/property_card.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text("My Favorites", style: TextStyles.font24WhiteBold),
        centerTitle: true,
        backgroundColor: AppColors.blue,
      ),

      body: BlocBuilder<PropertyCubit, PropertyState>(
        builder: (context, state) {
          final favorites = state is PropertyLoaded ? state.favorites : [];

          if (favorites.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.blue),
            );
          }

          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final favorite = favorites[index]; // Favorite object
              final property = favorite.property; // Extract the Property

              return PropertyCard(
                property: property,
                onViewDetails: () {
                  context.pushNamed(Routes.detailsScreen, arguments: property);
                },
              );
            },
          );
        },
      ),
    );
  }
}
