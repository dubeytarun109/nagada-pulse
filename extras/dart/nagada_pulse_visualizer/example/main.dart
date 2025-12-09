import 'package:flutter/material.dart';
import 'package:nagada_flutter_ui/nagada_pulse_visualizer.dart';
import 'dart:async';
import 'package:nagada_client/sync_engine.dart';
import 'dart:math';

import 'package:nagada_flutter_ui/visu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Mock Streams for demonstration
  final StreamController<int> _outgoingController = StreamController<int>.broadcast();
  final StreamController<int> _incomingController = StreamController<int>.broadcast();
  final StreamController<SyncState> _syncStateController = StreamController<SyncState>.broadcast();

  // Mock SyncEngine for demonstration of optional UX features
  // In a real app, you would inject your actual SyncEngine instance here.
  final SyncEngine? _mockSyncEngine = SyncEngine();

  double _loadFactor = 0.0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startMockSyncActivity();
  }

  void _startMockSyncActivity() {
    int outgoingCount = 0;
    int incomingCount = 0;
    List<SyncState> states = [
      SyncState.idle,
      SyncState.syncing,
      SyncState.retrying,
      SyncState.error,
      SyncState.paused,
    ];
    int stateIndex = 0;

    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (!_syncStateController.isClosed) {
        stateIndex = (stateIndex + 1) % states.length;
        _syncStateController.add(states[stateIndex]);
      }

      if (states[stateIndex] == SyncState.syncing) {
        outgoingCount++;
        _outgoingController.add(outgoingCount);
        incomingCount += Random().nextInt(5); // Simulate variable incoming events
        _incomingController.add(incomingCount);
        _loadFactor = Random().nextDouble(); // Simulate fluctuating load
      } else if (states[stateIndex] == SyncState.retrying) {
        outgoingCount++;
        _outgoingController.add(outgoingCount);
        _loadFactor = 0.8; // High load during retrying
      } else if (states[stateIndex] == SyncState.error) {
        _loadFactor = 0.9; // Very high load on error
      } else {
        _loadFactor = 0.0; // Reset load on idle/paused
      }

      setState(() {}); // To rebuild the widget with new loadFactor
    });
  }

  @override
  void dispose() {
    _outgoingController.close();
    _incomingController.close();
    _syncStateController.close();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nagada Pulse Visualizer Demo',
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Nagada Pulse Visualizer Demo'),
        ),
        body: Row(
          children: [Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NagadaPulseVisualizer(
                outgoingCountStream: _outgoingController.stream,
                incomingCountStream: _incomingController.stream,
                syncStateStream: _syncStateController.stream,
                loadFactor: _loadFactor,
                size: 200,
                theme: PulseTheme.techPulse,
                enableHaptics: true,
                syncEngine: _mockSyncEngine, // Pass mock engine for tap handling
              ),
              const SizedBox(height: 40),
              NagadaPulseVisualizer(
                outgoingCountStream: _outgoingController.stream,
                incomingCountStream: _incomingController.stream,
                syncStateStream: _syncStateController.stream,
                loadFactor: _loadFactor,
                size: 150,
                theme: PulseTheme.classicNagada,
                enableHaptics: false,
                syncEngine: _mockSyncEngine, // Pass mock engine for tap handling
              ),
              const SizedBox(height: 40),
              Text(
                'Current State: ${_syncStateController.isClosed ? 'Closed' : 'Unknown'}',
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                'Load Factor: ${_loadFactor.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
       NagadaPulseVisualizer2(
        size: 180,
        color: Colors.redAccent,
      )
      ],
        ),
      ),
    );
  }
}
