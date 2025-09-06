import 'package:flutter/material.dart';
import 'package:bayt_aura/core/routing/routes.dart';
import 'package:bayt_aura/core/helpers/extensions.dart';
import 'package:bayt_aura/core/widgets/app_button.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bayt_aura/features/home/data/models/property.dart';

class PropertyDetailsView extends StatefulWidget {
  const PropertyDetailsView({super.key, required this.property});
  final Property property;

  @override
  State<PropertyDetailsView> createState() => _PropertyDetailsViewState();
}

class _PropertyDetailsViewState extends State<PropertyDetailsView> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.grey,
            ),
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    isFavorite
                        ? "Added to Favorites"
                        : "Removed from Favorites",
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                "https://media.istockphoto.com/id/1150278000/photo/modern-white-house-with-swimming-pool.jpg?s=612x612&w=0&k=20&c=5uBhkdER9uGSXKOt_AZjxOXAYjnhxj6b8JCW1UWv2WA=",
                width: double.infinity,
                height: 220,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 16),

            // Title & Rating
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.property.name, style: TextStyles.font20BlueBold),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 20),
                      Text(
                        widget.property.rate,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Location
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.grey, size: 18),
                  const SizedBox(width: 4),
                  Text(
                    widget.property.location,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Price
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                widget.property.price,
                style: TextStyles.font16BlueBold,
              ),
            ),

            const SizedBox(height: 20),

            // Description
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Property Description",
                style: TextStyles.font16BlueBold,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                widget.property.description,
                style: TextStyles.font14BlueRegular,
              ),
            ),

            const SizedBox(height: 30),

            // Button
            Center(
              child: AppTextButton(
                // borderRadius: 8,
                verticalPadding: 4.h,
                buttonWidth: 120.w,
                buttonHeight: 30.h,
                backgroundColor: Colors.white,

                buttonText: "Contact Agent",
                textStyle: TextStyles.font16BlueBold,
                onPressed: () {
                  context.pushNamed(Routes.detailsScreen);
                },
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
