package com.nagada.pulse.reference.client;

import com.nagada.pulse.protocol.ServerEvent;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Local projection store: tracks received server events and last known offset.
 */
public class LocalProjectionStoreImpl implements LocalProjectionStore {

    private final Map<Long, ServerEvent> receivedEvents = new ConcurrentHashMap<>();
    private long lastKnownServerEventId = -1;

    /**
     * Record received events.
     */
    public void recordEvents(List<ServerEvent> events) {
        for (ServerEvent event : events) {
            long id = event.serverEventId;
            receivedEvents.put(id, event);
            if (id > lastKnownServerEventId) {
                lastKnownServerEventId = id;
            }
        }
    }

    /**
     * Get the last known server event ID.
     */
    public long getLastKnownServerEventId() {
        return lastKnownServerEventId;
    }

    /**
     * Get all recorded events.
     */
    public List<ServerEvent> getAllEvents() {
        return new ArrayList<>(receivedEvents.values());
    }
}
