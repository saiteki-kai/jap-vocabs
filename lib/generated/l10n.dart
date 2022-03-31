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
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Accuracy`
  String get accuracy {
    return Intl.message(
      'Accuracy',
      name: 'accuracy',
      desc: '',
      args: [],
    );
  }

  /// `Alphabetical`
  String get alphabetical {
    return Intl.message(
      'Alphabetical',
      name: 'alphabetical',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get button_next {
    return Intl.message(
      'Next',
      name: 'button_next',
      desc: '',
      args: [],
    );
  }

  /// `Show`
  String get button_show {
    return Intl.message(
      'Show',
      name: 'button_show',
      desc: '',
      args: [],
    );
  }

  /// `Reset`
  String get button_reset {
    return Intl.message(
      'Reset',
      name: 'button_reset',
      desc: '',
      args: [],
    );
  }

  /// `Restore`
  String get button_restore {
    return Intl.message(
      'Restore',
      name: 'button_restore',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get button_delete {
    return Intl.message(
      'Delete',
      name: 'button_delete',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get button_cancel {
    return Intl.message(
      'Cancel',
      name: 'button_cancel',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get button_add {
    return Intl.message(
      'Add',
      name: 'button_add',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get button_confirm {
    return Intl.message(
      'Confirm',
      name: 'button_confirm',
      desc: '',
      args: [],
    );
  }

  /// `Reset reviews progress for this item?`
  String get dialog_reset_msg {
    return Intl.message(
      'Reset reviews progress for this item?',
      name: 'dialog_reset_msg',
      desc: '',
      args: [],
    );
  }

  /// `Delete this item?`
  String get dialog_delete_msg {
    return Intl.message(
      'Delete this item?',
      name: 'dialog_delete_msg',
      desc: '',
      args: [],
    );
  }

  /// `Example`
  String get dialog_example {
    return Intl.message(
      'Example',
      name: 'dialog_example',
      desc: '',
      args: [],
    );
  }

  /// `Translation`
  String get dialog_example_translation {
    return Intl.message(
      'Translation',
      name: 'dialog_example_translation',
      desc: '',
      args: [],
    );
  }

  /// `Do you wanna restore from backup?`
  String get dialog_backup_msg {
    return Intl.message(
      'Do you wanna restore from backup?',
      name: 'dialog_backup_msg',
      desc: '',
      args: [],
    );
  }

  /// `Easiness`
  String get details_reviews_ef {
    return Intl.message(
      'Easiness',
      name: 'details_reviews_ef',
      desc: '',
      args: [],
    );
  }

  /// `No examples inserted yet`
  String get examples_empty {
    return Intl.message(
      'No examples inserted yet',
      name: 'examples_empty',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get title_add {
    return Intl.message(
      'Add',
      name: 'title_add',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get title_edit {
    return Intl.message(
      'Edit',
      name: 'title_edit',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get title_settings {
    return Intl.message(
      'Settings',
      name: 'title_settings',
      desc: '',
      args: [],
    );
  }

  /// `Favorites`
  String get title_favorites {
    return Intl.message(
      'Favorites',
      name: 'title_favorites',
      desc: '',
      args: [],
    );
  }

  /// `Kanji`
  String get home_kanji {
    return Intl.message(
      'Kanji',
      name: 'home_kanji',
      desc: '',
      args: [],
    );
  }

  /// `Vocabs`
  String get home_vocabs {
    return Intl.message(
      'Vocabs',
      name: 'home_vocabs',
      desc: '',
      args: [],
    );
  }

  /// `Filter`
  String get tab_filter {
    return Intl.message(
      'Filter',
      name: 'tab_filter',
      desc: '',
      args: [],
    );
  }

  /// `Sort`
  String get tab_sort {
    return Intl.message(
      'Sort',
      name: 'tab_sort',
      desc: '',
      args: [],
    );
  }

  /// `Kanji`
  String get tab_kanji {
    return Intl.message(
      'Kanji',
      name: 'tab_kanji',
      desc: '',
      args: [],
    );
  }

  /// `Word`
  String get tab_word {
    return Intl.message(
      'Word',
      name: 'tab_word',
      desc: '',
      args: [],
    );
  }

  /// `Reviews`
  String get tab_review {
    return Intl.message(
      'Reviews',
      name: 'tab_review',
      desc: '',
      args: [],
    );
  }

  /// `Correct`
  String get item_correct {
    return Intl.message(
      'Correct',
      name: 'item_correct',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect`
  String get item_incorrect {
    return Intl.message(
      'Incorrect',
      name: 'item_incorrect',
      desc: '',
      args: [],
    );
  }

  /// `Meaning`
  String get item_meaning {
    return Intl.message(
      'Meaning',
      name: 'item_meaning',
      desc: '',
      args: [],
    );
  }

  /// `Next Review`
  String get item_nextreview {
    return Intl.message(
      'Next Review',
      name: 'item_nextreview',
      desc: '',
      args: [],
    );
  }

  /// `Number of Strokes`
  String get item_numberofstrokes {
    return Intl.message(
      'Number of Strokes',
      name: 'item_numberofstrokes',
      desc: '',
      args: [],
    );
  }

  /// `Part  of Speech`
  String get item_partofspeech {
    return Intl.message(
      'Part  of Speech',
      name: 'item_partofspeech',
      desc: '',
      args: [],
    );
  }

  /// `Reading`
  String get item_reading {
    return Intl.message(
      'Reading',
      name: 'item_reading',
      desc: '',
      args: [],
    );
  }

  /// `Streak`
  String get item_streak {
    return Intl.message(
      'Streak',
      name: 'item_streak',
      desc: '',
      args: [],
    );
  }

  /// `Level`
  String get item_level {
    return Intl.message(
      'Level',
      name: 'item_level',
      desc: '',
      args: [],
    );
  }

  /// `Type`
  String get item_type {
    return Intl.message(
      'Type',
      name: 'item_type',
      desc: '',
      args: [],
    );
  }

  /// `Text`
  String get item_text {
    return Intl.message(
      'Text',
      name: 'item_text',
      desc: '',
      args: [],
    );
  }

  /// `Writing`
  String get item_writing {
    return Intl.message(
      'Writing',
      name: 'item_writing',
      desc: '',
      args: [],
    );
  }

  /// `Favorites`
  String get menu_favorite {
    return Intl.message(
      'Favorites',
      name: 'menu_favorite',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get menu_settings {
    return Intl.message(
      'Settings',
      name: 'menu_settings',
      desc: '',
      args: [],
    );
  }

  /// `Stats`
  String get menu_statistics {
    return Intl.message(
      'Stats',
      name: 'menu_statistics',
      desc: '',
      args: [],
    );
  }

  /// `Reviews`
  String get reviews {
    return Intl.message(
      'Reviews',
      name: 'reviews',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search_placeholder {
    return Intl.message(
      'Search',
      name: 'search_placeholder',
      desc: '',
      args: [],
    );
  }

  /// `Alternative Layout`
  String get settings_altlayout {
    return Intl.message(
      'Alternative Layout',
      name: 'settings_altlayout',
      desc: '',
      args: [],
    );
  }

  /// `Show examples in the home page`
  String get settings_altlayout_descr {
    return Intl.message(
      'Show examples in the home page',
      name: 'settings_altlayout_descr',
      desc: '',
      args: [],
    );
  }

  /// `Automatic Backups`
  String get settings_automaticbackups {
    return Intl.message(
      'Automatic Backups',
      name: 'settings_automaticbackups',
      desc: '',
      args: [],
    );
  }

  /// `Backup`
  String get settings_backup {
    return Intl.message(
      'Backup',
      name: 'settings_backup',
      desc: '',
      args: [],
    );
  }

  /// `Backup frequency`
  String get settings_backupfreq {
    return Intl.message(
      'Backup frequency',
      name: 'settings_backupfreq',
      desc: '',
      args: [],
    );
  }

  /// `Backup location`
  String get settings_backuplocation {
    return Intl.message(
      'Backup location',
      name: 'settings_backuplocation',
      desc: '',
      args: [],
    );
  }

  /// `Create Backup`
  String get settings_createbackup {
    return Intl.message(
      'Create Backup',
      name: 'settings_createbackup',
      desc: '',
      args: [],
    );
  }

  /// `Create a backup of reviews`
  String get settings_createbackup_descr {
    return Intl.message(
      'Create a backup of reviews',
      name: 'settings_createbackup_descr',
      desc: '',
      args: [],
    );
  }

  /// `Display`
  String get settings_display {
    return Intl.message(
      'Display',
      name: 'settings_display',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get settings_notifications {
    return Intl.message(
      'Notifications',
      name: 'settings_notifications',
      desc: '',
      args: [],
    );
  }

  /// `Restore Backup`
  String get settings_restorebackup {
    return Intl.message(
      'Restore Backup',
      name: 'settings_restorebackup',
      desc: '',
      args: [],
    );
  }

  /// `Restore reviews from a backup file`
  String get settings_restorebackup_descr {
    return Intl.message(
      'Restore reviews from a backup file',
      name: 'settings_restorebackup_descr',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get settings_language {
    return Intl.message(
      'Language',
      name: 'settings_language',
      desc: '',
      args: [],
    );
  }

  /// `Enable`
  String get settings_notifications_enable {
    return Intl.message(
      'Enable',
      name: 'settings_notifications_enable',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get settings_notifications_time {
    return Intl.message(
      'Time',
      name: 'settings_notifications_time',
      desc: '',
      args: [],
    );
  }

  /// `Days`
  String get settings_notifications_days {
    return Intl.message(
      'Days',
      name: 'settings_notifications_days',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get summary_total {
    return Intl.message(
      'Total',
      name: 'summary_total',
      desc: '',
      args: [],
    );
  }

  /// `Correct`
  String get summary_correct {
    return Intl.message(
      'Correct',
      name: 'summary_correct',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect`
  String get summary_incorrect {
    return Intl.message(
      'Incorrect',
      name: 'summary_incorrect',
      desc: '',
      args: [],
    );
  }

  /// `Required`
  String get validation_required {
    return Intl.message(
      'Required',
      name: 'validation_required',
      desc: '',
      args: [],
    );
  }

  /// `The value must be greater than 0`
  String get validation_positive {
    return Intl.message(
      'The value must be greater than 0',
      name: 'validation_positive',
      desc: '',
      args: [],
    );
  }

  /// `No route defined for`
  String get notfound {
    return Intl.message(
      'No route defined for',
      name: 'notfound',
      desc: '',
      args: [],
    );
  }

  /// `Loading...`
  String get loading {
    return Intl.message(
      'Loading...',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `New`
  String get new_item {
    return Intl.message(
      'New',
      name: 'new_item',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get tooltip_add {
    return Intl.message(
      'Add',
      name: 'tooltip_add',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get tooltip_delete {
    return Intl.message(
      'Delete',
      name: 'tooltip_delete',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get tooltip_edit {
    return Intl.message(
      'Edit',
      name: 'tooltip_edit',
      desc: '',
      args: [],
    );
  }

  /// `Favorite`
  String get tooltip_favorite {
    return Intl.message(
      'Favorite',
      name: 'tooltip_favorite',
      desc: '',
      args: [],
    );
  }

  /// `Filter`
  String get tooltip_filter {
    return Intl.message(
      'Filter',
      name: 'tooltip_filter',
      desc: '',
      args: [],
    );
  }

  /// `Menu`
  String get tooltip_menu {
    return Intl.message(
      'Menu',
      name: 'tooltip_menu',
      desc: '',
      args: [],
    );
  }

  /// `Reset`
  String get tooltip_reset {
    return Intl.message(
      'Reset',
      name: 'tooltip_reset',
      desc: '',
      args: [],
    );
  }

  /// `Summary`
  String get tooltip_summary {
    return Intl.message(
      'Summary',
      name: 'tooltip_summary',
      desc: '',
      args: [],
    );
  }

  /// `Italian`
  String get it {
    return Intl.message(
      'Italian',
      name: 'it',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get en {
    return Intl.message(
      'English',
      name: 'en',
      desc: '',
      args: [],
    );
  }

  /// `Japanese`
  String get ja {
    return Intl.message(
      'Japanese',
      name: 'ja',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'it'),
      Locale.fromSubtags(languageCode: 'ja'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}