package com.nagada.pulse.reference.client;

/**
 * Simple exponential backoff for sync retries.
 */
public class BackoffStrategy {

    private long delayMs = 100;
    private static final long MAX_DELAY = 30000; // 30 seconds
    private static final double MULTIPLIER = 1.5;

    /**
     * Wait before retrying, increasing the delay exponentially.
     */
    public void waitBeforeRetry() throws InterruptedException {
        Thread.sleep(delayMs);
        delayMs = Math.min((long) (delayMs * MULTIPLIER), MAX_DELAY);
    }

    /**
     * Reset backoff (called on successful sync).
     */
    public void reset() {
        delayMs = 100;
    }
}
