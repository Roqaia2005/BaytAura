import 'dart:io';
import 'package:flutter/material.dart';
import 'package:bayt_aura/features/property/data/models/property.dart';

class PropertyImagesSection extends StatelessWidget {
  final List<File> newImages;
  final List<Images>? oldImages; // for edit only
  final VoidCallback onPickImages;
  final void Function(int index)? onRemoveNew;
  final void Function(int imageId)? onRemoveOld;

  const PropertyImagesSection({
    super.key,
    required this.newImages,
    required this.onPickImages,
    this.oldImages,
    this.onRemoveNew,
    this.onRemoveOld,
  });

  @override
  Widget build(BuildContext context) {
    final allItemsCount = newImages.length + (oldImages?.length ?? 0) + 1;

    return SizedBox(
      height: 110,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: allItemsCount,
        itemBuilder: (context, index) {
          // Add button
          if (index == allItemsCount - 1) {
            return GestureDetector(
              onTap: onPickImages,
              child: Container(
                width: 100,
                margin: const EdgeInsets.symmetric(horizontal: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[300],
                ),
                child: const Icon(Icons.add_a_photo, size: 40),
              ),
            );
          }

          // Old images (for edit)
          if (oldImages != null && index < oldImages!.length) {
            final img = oldImages![index];
            return Stack(
              children: [
                Container(
                  width: 100,
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(img.url ?? ""),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                if (onRemoveOld != null)
                  Positioned(
                    top: 4,
                    right: 4,
                    child: GestureDetector(
                      onTap: () => onRemoveOld!(img.id!),
                      child: _removeIcon(),
                    ),
                  ),
              ],
            );
          }

          // New images (from picker)
          final newIndex = index - (oldImages?.length ?? 0);
          return Stack(
            children: [
              Container(
                width: 100,
                margin: const EdgeInsets.symmetric(horizontal: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: FileImage(newImages[newIndex]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              if (onRemoveNew != null)
                Positioned(
                  top: 4,
                  right: 4,
                  child: GestureDetector(
                    onTap: () => onRemoveNew!(newIndex),
                    child: _removeIcon(),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _removeIcon() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black54,
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.close, size: 18, color: Colors.white),
    );
  }
}



