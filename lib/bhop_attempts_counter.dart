import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tryes_counter/core/blocks/theme/theme_cubit.dart';
import 'package:tryes_counter/theme/theme.dart';

import 'features/home.dart';

class BhopAttemptsCounter extends StatelessWidget {
  const BhopAttemptsCounter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          title: 'Bhop Attempts Counter',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: state.isDark ? ThemeMode.dark : ThemeMode.light,
          home: const MyHomePage(title: 'Bhop Attempts Counter'),
        );
      },
    );
  }
}
