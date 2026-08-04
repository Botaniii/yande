import 'package:flutter/material.dart';

class ImageCardCircularProgressIndicator extends StatelessWidget {
  const ImageCardCircularProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 3,
        ),
      ),
    );
  }
}

class FootProgress extends StatelessWidget {
  const FootProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: Center(
        child: SizedBox(
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
          height: 20.0,
          width: 20.0,
        ),
      ),
    );
  }
}

class CenterProgress extends StatelessWidget {
  const CenterProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 40,
      child: Center(
        child: SizedBox(
          child: CircularProgressIndicator(
            strokeWidth: 3,
          ),
          height: 20.0,
          width: 20.0,
        ),
      ),
    );
  }
}