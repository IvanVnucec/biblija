import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

final ThemeData appLightTheme = FlexThemeData.light(
  scheme: FlexScheme.damask,
  surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
  blendLevel: 9,
  subThemesData: const FlexSubThemesData(
    blendOnLevel: 10,
    blendOnColors: false,
  ),
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
);

final ThemeData appDarkTheme = FlexThemeData.dark(
  scheme: FlexScheme.damask,
  surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
  blendLevel: 15,
  subThemesData: const FlexSubThemesData(
    blendOnLevel: 20,
  ),
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
);
