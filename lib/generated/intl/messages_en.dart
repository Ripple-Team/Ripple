// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "app_title": MessageLookupByLibrary.simpleMessage("messenger"),
    "bar_chats": MessageLookupByLibrary.simpleMessage("Chats"),
    "bar_contacts": MessageLookupByLibrary.simpleMessage("Contacts"),
    "bar_profile": MessageLookupByLibrary.simpleMessage("Profile"),
    "bar_settings": MessageLookupByLibrary.simpleMessage("Settings"),
    "chat_screen_text_field_hint_text": MessageLookupByLibrary.simpleMessage(
      "Message...",
    ),
    "english": MessageLookupByLibrary.simpleMessage("English"),
    "hint_search": MessageLookupByLibrary.simpleMessage("search"),
    "no_chats": MessageLookupByLibrary.simpleMessage(
      "You have no chat yet. \nStart chat with somebody!",
    ),
    "russian": MessageLookupByLibrary.simpleMessage("Русский"),
    "settings_tab_accentColor_title": MessageLookupByLibrary.simpleMessage(
      "AccentColor",
    ),
    "settings_tab_language_title": MessageLookupByLibrary.simpleMessage(
      "Language",
    ),
    "settings_tab_themeMode_dark": MessageLookupByLibrary.simpleMessage("dark"),
    "settings_tab_themeMode_light": MessageLookupByLibrary.simpleMessage(
      "light",
    ),
    "settings_tab_themeMode_system": MessageLookupByLibrary.simpleMessage(
      "system",
    ),
    "settings_tab_themeMode_title": MessageLookupByLibrary.simpleMessage(
      "Theme Mode",
    ),
  };
}
