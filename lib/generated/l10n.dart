// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `messenger`
  String get appTitle {
    return Intl.message('messenger', name: 'appTitle', desc: '', args: []);
  }

  /// `Contacts`
  String get bar_contacts {
    return Intl.message('Contacts', name: 'bar_contacts', desc: '', args: []);
  }

  /// `Profile`
  String get bar_profile {
    return Intl.message('Profile', name: 'bar_profile', desc: '', args: []);
  }

  /// `Chats`
  String get bar_chats {
    return Intl.message('Chats', name: 'bar_chats', desc: '', args: []);
  }

  /// `Settings`
  String get bar_settings {
    return Intl.message('Settings', name: 'bar_settings', desc: '', args: []);
  }

  /// `search`
  String get hint_search {
    return Intl.message('search', name: 'hint_search', desc: '', args: []);
  }

  /// `You have no chat yet. \nStart chat with somebody!`
  String get noChats {
    return Intl.message(
      'You have no chat yet. \nStart chat with somebody!',
      name: 'noChats',
      desc: '',
      args: [],
    );
  }

  /// `Theme Mode`
  String get settings_tab_themeMode_title {
    return Intl.message(
      'Theme Mode',
      name: 'settings_tab_themeMode_title',
      desc: '',
      args: [],
    );
  }

  /// `system`
  String get settings_tab_themeMode_system {
    return Intl.message(
      'system',
      name: 'settings_tab_themeMode_system',
      desc: '',
      args: [],
    );
  }

  /// `light`
  String get settings_tab_themeMode_light {
    return Intl.message(
      'light',
      name: 'settings_tab_themeMode_light',
      desc: '',
      args: [],
    );
  }

  /// `dark`
  String get settings_tab_themeMode_dark {
    return Intl.message(
      'dark',
      name: 'settings_tab_themeMode_dark',
      desc: '',
      args: [],
    );
  }

  /// `AccentColor`
  String get settings_tab_accentColor_title {
    return Intl.message(
      'AccentColor',
      name: 'settings_tab_accentColor_title',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get settings_tab_language_title {
    return Intl.message(
      'Language',
      name: 'settings_tab_language_title',
      desc: '',
      args: [],
    );
  }

  /// `Message...`
  String get chat_screen_text_field_hint_text {
    return Intl.message(
      'Message...',
      name: 'chat_screen_text_field_hint_text',
      desc: '',
      args: [],
    );
  }

  /// `english`
  String get english {
    return Intl.message('english', name: 'english', desc: '', args: []);
  }

  /// `русский`
  String get russian {
    return Intl.message('русский', name: 'russian', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
