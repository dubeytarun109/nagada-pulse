package com.nagada.pulse.protocol;

/**
 * Minimal client-side event: opaque payload + client-assigned ID for idempotency.
 */
public class ClientEvent {
    private String clientEventId;
    private String type;
    private byte[] payload;

    public ClientEvent(String clientEventId, String type , byte[] payload) {
        this.clientEventId = clientEventId;
        this.type = type;
        this.payload = payload;
    }

    private ClientEvent() {
        // for deserialization
    }

    public String getType() {
        return type;
    }

    public String getClientEventId() {
        return clientEventId;
    }

    public byte[] getPayload() {
        return payload;
    }
}
