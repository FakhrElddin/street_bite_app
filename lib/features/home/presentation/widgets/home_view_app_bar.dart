import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:street_bite_app/features/main_navigation/presentation/manager/cubit/theme_cubit.dart';
import 'package:street_bite_app/generated/l10n.dart';

class HomeViewAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeViewAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(
        S.of(context).appName,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            final themeCubit = ThemeCubit.get(context);
            final isDark = themeCubit.isDark;
            return IconButton(
              tooltip:
                  isDark ? S.of(context).lightMode : S.of(context).darkMode,
              icon: Icon(
                isDark
                    ? Icons.light_mode_outlined
                    : Icons.dark_mode_outlined,
              ),
              onPressed: () => themeCubit.changeTheme(),
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
