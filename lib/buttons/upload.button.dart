import 'dart:io';
import 'package:eatery_components/bottomsheets/upload_file.bottomsheet.dart';
import 'package:eatery_services/eatery_services.dart';
import 'package:flutter/material.dart';
import '../borders/dotted_border/dotted_border.dart';
import '../bottomsheets/image_library.bottomsheet.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(9)),
          color: const Color(0xFFF0F0F0),
          border: Border.all(color: const Color(0xFFF0F0F0), width: 1)),
      child: InkWell(
        onTap: () => showModalBottomSheet(
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
                  })),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                DottedBorder(
                  borderType: BorderType.rRect,
                  dashPattern: const [6, 3],
                  radius: const Radius.circular(9),
                  color: const Color(0xFF576060),
                  strokeWidth: 1,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(9)),
                    child: SizedBox(
                      width: 84,
                      height: 84,
                      child: SvgPicture.asset(
                        'assets/vectors/add_a_photo.svg',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
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
                                fontSize: 12, color: widget.secondaryColor),
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
                              Icons.file_present_rounded,
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
                                  child: const Icon(
                                    Icons.close,
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
