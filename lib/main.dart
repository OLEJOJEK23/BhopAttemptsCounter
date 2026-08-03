import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tryes_counter/core/blocks/theme/theme_cubit.dart';
import 'package:tryes_counter/core/repositories/theme_repository/theme_repository.dart';

import 'bhop_attempts_counter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    RepositoryProvider<SettingsRepositoryInterface>(
      create: (context) => SettingsRepository(),
      child: BlocProvider<ThemeCubit>(
        create: (context) => ThemeCubit(
          settingsRepository: context.read<SettingsRepositoryInterface>(),
        ),
        child: const BhopAttemptsCounter(),
      ),
    ),
  );
}
