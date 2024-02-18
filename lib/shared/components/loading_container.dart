import 'package:flutter/material.dart';
import 'package:shop_app/shared/styles/colors.dart';

class BuildLoadingContainer extends StatelessWidget {
  const BuildLoadingContainer({super.key});
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).bottomNavigationBarTheme.backgroundColor ==
        AppColors.darKBackground;
    return Container(
      height: MediaQuery.of(context).size.height,
      color: isDark
          ? Theme.of(context).colorScheme.secondary.withOpacity(0.5)
          : Theme.of(context).colorScheme.secondary.withOpacity(0.3),
      child: Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.error,
        ),
      ),
    );
  }
}
