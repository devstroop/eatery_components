import 'dart:io';
import 'package:eatery_components/bottomsheets/upload_file.bottomsheet.dart';
import 'package:eatery_services/eatery_services.dart';
import 'package:flutter/material.dart';
import '../bottomsheets/image_library.bottomsheet.dart';
import 'package:uicons/uicons.dart';

class UploadButton extends StatefulWidget {
  const UploadButton(
      {Key? key,
      this.filePath,
      this.onChanged,
      this.primaryColor = const Color(0xFF30A8CF),
      this.secondaryColor = const Color(0xFF2F2F2F),
      this.title,
      this.label,
      required this.uploadType})
      : super(key: key);
  final String? filePath;
  final Function(String? path)? onChanged;
  final Color primaryColor;
  final Color secondaryColor;
  final String? title;
  final String? label;
  final UploadType uploadType;

  @override
  State<UploadButton> createState() => _UploadButtonState();
}

class _UploadButtonState extends State<UploadButton> {
  String? filePath;
  @override
  void initState() {
    super.initState();
  }

  void onUploadPressed() => showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
        ),
      ),
      builder: (context) => widget.uploadType == UploadType.image
          ? ImageLibraryBottomSheet(context, (path) {
              filePath = path;
              if (widget.onChanged != null) {
                widget.onChanged!(path);
              }
              setState(() {});
            })
          : UploadFileBottomSheet(context, (path) {
              filePath = path;
              if (widget.onChanged != null) {
                widget.onChanged!(path);
              }
              setState(() {});
            }));

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            color: const Color(0xFFF0F0F0),
            border: Border.all(color: const Color(0xFFF0F0F0), width: 1)),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Material(
                  elevation: 2,
                  borderRadius: BorderRadius.circular(12),
                  child: InkWell(
                    onTap: onUploadPressed,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(9)),
                      child: SizedBox(
                        width: 84,
                        height: 84,
                        child: Icon(
                          UIcons.regularStraight.camera,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
                  child: Container(
                    height: 100,
                    decoration: const BoxDecoration(),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (widget.label != null)
                          Text(
                            widget.label!,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: widget.secondaryColor),
                          ),
                        if (widget.label != null)
                          const SizedBox(
                            height: 2,
                          ),
                        Text(
                          widget.title ??
                              (widget.uploadType == UploadType.image
                                  ? "+ Attach Image"
                                  : "+ Upload File"),
                          style: TextStyle(
                              fontSize: 14,
                              color: widget.primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (widget.filePath != null)
              FutureBuilder<String>(
                future: FileServices.absImage(widget.filePath!),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (!snapshot.hasData) {
                    return const SizedBox.shrink();
                  } else {
                    return Container(
                      height: 84,
                      width: 84,
                      decoration: BoxDecoration(
                        color: widget.uploadType != UploadType.image
                            ? const Color(0xFFF7F7F8)
                            : null,
                        borderRadius: BorderRadius.circular(4),
                        image: widget.uploadType == UploadType.image
                            ? DecorationImage(
                                fit: BoxFit.cover,
                                image: Image.file(File(snapshot.data!)).image,
                              )
                            : null,
                      ),
                      child: Stack(
                        children: [
                          if (widget.uploadType != UploadType.image)
                            Center(
                                child: Icon(
                              UIcons.regularStraight.file,
                              size: 64,
                              color: widget.primaryColor.withOpacity(0.50),
                            )),
                          Positioned(
                              top: 0,
                              right: 0,
                              child: InkWell(
                                onTap: () {
                                  filePath = null;
                                  if (widget.onChanged != null) {
                                    widget.onChanged!(null);
                                  }
                                  setState(() {});
                                },
                                child: Container(
                                  height: 16,
                                  width: 16,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: const Color(0xFFB63A3A),
                                  ),
                                  child: Icon(
                                    UIcons.regularStraight.minus_small,
                                    size: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ))
                        ],
                      ),
                    );
                  }
                },
              ),
          ],
        ),
      ),
    );
  }
}

enum UploadType { file, image }
