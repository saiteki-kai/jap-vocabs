import 'package:jap_vocab/redux/reducers/app_reducers.dart';
import 'package:jap_vocab/redux/state/app_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_persist_flutter/redux_persist_flutter.dart';
import 'package:redux_thunk/redux_thunk.dart';

Future<Store<AppState>> createStore() async {
  final persistor = Persistor<AppState>(
    storage: FlutterStorage(),
    throttleDuration: const Duration(seconds: 2),
    serializer: JsonSerializer<AppState>(AppState.fromJson),
    debug: true,
  );

  AppState initialState;

  await persistor
      .load()
      .then((value) => initialState = value)
      .catchError((error) => print(error));

  return Store<AppState>(
    appStateReducer,
    initialState: initialState ?? AppState.initialState(),
    middleware: [thunkMiddleware, persistor.createMiddleware()],
  );
}
