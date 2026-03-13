import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FbScaffold extends StatelessWidget {
  const FbScaffold({super.key, required this.title, required this.body});

  final String title;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: body,
    );
  }
}
