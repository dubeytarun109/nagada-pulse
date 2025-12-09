package com.nagada.pulse.reference.http;

import com.nagada.pulse.protocol.ClientEvent;
import com.nagada.pulse.protocol.SyncRequest;
import com.nagada.pulse.protocol.SyncResponse;
import com.nagada.pulse.reference.server.SyncHandler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * REST controller that exposes the sync protocol over HTTP.
 * Maps incoming HTTP JSON requests to SyncRequest messages and delegates
 * to the core SyncHandler for protocol processing.
 */
@RestController
@RequestMapping("/api/v1/sync")
public class SyncController {

    private final SyncHandler syncHandler;

    @Autowired
    public SyncController(SyncHandler syncHandler) {
        this.syncHandler = syncHandler;
    }

    /**
     * POST /api/v1/sync
     * Receives a SyncRequest containing:
     * - deviceId: unique client identifier
     * - pendingEvents: list of ClientEvent objects to acknowledge
     * - lastKnownServerEventId: the highest server event ID the client has seen
     *
     * Returns a SyncResponse containing:
     * - ackedClientEventIds: server confirms receipt of these client events
     * - newServerEvents: server broadcasts these events to this device
     */
    @PostMapping
    public SyncResponse sync(@RequestBody SyncRequest request) {
        return syncHandler.handle(request);
    }

    /**
     * GET /api/v1/sync/health
     * Simple health check endpoint.
     */
    @GetMapping("/health")
    public String health() {
        return "OK";
    }
}
