import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:bayt_aura/core/helpers/extensions.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';
import 'package:bayt_aura/core/widgets/app_circular_indicator.dart';
import 'package:bayt_aura/features/profile/data/models/profile.dart';
import 'package:bayt_aura/features/profile/logic/profile.state.dart';
import 'package:bayt_aura/features/profile/logic/profile_cubit.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _companyNameController = TextEditingController();
  final _companyAddressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().loadProfile();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _companyNameController.dispose();
    _companyAddressController.dispose();
    super.dispose();
  }

  void _fillControllers(Profile profile) {
    _usernameController.text = profile.username;
    _firstNameController.text = profile.firstName;
    _lastNameController.text = profile.lastName;
    _phoneController.text = profile.phone;
    _companyNameController.text = profile.companyName ?? '';
    _companyAddressController.text = profile.companyAddress ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.blue,
        title: Text("Edit Profile", style: TextStyles.font16WhiteBold),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          state.maybeWhen(
            loaded: (profile) => _fillControllers(profile),
            updateSuccess: (profile) {
              _fillControllers(profile);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Profile updated successfully"),
                  backgroundColor: Colors.green,
                ),
              );
              context.pop();
            },
            error: (message) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(message)));
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => const Center(child: AppCircularIndicator()),
            loaded: (profile) => _buildForm(profile, state),
            updateSuccess: (profile) => _buildForm(profile, state),
            error: (message) => Center(child: Text(message)),
            orElse: () => const SizedBox(),
          );
        },
      ),
    );
  }

  Widget _buildForm(Profile profile, ProfileState state) {
    List<Widget> fields = [
      _buildCardField(
        controller: _usernameController,
        label: "Username",
        icon: Icons.person,
      ),
      _buildCardField(
        controller: _firstNameController,
        label: "First Name",
        icon: Icons.badge,
      ),
      _buildCardField(
        controller: _lastNameController,
        label: "Last Name",
        icon: Icons.badge_outlined,
      ),
      _buildCardField(
        controller: _phoneController,
        label: "Phone",
        icon: Icons.phone,
        keyboard: TextInputType.phone,
      ),
    ];

    if (profile.role.toLowerCase() == 'provider') {
      fields.addAll([
        const SizedBox(height: 16),
        Text("Company Info", style: TextStyles.font18DarkBeigeBold),
        const SizedBox(height: 8),
        _buildCardField(
          controller: _companyNameController,
          label: "Company Name",
          icon: Icons.business,
        ),
        _buildCardField(
          controller: _companyAddressController,
          label: "Company Address",
          icon: Icons.location_on,
        ),
      ]);
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 10),

            // Profile Avatar
            CircleAvatar(
              radius: 50,
              backgroundColor: AppColors.beige.withOpacity(0.2),
              backgroundImage: profile.profilePictureUrl != null
                  ? NetworkImage(profile.profilePictureUrl!)
                  : null,
              child: profile.profilePictureUrl == null
                  ? const Icon(Icons.person, size: 50, color: Colors.grey)
                  : null,
            ),
            const SizedBox(height: 20),

            // Form fields
            ...fields,

            const SizedBox(height: 30),

            // Save button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  backgroundColor: AppColors.blue,
                  elevation: 4,
                  shadowColor: AppColors.blue.withOpacity(0.3),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final updatedProfile = Profile(
                      username: _usernameController.text,
                      firstName: _firstNameController.text,
                      lastName: _lastNameController.text,
                      phone: _phoneController.text,
                      email: profile.email,
                      role: profile.role,
                      profilePictureUrl: profile.profilePictureUrl,
                      companyName: profile.role.toLowerCase() == 'provider'
                          ? _companyNameController.text
                          : null,
                      companyAddress: profile.role.toLowerCase() == 'provider'
                          ? _companyAddressController.text
                          : null,
                    );
                    context.read<ProfileCubit>().updateProfile(updatedProfile);
                  }
                },
                child: state.maybeWhen(
                  loading: () => const AppCircularIndicator(),
                  orElse: () => const Text(
                    "Save Changes",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboard = TextInputType.text,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboard,
        validator: (value) =>
            value == null || value.isEmpty ? "Please enter $label" : null,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyles.font14BlueRegular,
          prefixIcon: Icon(icon, color: AppColors.blue),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey.shade50,
        ),
      ),
    );
  }
}
