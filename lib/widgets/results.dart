import 'dart:io';
import 'package:cardamom_care/blocs/classify_bloc/classify_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                SizedBox(
                    height: 55,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () => context
                                .read<ClassifyBloc>()
                                .add(OnRefreshEvent()),
                            icon: Icon(Icons.close),
                          )
                        ])),
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
