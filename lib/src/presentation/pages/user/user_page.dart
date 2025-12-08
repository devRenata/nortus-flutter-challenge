import 'package:flutter/material.dart';
import 'package:nortus/src/presentation/pages/widgets/build_app_bar.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildAppBar(),
      body: Center(
        child: Text('user page'),
      ),
    );
  }
}