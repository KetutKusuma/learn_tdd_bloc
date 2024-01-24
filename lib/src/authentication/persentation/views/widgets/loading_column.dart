import 'package:flutter/material.dart';

class LoadingColumnWidget extends StatelessWidget {
  const LoadingColumnWidget({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircularProgressIndicator(),
        const SizedBox(
          height: 10,
        ),
        Text("$message...")
      ],
    );
  }
}
