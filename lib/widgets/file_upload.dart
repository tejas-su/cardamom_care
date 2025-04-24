import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class FileUpload extends StatelessWidget {
  final Function()? onTap;
  const FileUpload({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: DottedBorder(
            color: Colors.grey,
            strokeWidth: 1.5,
            padding: EdgeInsets.all(20),
            borderType: BorderType.RRect,
            strokeCap: StrokeCap.round,
            radius: Radius.circular(10),
            dashPattern: [10, 8],
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                spacing: 10,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.file_upload_outlined,
                    color: Colors.grey,
                    size: 50,
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    'Please select an image file',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey),
                  ),
                  Text('Supported formats are JPG, JPEG, and PNG',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          color: Colors.grey))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
