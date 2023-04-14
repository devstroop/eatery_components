import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../others/bottom_sheet.grip.dart';

class UploadFileBottomSheet extends StatefulWidget {
  final BuildContext context;
  final Function(String? path) action;

  const UploadFileBottomSheet(this.context, this.action, {Key? key}) : super(key: key);

  @override
  State<UploadFileBottomSheet> createState() => _UploadFileBottomSheetState();
}

class _UploadFileBottomSheetState extends State<UploadFileBottomSheet> {

  @override
  void initState(){
    super.initState();
  }

  Future pickFromFiles() async {
    FilePicker.platform.pickFiles().then((value) {
      if (value != null) {
        widget.action(value.files.single.path!);
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return StatefulBuilder(builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.all(12),
        child: ListView(
          shrinkWrap: true,
          children: [
            const Center(
              child: BottomSheetGrip(),
            ),
            const SizedBox(height: 12.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(padding: const EdgeInsets.all(8.0), child: IconButton(icon: const Icon(Icons.upload), iconSize: 36, color: const Color(0xFF888888), onPressed: pickFromFiles,)),
              ],
            ),
          ],
        ),
      );
    });
  }
}
