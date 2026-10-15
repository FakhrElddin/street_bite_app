import 'package:flutter/material.dart';
import 'package:street_bite_app/features/profile/presentation/widgets/language_selector_tile.dart';
import 'package:street_bite_app/features/profile/presentation/widgets/theme_toggle_button.dart';
import 'package:street_bite_app/generated/l10n.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            S.of(context).profileTitle,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 32),
          const ThemeToggleButton(),
          const SizedBox(height: 16),
          const LanguageSelectorTile(),
        ],
      ),
    );
  }
}
