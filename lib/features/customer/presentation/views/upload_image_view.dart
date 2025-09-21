import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bayt_aura/features/property/logic/media_cubit.dart';
import 'package:bayt_aura/features/property/logic/media_states.dart';


class UploadPropertyImagesView extends StatelessWidget {
  final int propertyId;
  const UploadPropertyImagesView({super.key, required this.propertyId});

  @override
  Widget build(BuildContext context) {
    final ImagePicker picker = ImagePicker();

    Future<void> pickImages() async {
      final picked = await picker.pickMultiImage(imageQuality: 80);
      if (picked != null && picked.isNotEmpty) {
        for (final img in picked) {
          await context.read<MediaCubit>().addMedia(propertyId, File(img.path));
        }
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Upload Property Images")),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: pickImages,
            child: const Text("Pick Images"),
          ),
          BlocBuilder<MediaCubit, MediaState>(
            builder: (context, state) {
              return state.when(
                initial: () => const Text("No images uploaded"),
                loading: () => const CircularProgressIndicator(),
                loaded: (media) => Wrap(
                  children: media.map((img) => Image.network(img.url ?? "", width: 80, height: 80)).toList(),
                ),
                uploaded: (uploaded) => Text("Uploaded: ${uploaded.altName}"),
                error: (msg) => Text("Error: $msg"),
              );
            },
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // or go to home
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Request completed successfully")),
              );
            },
            child: const Text("Complete Request"),
          )
        ],
      ),
    );
  }
}
