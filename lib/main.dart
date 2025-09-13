import 'package:flutter/material.dart';
import 'package:bayt_aura/bayt_aura_app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/core/di/dependency_injection.dart';
import 'package:bayt_aura/features/home/logic/property_cubit.dart';

void main() {
  setUpGetIt();

  runApp(BlocProvider(create: (_) => PropertyCubit(), child: const BaytAura()));
}
