import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/core/routing/routes.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:bayt_aura/core/helpers/extensions.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';
import 'package:bayt_aura/features/home/logic/property_cubit.dart';
import 'package:bayt_aura/features/home/presentation/views/widgets/property_card.dart';

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
            return const Center(child: Text("No favorites yet."));
          }

          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              return PropertyCard(
                property: favorites[index],
                onViewDetails: () {
                  context.pushNamed(
                    Routes.detailsScreen,
                    arguments: favorites[index],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
