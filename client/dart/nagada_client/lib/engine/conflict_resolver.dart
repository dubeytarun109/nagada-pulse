import '../core/models/server_event.dart';

/// A function that takes a list of conflicting server events and returns a single resolved event.
typedef ConflictResolverFn = ServerEvent Function(List<ServerEvent> conflicts);

/// A class that resolves conflicts between server events.
class ConflictResolver {
  final ConflictResolverFn? customResolver;

  ConflictResolver({this.customResolver});

  /// Resolves conflicts between server events.
  ///
  /// The default strategy is last-write-wins, where the event with the highest serverEventId is chosen.
  /// If a [customResolver] is provided, it will be used to resolve conflicts.
  List<ServerEvent> resolve(List<ServerEvent> events) {
    if (events.isEmpty) {
      return [];
    }

    final eventsByClientEventId = <String, List<ServerEvent>>{};
    for (final event in events) {
      eventsByClientEventId.putIfAbsent(event.originClientEventId, () => []).add(event);
    }

    final resolvedEvents = <ServerEvent>[];
    for (final conflicts in eventsByClientEventId.values) {
      if (conflicts.length == 1) {
        resolvedEvents.add(conflicts.first);
      } else {
        if (customResolver != null) {
          resolvedEvents.add(customResolver!(conflicts));
        } else {
          // Default to last-write-wins
          conflicts.sort((a, b) => b.serverEventId.compareTo(a.serverEventId));
          resolvedEvents.add(conflicts.first);
        }
      }
    }

    resolvedEvents.sort((a, b) => a.serverEventId.compareTo(b.serverEventId));
    return resolvedEvents;
  }
}
