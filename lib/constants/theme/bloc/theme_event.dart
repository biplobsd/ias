part of 'theme_bloc.dart';

@immutable
abstract class ThemeEvent {}

class ThemeToggleEvent extends ThemeEvent {
  final BuildContext context;
  final bool isDark;
  
  ThemeToggleEvent({
    required this.context,
    required this.isDark,
  });
  
}
