import 'package:nagada_client/nagada_client.dart';

void main() {
  final outbox = Outbox();
  final store = ProjectionStore();
  final syncEngine = SyncEngine(interval: Duration(seconds: 10));

  final client = NagadaClient(
    syncEngine: syncEngine,
    outbox: outbox,
    projections: store,
  );

  outbox.add({'type': 'greeting', 'payload': 'Hello Nagada'});

  client.start();
  print('Nagada client started (example).');

  // Run for a short time then stop
  Future.delayed(Duration(seconds: 2), () {
    client.stop();
    print('Nagada client stopped.');
  });
}
