import 'package:flutter/material.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bayt_aura/features/profile/data/models/profile.dart';

class ProfileDetails extends StatelessWidget {
  const ProfileDetails({super.key, required this.profile});

  final Profile profile; // or your Profile model type

  @override
  Widget build(BuildContext context) {
    final List<Widget> fields = [
      InfoRow(label: "First Name", value: profile.firstName),
      InfoRow(label: "Last Name", value: profile.lastName),
      InfoRow(label: "Email", value: profile.email),
      InfoRow(label: "Phone", value: profile.phone),
      InfoRow(label: "Username", value: profile.username),
    ];

    if (profile.role.toLowerCase() == "provider") {
      fields.addAll([
        InfoRow(label: "Company Name", value: profile.companyName ?? "-"),
        InfoRow(label: "Company Address", value: profile.companyAddress ?? "-"),
      ]);
    }

    if (profile.role.toLowerCase() == "admin") {
      // Admin sees customer info
      // Could show same as customer or add extra if needed
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 10,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: fields,
        ),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  const InfoRow({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text("$label: ", style: TextStyles.font14BlueBold),
          Expanded(child: Text(value, style: TextStyles.font14BlueRegular)),
        ],
      ),
    );
  }
}
