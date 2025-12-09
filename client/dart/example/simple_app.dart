import 'package:nagada_client_sdk/nagada_client.dart';

void main() {
  final outbox = Outbox();
  final store = ProjectionStore();
  final syncEngine = SyncEngine(interval: Duration(seconds: 10));
  final client = NagadaClient(syncEngine: syncEngine, outbox: outbox, projections: store);

  outbox.add({'type': 'hello', 'payload': 'world'});
  client.start();
  print('Client started (example)');

  Future.delayed(Duration(seconds: 3), () {
    client.stop();
    print('Client stopped');
  });
}
