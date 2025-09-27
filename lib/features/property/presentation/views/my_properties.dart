import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:bayt_aura/core/routing/routes.dart';
import 'package:bayt_aura/core/helpers/extensions.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bayt_aura/core/helpers/app_circular_indicator.dart';
import 'package:bayt_aura/features/property/data/models/property.dart';
import 'package:bayt_aura/features/property/logic/property_cubit.dart';
import 'package:bayt_aura/features/property/logic/property_state.dart';
import 'package:bayt_aura/features/property/presentation/widgets/my_property_card.dart';

class MyPropertiesView extends StatefulWidget {
  const MyPropertiesView({super.key});

  @override
  State<MyPropertiesView> createState() => _MyPropertiesViewState();
}

class _MyPropertiesViewState extends State<MyPropertiesView> {
  @override
  void initState() {
    super.initState();
    context.read<PropertyCubit>().fetchMyProperties();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        centerTitle: true,

        backgroundColor: AppColors.blue,
        title: Text("My Properties", style: TextStyles.font24WhiteBold),
      ),
      body: BlocConsumer<PropertyCubit, PropertyState>(
        listener: (context, state) {
          if (state is PropertyUpdated) {
            context.read<PropertyCubit>().fetchMyProperties();

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Property updated successfully")),
            );
          }
          if (state is PropertyDeleted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Property deleted successfully")),
            );
          }
        },
        builder: (context, state) {
          if (state is PropertyLoading) {
            return const Center(child: AppCircularIndicator());
          }

          if (state is MyPropertyLoaded) {
            final properties = state.myProperties;

            if (properties.isEmpty) {
              return Center(
                child: Text(
                  "No properties found.",
                  style: TextStyles.font16BlueBold,
                ),
              );
            }

            return ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemCount: properties.length,
              itemBuilder: (context, index) {
                final property = properties[index];
                return MyPropertyCard(
                  key: ValueKey(property.id),
                  property: property,
                  onViewDetails: () => context.pushNamed(
                    Routes.detailsScreen,
                    arguments: property,
                  ),

                  onEdit: () async {
                    final result = await Navigator.of(
                      context,
                    ).pushNamed(Routes.editProperty, arguments: property);

                    if (result is Property) {
                      await context.read<PropertyCubit>().fetchMyProperties();
                    }
                  },

                  onDelete: () => context
                      .read<PropertyCubit>()
                      .deleteMyProperty(property.id!),
                );
              },
            );
          }

          if (state is PropertyError) {
            return Center(child: Text(state.message));
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
