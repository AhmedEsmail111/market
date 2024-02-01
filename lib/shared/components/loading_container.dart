import 'package:flutter/material.dart';

class BuildLoadingContainer extends StatelessWidget {
  const BuildLoadingContainer({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
      child: Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.error,
        ),
      ),
    );
  }
}
