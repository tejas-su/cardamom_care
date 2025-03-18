import 'dart:io';

import 'package:equatable/equatable.dart';

class ClassifyModel extends Equatable {
  final File? file;
  final List? output;

  const ClassifyModel({this.file, required this.output});

  @override
  List<Object?> get props => [file, output];
}
