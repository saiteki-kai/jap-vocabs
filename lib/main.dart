import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
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

  runApp(App(store: store));
}

class App extends StatelessWidget {
  final Store<AppState> store;
  const App({this.store});

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Japanese Vocabulary',
        locale: Locale('ja', 'JP'),
        // localizationsDelegates: localizationsDelegates,
        // supportedLocales: [
        //   const Locale("ja", "Jp"),
        //   const Locale("en", "EN"),
        //   const Locale("it", "IT"),
        // ],
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // PALETTE: https://dribbble.com/shots/13626922-Bold-Mobile-app
          primaryColorDark: Color(0xff4b3fc7),
          primaryColor: Color(0xff4b3fc7),
          primaryColorLight: Color(0x118881d0),
          accentColor: Color(0xffffa962),
          accentColorBrightness: Brightness.dark,
          backgroundColor: Colors.white,
          highlightColor: Colors.white10,
          textTheme: Style.textTheme,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        onGenerateRoute: onGenerateRoute,
      ),
    );
  }
}
