import 'package:flutter/material.dart';
import 'package:bayt_aura/features/property/presentation/widgets/stat_item.dart';


class StatCard extends StatelessWidget {
  const StatCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              StatItem(title: "5.2k+", subtitle: "Properties"),
              StatItem(title: "98%", subtitle: "Satisfaction"),
              StatItem(title: "24/7", subtitle: "AI Support"),
            ],
          ),
        ),
      ),
    );
  }
}