import 'package:flutter/material.dart';
import 'package:nortus/src/presentation/pages/widgets/custom_app_bar_widget.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(),
      body: SafeArea(
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
}