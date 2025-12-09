library nagada_client_sdk;

export 'src/outbox.dart';
export 'src/projection_store.dart';
export 'src/sync_engine.dart';

import 'src/sync_engine.dart';
import 'src/outbox.dart';
import 'src/projection_store.dart';

class NagadaClient {
  final SyncEngine syncEngine;
  final Outbox outbox;
  final ProjectionStore projections;

  NagadaClient({
    required this.syncEngine,
    required this.outbox,
    required this.projections,
  });

  void start() => syncEngine.start();
  void stop() => syncEngine.stop();
}
