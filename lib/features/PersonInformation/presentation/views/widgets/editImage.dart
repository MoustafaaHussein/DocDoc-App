import 'dart:io';
import 'package:docdoc_app/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:image_picker/image_picker.dart';

class EditableProfileImage extends StatefulWidget {
  final String? imageUrl; // من SharedPreferences

  const EditableProfileImage({super.key, this.imageUrl});

  @override
  State<EditableProfileImage> createState() => _EditableProfileImageState();
}

class _EditableProfileImageState extends State<EditableProfileImage> {
  File? _imageFile;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });

      // لو حابب تحفظ الصورة الجديدة في SharedPreferences، بلغني أضيفهالك.
    }
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider imageProvider;

    if (_imageFile != null) {
      imageProvider = FileImage(_imageFile!);
    } else if (widget.imageUrl != null && widget.imageUrl!.isNotEmpty) {
      imageProvider = NetworkImage(widget.imageUrl!);
    } else {
      imageProvider = const AssetImage('assets/images/DemoImage.png');
    }

    return Stack(
      children: [
        CircleAvatar(
          radius: 60,
          backgroundColor: Colors.grey.shade300,
          backgroundImage: imageProvider,
        ),
        Positioned(
          bottom: 0,
          right: 4,
          child: GestureDetector(
            onTap: _pickImage,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color.fromARGB(255, 247, 247, 247),
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: const Icon(
                IconlyLight.edit,
                size: 20,
                color: AppColors.kButtonPrimaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
