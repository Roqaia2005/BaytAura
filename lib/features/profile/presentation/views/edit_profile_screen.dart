import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      appBar: AppBar(title: const Text("Edit Profile")),
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
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(labelText: "Username"),
                  ),
                  TextFormField(
                    controller: _firstNameController,
                    decoration: const InputDecoration(labelText: "First Name"),
                  ),
                  TextFormField(
                    controller: _lastNameController,
                    decoration: const InputDecoration(labelText: "Last Name"),
                  ),
                  TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(labelText: "Phone"),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      onPressed:
                      () {
                        final updated = Profile(
                          username: _usernameController.text,
                          firstName: _firstNameController.text,
                          lastName: _lastNameController.text,
                          phone: _phoneController.text,
                          email: "", // keep email unchanged or prefill
                          role: "", // keep role unchanged
                          profilePictureUrl: null, // keep as is
                        );
                        context.read<ProfileCubit>().updateProfile(updated);
                      };
                    },
                    child: state.maybeWhen(
                      loading: () => const CircularProgressIndicator(),
                      orElse: () =>
                          Text("Failed to save changes, Try again later"),
                     
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
