import 'dart:io';
import 'package:flutter/material.dart';

class Results extends StatelessWidget {
  final File file;
  final String label;
  final double confidence;
  const Results({
    super.key,
    required this.file,
    required this.label,
    required this.confidence,
  });

  @override
  Widget build(BuildContext context) {
    double roundedConfidenceValue = double.parse(confidence.toStringAsFixed(2));
    return Expanded(
      child: ListView(shrinkWrap: true, children: [
        Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(height: 560, child: Image.file(file)),
                ListTile(
                  title: Text(
                    label,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  trailing: Text(
                    '$roundedConfidenceValue',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ))
      ]),
    );
  }
}
