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
    // استدعاء API عند فتح الشاشة
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Edit Profile", style: TextStyles.font16WhiteBold),
        centerTitle: true,
        backgroundColor: AppColors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          state.maybeWhen(
            loaded: (profile) {
              _fillControllers(profile);
            },
            updateSuccess: (profile) {
              _fillControllers(profile);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Profile updated successfully")),
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
      _buildTextField(
        controller: _usernameController,
        label: "Username",
        icon: Icons.person,
      ),
      _buildTextField(
        controller: _firstNameController,
        label: "First Name",
        icon: Icons.badge,
      ),
      _buildTextField(
        controller: _lastNameController,
        label: "Last Name",
        icon: Icons.badge_outlined,
      ),
      _buildTextField(
        controller: _phoneController,
        label: "Phone",
        icon: Icons.phone,
        keyboard: TextInputType.phone,
      ),
    ];

    if (profile.role.toLowerCase() == 'provider') {
      fields.addAll([
        _buildTextField(
          controller: _companyNameController,
          label: "Company Name",
          icon: Icons.business,
        ),
        _buildTextField(
          controller: _companyAddressController,
          label: "Company Address",
          icon: Icons.location_on,
        ),
      ]);
    }

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            const SizedBox(height: 20),
            ...fields,
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: AppColors.blue,
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
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboard = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboard,
        validator: (value) =>
            value == null || value.isEmpty ? "Please enter $label" : null,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: Colors.grey.shade100,
        ),
      ),
    );
  }
}
