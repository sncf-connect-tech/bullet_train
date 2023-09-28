import 'dart:ui';

class _ConnectColorsDark {
  static const Color blue = Color(0xFF40CDF2);
  static const Color lightBlue = Color(0xFF8DE8FE);
  static const Color darkBlue = Color(0xFF0C131F);
  static const Color anthracite = Color(0xFF242B35);
  static const Color white = Color(0xFFF3F3F4);
  static const Color grey = Color(0xFF9DA0A5);
  static const Color darkGrey = Color(0xFF293846);
  static const Color red = Color(0xFFFF5072);
  static const Color green = Color(0xFF6BDB64);
}

abstract class ConnectColors {
  static const Color primary = _ConnectColorsDark.lightBlue;
  static const Color primaryDark = _ConnectColorsDark.blue;
  static const Color onPrimary = _ConnectColorsDark.darkBlue;
  static const Color background = _ConnectColorsDark.darkBlue;
  static const Color onBackground = _ConnectColorsDark.white;
  static const Color surface = _ConnectColorsDark.anthracite;
  static const Color onSurface = _ConnectColorsDark.white;
  static const Color hover = _ConnectColorsDark.darkGrey;
  static const Color popup = _ConnectColorsDark.darkGrey;
  static const Color textPrimary = _ConnectColorsDark.white;
  static const Color textSecondary = _ConnectColorsDark.grey;
  static const Color error = _ConnectColorsDark.red;
  static const Color success = _ConnectColorsDark.green;
}
