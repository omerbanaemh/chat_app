import 'package:flutter/material.dart';

class ScholarHeader extends StatelessWidget {
  const ScholarHeader({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('assets/images/scholar.png', height: 100),
        const SizedBox(height: 10),
        const Text(
          'Scholar Chat',
          style: TextStyle(
            fontSize: 32,
            color: Colors.white,
            fontFamily: 'pacifico',
          ),
        ),
      ],
    );
  }
}
