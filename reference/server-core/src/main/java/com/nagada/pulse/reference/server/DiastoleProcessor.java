package com.nagada.pulse.reference.server;

import com.nagada.pulse.protocol.ServerEvent;
import java.util.List;

/**
 * Diastole (downstroke) processor: fetches new server events since last known offset.
 * Returns events the client has not yet seen, updates the client's offset.
 */
public class DiastoleProcessor {

    private final EventStore eventStore;
    private final OffsetStore offsetStore;

    public DiastoleProcessor(EventStore eventStore, OffsetStore offsetStore) {
        this.eventStore = eventStore;
        this.offsetStore = offsetStore;
    }

    /**
     * Process diastole: fetch new events since the given offset, update stored offset.
     */
    public List<ServerEvent> process(String deviceId, long lastKnownServerEventId) {

        // Lookup previously synced position
        long currentOffset = offsetStore.get(deviceId);

        // The client may send a slightly stale offset.
        // Always respect the higher offset.
        long effectiveOffset = Math.max(currentOffset, lastKnownServerEventId);

        // Fetch new events
        List<ServerEvent> newEvents = eventStore.listAfter(effectiveOffset);

        // Update stored offset to newest event in the batch.
        if (!newEvents.isEmpty()) {
            long newest = newEvents.get(newEvents.size() - 1).serverEventId;
            offsetStore.update(deviceId, newest);
        }

        return newEvents;
    }
}
