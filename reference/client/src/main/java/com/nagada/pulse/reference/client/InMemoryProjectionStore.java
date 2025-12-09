package com.nagada.pulse.reference.client;

import com.nagada.pulse.protocol.ServerEvent;

import java.util.*;
import java.util.concurrent.CopyOnWriteArrayList;

/**
 * In-memory implementation of LocalProjectionStore.
 * Maintains the local view of server events received so far.
 */
public class InMemoryProjectionStore extends LocalProjectionStoreImpl {
    private final List<ServerEvent> receivedEvents = new CopyOnWriteArrayList<>();
    private volatile long lastKnownServerEventId = 0;

    @Override
    public void recordEvents(List<ServerEvent> events) {
        for (ServerEvent event : events) {
            receivedEvents.add(event);
            // Track the highest server event ID we've seen
            if (event.serverEventId > lastKnownServerEventId) {
                lastKnownServerEventId = event.serverEventId;
            }
        }
    }

    @Override
    public long getLastKnownServerEventId() {
        return lastKnownServerEventId;
    }

    /**
     * Returns a copy of all received events.
     */
    public List<ServerEvent> getReceivedEvents() {
        return new ArrayList<>(receivedEvents);
    }

    /**
     * Returns the count of received events.
     */
    public int getEventCount() {
        return receivedEvents.size();
    }
}
