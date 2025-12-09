// Minimal Nagada client reference library
library nagada_client;

import 'outbox.dart';
import 'projection_store.dart';
import 'sync_engine.dart';

export 'outbox.dart';
export 'projection_store.dart';
export 'sync_engine.dart';

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
