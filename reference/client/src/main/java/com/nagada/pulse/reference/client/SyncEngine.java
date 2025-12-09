package com.nagada.pulse.reference.client;

import com.nagada.pulse.protocol.ClientEvent;
import com.nagada.pulse.protocol.SyncRequest;
import com.nagada.pulse.protocol.SyncResponse;
import java.util.List;

/**
 * Sync engine: orchestrates the heartbeat cycle with server.
 */
public class SyncEngine {

    private final String deviceId;
    private final PendingOutbox outbox;
    private final LocalProjectionStore projectionStore;
    private final SyncTransport transport;
    private final BackoffStrategy backoff;

    public SyncEngine(String deviceId, PendingOutbox outbox, LocalProjectionStore projectionStore, BackoffStrategy backoff) {
        this.deviceId = deviceId;
        this.outbox = outbox;
        this.projectionStore = projectionStore;
        this.transport = null;
        this.backoff = backoff;
    }

    public SyncEngine(String deviceId, PendingOutbox outbox, LocalProjectionStore projectionStore, SyncTransport transport) {
        this.deviceId = deviceId;
        this.outbox = outbox;
        this.projectionStore = projectionStore;
        this.transport = transport;
        this.backoff = new BackoffStrategy();
    }

    /**
     * Build a sync request from current state.
     */
    public SyncRequest buildSyncRequest() {
        return new SyncRequest(
            deviceId,
            outbox.drainPending(),
            projectionStore.getLastKnownServerEventId()
        );
    }

    /**
     * Record received events in local projection.
     */
    public void recordResponse(SyncResponse response) {
        if (response != null && response.newServerEvents != null) {
            projectionStore.recordEvents(response.newServerEvents);
        }
    }

    /**
     * Perform a single heartbeat sync: send pending, receive new.
     */
    public void sync() throws Exception {
        try {
            SyncRequest request = buildSyncRequest();
            SyncResponse response = transport.sync(request);
            recordResponse(response);
            backoff.reset();
        } catch (Exception e) {
            backoff.waitBeforeRetry();
            throw e;
        }
    }

    /**
     * Public interface for transport.
     */
    public interface SyncTransport {
        SyncResponse sync(SyncRequest request) throws Exception;
    }
}
