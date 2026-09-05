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

  /// `Ripple`
  String get app_title {
    return Intl.message('Ripple', name: 'app_title', desc: '', args: []);
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
  String get no_chats {
    return Intl.message(
      'You have no chat yet. \nStart chat with somebody!',
      name: 'no_chats',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get auth_screen_title {
    return Intl.message(
      'Sign in',
      name: 'auth_screen_title',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get auth_screen_username_label {
    return Intl.message(
      'Username',
      name: 'auth_screen_username_label',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get auth_screen_password_label {
    return Intl.message(
      'Password',
      name: 'auth_screen_password_label',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get auth_screen_submit_button {
    return Intl.message(
      'Sign in',
      name: 'auth_screen_submit_button',
      desc: '',
      args: [],
    );
  }

  /// `Enter your username and password`
  String get auth_screen_error_empty_credentials {
    return Intl.message(
      'Enter your username and password',
      name: 'auth_screen_error_empty_credentials',
      desc: '',
      args: [],
    );
  }

  /// `Couldn't sign in. Please try again`
  String get auth_screen_error_unknown {
    return Intl.message(
      'Couldn\'t sign in. Please try again',
      name: 'auth_screen_error_unknown',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get auth_screen_register_title {
    return Intl.message(
      'Sign up',
      name: 'auth_screen_register_title',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get auth_screen_register_button {
    return Intl.message(
      'Sign up',
      name: 'auth_screen_register_button',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password`
  String get auth_screen_confirm_password_label {
    return Intl.message(
      'Confirm password',
      name: 'auth_screen_confirm_password_label',
      desc: '',
      args: [],
    );
  }

  /// `No account? Sign up`
  String get auth_screen_toggle_to_register {
    return Intl.message(
      'No account? Sign up',
      name: 'auth_screen_toggle_to_register',
      desc: '',
      args: [],
    );
  }

  /// `Already have account? Sign in`
  String get auth_screen_toggle_to_login {
    return Intl.message(
      'Already have account? Sign in',
      name: 'auth_screen_toggle_to_login',
      desc: '',
      args: [],
    );
  }

  /// `Wrong username or password`
  String get auth_screen_error_invalid_credentials {
    return Intl.message(
      'Wrong username or password',
      name: 'auth_screen_error_invalid_credentials',
      desc: '',
      args: [],
    );
  }

  /// `This username is already taken`
  String get auth_screen_error_username_taken {
    return Intl.message(
      'This username is already taken',
      name: 'auth_screen_error_username_taken',
      desc: '',
      args: [],
    );
  }

  /// `Passwords don't match`
  String get auth_screen_passwords_dont_match {
    return Intl.message(
      'Passwords don\'t match',
      name: 'auth_screen_passwords_dont_match',
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

  /// `Account`
  String get settings_account_title {
    return Intl.message(
      'Account',
      name: 'settings_account_title',
      desc: '',
      args: [],
    );
  }

  /// `Username, «about»`
  String get settings_account_subtitle {
    return Intl.message(
      'Username, «about»',
      name: 'settings_account_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get settings_account_logout {
    return Intl.message(
      'Logout',
      name: 'settings_account_logout',
      desc: '',
      args: [],
    );
  }

  /// `Appearance`
  String get settings_appearance_title {
    return Intl.message(
      'Appearance',
      name: 'settings_appearance_title',
      desc: '',
      args: [],
    );
  }

  /// `Theme mode, accent color`
  String get settings_appearance_subtitle {
    return Intl.message(
      'Theme mode, accent color',
      name: 'settings_appearance_subtitle',
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

  /// `Editing Message`
  String get chat_screen_editing_title {
    return Intl.message(
      'Editing Message',
      name: 'chat_screen_editing_title',
      desc: '',
      args: [],
    );
  }

  /// `This is the beginning of your conversation`
  String get chat_beginning_of_history {
    return Intl.message(
      'This is the beginning of your conversation',
      name: 'chat_beginning_of_history',
      desc: '',
      args: [],
    );
  }

  /// `edited`
  String get message_edited {
    return Intl.message('edited', name: 'message_edited', desc: '', args: []);
  }

  /// `Copy`
  String get message_action_copy {
    return Intl.message(
      'Copy',
      name: 'message_action_copy',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get message_action_edit {
    return Intl.message(
      'Edit',
      name: 'message_action_edit',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get message_action_delete {
    return Intl.message(
      'Delete',
      name: 'message_action_delete',
      desc: '',
      args: [],
    );
  }

  /// `Delete message?`
  String get message_delete_title {
    return Intl.message(
      'Delete message?',
      name: 'message_delete_title',
      desc: '',
      args: [],
    );
  }

  /// `This action cannot be undone.`
  String get message_delete_text {
    return Intl.message(
      'This action cannot be undone.',
      name: 'message_delete_text',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `English`
  String get english {
    return Intl.message('English', name: 'english', desc: '', args: []);
  }

  /// `Русский`
  String get russian {
    return Intl.message('Русский', name: 'russian', desc: '', args: []);
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
