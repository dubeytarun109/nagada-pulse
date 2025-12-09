package com.nagada.pulse.protocol;

/**
 * Server-side event: persisted with server-assigned ID and metadata.
 */
public class ServerEvent {
    public long serverEventId;
    public String deviceId;
    public String payload;
    public long createdAt;

    public ServerEvent(long serverEventId, String deviceId, String payload, long createdAt) {
        this.serverEventId = serverEventId;
        this.deviceId = deviceId;
        this.payload = payload;
        this.createdAt = createdAt;
    }

    public ServerEvent() {
    }
    public long getServerEventId() {
        return serverEventId;
    }
    public String getDeviceId() {
        return deviceId;
    }
    public String getPayload() {
        return payload;
    }
    public long getCreatedAt() {
        return createdAt;
    }
}
