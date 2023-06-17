import 'dart:io';
import 'package:eatery_services/eatery_services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uicons/uicons.dart';
import '../containers/image.container.dart';
import '../others/bottom_sheet.grip.dart';
import '../titles/page.title.dart';
import 'package:path/path.dart' as path;

class ImageLibraryBottomSheet extends StatefulWidget {
  final BuildContext context;
  final Function(String? path) action;

  const ImageLibraryBottomSheet(this.context, this.action, {Key? key})
      : super(key: key);

  @override
  State<ImageLibraryBottomSheet> createState() =>
      _ImageLibraryBottomSheetState();
}

class _ImageLibraryBottomSheetState extends State<ImageLibraryBottomSheet> {
  @override
  void initState() {
    super.initState();
    loadImages();
  }

  Future pickFromFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );

    if (result != null) {
      FileServices.copy(
              target: result.files.single.path!,
              directory: await FileServices.libraryPath())
          .then((value) {
        if (value != null) {
          widget.action(path.relative(value.path));
          Navigator.pop(context);
        }
      });
    }
  }

  Future pickFromGallery() async {
    final ImagePicker picker = ImagePicker();
    XFile? xFile = await picker.pickImage(source: ImageSource.gallery);
    if (xFile != null) {
      FileServices.copy(
              target: xFile.path, directory: await FileServices.libraryPath())
          .then((value) {
        if (value != null) {
          widget.action(path.relative(value.path));
        }
        Navigator.of(context).pop();
      });
    }
  }

  Future pickFromCamera() async {
    final ImagePicker picker = ImagePicker();
    XFile? xFile = await picker.pickImage(source: ImageSource.camera);
    if (xFile != null) {
      FileServices.copy(
              target: xFile.path, directory: await FileServices.libraryPath())
          .then((value) {
        if (value != null) {
          widget.action(path.relative(value.path));
        }
        Navigator.of(context).pop();
      });
    }
  }

  final List<String> _existingImages = [];

  Future loadImages() async {
    _existingImages.clear();
    for (var each in await FileServices.getImages()) {
      _existingImages.add(each);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            const Center(
              child: BottomSheetGrip(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                const PageTitle(
                  title: "Library",
                  subtitle: "Previously imported images",
                ),
                Row(
                  children: [
                    if (Platform.isAndroid)
                      IconButton(
                        icon: Icon(UIcons.regularStraight.camera),
                        iconSize: 24,
                        color: const Color(0xFF888888),
                        onPressed: pickFromCamera,
                      ),
                    if (Platform.isAndroid)
                      IconButton(
                        icon: Icon(UIcons.regularStraight.gallery),
                        iconSize: 24,
                        color: const Color(0xFF888888),
                        onPressed: pickFromGallery,
                      ),
                    if (Platform.isIOS)
                      IconButton(
                        icon: Icon(UIcons.regularStraight.upload),
                        iconSize: 24,
                        color: const Color(0xFF888888),
                        onPressed: pickFromFile,
                      ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 6.0,
            ),
            const Divider(
              thickness: 0.5,
              color: Color(0xFFB2B2B2),
            ),
            if (_existingImages.isEmpty)
              const Expanded(
                  child: Center(
                child: Text('Empty'),
              )),
            if (_existingImages.isNotEmpty)
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Wrap(
                    spacing: 12.0,
                    runSpacing: 12.0,
                    children: [
                      for (var each in _existingImages)
                        if (File(each).existsSync())
                          ImageContainer(
                              screenWidth: MediaQuery.of(context).size.width,
                              onTap: () {
                                widget.action(path.relative(each));
                                Navigator.pop(context);
                              },
                              onLongPress: () async {
                                await FileServices.delete(each);
                                await loadImages();
                              },
                              file: File(each)),
                    ],
                  ),
                ),
              )
          ],
        ),
      );
    });
  }
}
