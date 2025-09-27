import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';
import 'package:bayt_aura/core/helpers/app_circular_indicator.dart';
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

  @override
  void dispose() {
    _usernameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: Text("Edit Profile", style: TextStyles.font16WhiteBold),
        centerTitle: true,
        backgroundColor: AppColors.blue,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          state.maybeWhen(
            loaded: (_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Profile updated successfully")),
              );
              Navigator.pop(context);
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
            loaded: (profile) {
              // prefill controllers when profile is loaded
              _usernameController.text = profile.username;
              _firstNameController.text = profile.firstName;
              _lastNameController.text = profile.lastName;
              _phoneController.text = profile.phone;

              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      const SizedBox(height: 20),
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
                            final updated = Profile(
                              username: _usernameController.text,
                              firstName: _firstNameController.text,
                              lastName: _lastNameController.text,
                              phone: _phoneController.text,
                              email: profile.email, // keep old email
                              role: profile.role, // keep old role
                              profilePictureUrl: profile.profilePictureUrl,
                            );
                            context.read<ProfileCubit>().updateProfile(updated);
                          }
                        },
                        child: state.maybeWhen(
                          loading: () =>  AppCircularIndicator(),
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
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            orElse: () => const Center(child: Text("Something went wrong")),
          );
        },
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
