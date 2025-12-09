import 'server_event.dart';

abstract class LocalProjectionStore {
  void apply(ServerEvent event);
}