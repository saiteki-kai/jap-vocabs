import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jap_vocab/generated/l10n.dart';
import 'package:jap_vocab/utils/notifications.dart';
import 'package:jap_vocab/redux/state/app_state.dart';
import 'package:jap_vocab/redux/store.dart';
import 'package:jap_vocab/routes.dart';
import 'package:jap_vocab/utils/styles.dart';
import 'package:redux/redux.dart';

void main() async {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  WidgetsFlutterBinding.ensureInitialized();

  final store = await createStore();

  await Notifications.instance.initNotifications();
  //await Notifications.instance.exampleNotification(store);
  //await Notifications.instance.reviewNotification(); // TODO: capire se spostare

  //await SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

  runApp(App(store: store));
}

class App extends StatelessWidget {
  final Store<AppState> store;
  const App({this.store});

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: StoreConnector(
        converter: (Store<AppState> store) => store,
        builder: (BuildContext context, store) {
          final languageCode = store.state.settingsState.languageCode;
          return MaterialApp(
            title: 'Japanese Vocabulary',
            locale: Locale.fromSubtags(languageCode: languageCode ?? 'en'),
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            localeResolutionCallback: (deviceLocale, supportedLocales) {
              for (var locale in supportedLocales) {
                if (locale.languageCode == deviceLocale.languageCode &&
                    locale.countryCode == deviceLocale.countryCode) {
                  return deviceLocale;
                }
              }
              return supportedLocales.first;
            },
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              // PALETTE: https://dribbble.com/shots/13626922-Bold-Mobile-app
              primaryColorDark: Colors.indigo[800], //Color(0xff4b3fc7),
              primaryColor:
                  Colors.indigo[600], // Color(0xff4b3fc7), // Colors.grey[50]
              primaryColorLight: Color(0x118881d0),
              accentColor:
                  Colors.amber, // Color(0xffe30425), // Color(0xffffab4d),
              accentColorBrightness: Brightness.light,
              canvasColor: Color(0xfff4f4f4),
              backgroundColor: Colors.white,
              highlightColor: Colors.white10,
              textTheme: Style.textTheme,
              buttonTheme: ButtonThemeData(
                disabledColor: Colors.grey.shade400,
                buttonColor: Theme.of(context).accentColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.all(12.0),
                minWidth: double.infinity,
              ),
              inputDecorationTheme: InputDecorationTheme(
                filled: true,
                contentPadding: const EdgeInsets.all(8.0),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  borderSide: BorderSide.none,
                ),
              ),
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            onGenerateRoute: onGenerateRoute,
          );
        },
      ),
    );
  }
}
