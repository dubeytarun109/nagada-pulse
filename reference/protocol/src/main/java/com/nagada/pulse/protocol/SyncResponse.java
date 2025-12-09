package com.nagada.pulse.protocol;

import java.util.List;

/**
 * Sync response from server: acknowledgments + new server events.
 */
public class SyncResponse {
    public List<String> ackedClientEventIds;
    public List<ServerEvent> newServerEvents;

    public SyncResponse() {
    }

    public SyncResponse(List<String> ackedClientEventIds, List<ServerEvent> newServerEvents) {
        this.ackedClientEventIds = ackedClientEventIds;
        this.newServerEvents = newServerEvents;
    }
    //add getters 
    public List<String> getAckedClientEventIds() {
        return ackedClientEventIds;
    }
    public List<ServerEvent> getNewServerEvents() {
        return newServerEvents;
    }
}
