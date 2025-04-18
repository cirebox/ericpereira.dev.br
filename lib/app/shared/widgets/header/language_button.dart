import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import '../../i18n/localization_service.dart';

class LanguageButton extends StatefulWidget {
  const LanguageButton({super.key});

  @override
  State<LanguageButton> createState() => _LanguageButtonState();
}

class _LanguageButtonState extends State<LanguageButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _rotationAnimation = Tween<double>(begin: 0, end: 0.5).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizationService = Provider.of<LocalizationService>(context);
    final currentLanguage = localizationService.getLanguageButtonText();

    // Mapeamento de bandeiras para cada idioma
    final Map<String, Map<String, dynamic>> languages = {
      'PT': {
        'name': 'Português',
        'flag': '🇧🇷',
        'locale': const Locale('pt', 'BR'),
      },
      'EN': {
        'name': 'English',
        'flag': '🇺🇸',
        'locale': const Locale('en', 'US'),
      },
      'ES': {
        'name': 'Español',
        'flag': '🇪🇸',
        'locale': const Locale('es', 'ES'),
      },
    };

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: PopupMenuButton<Locale>(
        tooltip: 'Mudar idioma',
        offset: const Offset(0, 40),
        onSelected: (Locale locale) {
          localizationService.changeLocale(locale);
          HapticFeedback.mediumImpact();
        },
        onOpened: () => _animationController.forward(),
        onCanceled: () => _animationController.reverse(),
        position: PopupMenuPosition.under,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
        itemBuilder: (context) {
          return languages.entries.map((entry) {
            final isSelected = entry.key == currentLanguage;
            return PopupMenuItem<Locale>(
              value: entry.value['locale'],
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    entry.value['flag'],
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    entry.value['name'],
                    style: TextStyle(
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? Theme.of(context).primaryColor : null,
                    ),
                  ),
                  if (isSelected)
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Icon(
                        Icons.check_circle,
                        color: Theme.of(context).primaryColor,
                        size: 16,
                      ),
                    ),
                ],
              ),
            );
          }).toList();
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Theme.of(context).dividerColor.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                languages[currentLanguage]?['flag'] ?? '🌐',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(width: 6),
              Text(
                currentLanguage,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.titleMedium?.color,
                ),
              ),
              const SizedBox(width: 3),
              RotationTransition(
                turns: _rotationAnimation,
                child: Icon(
                  Icons.arrow_drop_down,
                  size: 16,
                  color: Theme.of(context).textTheme.titleMedium?.color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
