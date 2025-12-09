package com.nagada.pulse.reference.client;

import com.nagada.pulse.protocol.ServerEvent;
import java.util.List;

/**
 * Abstraction for the client's local projection store. Implementations store
 * received `ServerEvent`s and expose the last known server event id.
 */
public interface LocalProjectionStore {
    /**
     * Record received server events into the local projection.
     * @param events list of server events to record
     */
    void recordEvents(List<ServerEvent> events);

    /**
     * Returns the last known server event id the local projection has observed.
     */
    long getLastKnownServerEventId();

    /**
     * Returns a list of all recorded server events (implementation may return a copy).
     */
    List<ServerEvent> getAllEvents();
}
