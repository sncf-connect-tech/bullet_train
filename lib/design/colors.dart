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
}

class ConnectColors {
  Color get primary => _ConnectColorsDark.lightBlue;
  Color get primaryDark => _ConnectColorsDark.blue;
  Color get onPrimary => _ConnectColorsDark.darkBlue;
  Color get background => _ConnectColorsDark.darkBlue;
  Color get onBackground => _ConnectColorsDark.white;
  Color get surface => _ConnectColorsDark.anthracite;
  Color get onSurface => _ConnectColorsDark.white;
  Color get hover => _ConnectColorsDark.darkGrey;
  Color get popup => _ConnectColorsDark.darkGrey;
  Color get textPrimary => _ConnectColorsDark.white;
  Color get textSecondary => _ConnectColorsDark.grey;
  Color get error => _ConnectColorsDark.red;
}
