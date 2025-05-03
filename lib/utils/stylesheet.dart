import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter/material.dart';

final MarkdownStyleSheet markDownStyleSheet = MarkdownStyleSheet(
  p: TextStyle(fontSize: 16), // Normal text
  strong: TextStyle(fontWeight: FontWeight.bold, fontSize: 16), // Bold text
  h1: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  h2: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
  h3: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  h4: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  h5: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  h6: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
  code: TextStyle(
    fontFamily: 'monospace',
    fontSize: 14,
    backgroundColor: Colors.grey.shade200,
  ),
  blockquote: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
  listBullet: TextStyle(fontSize: 16),
);
