package com.nagada.pulse.protocol;

/**
 * Exception thrown when protocol validation fails.
 * May occur during deserialization or when protocol constraints are violated.
 */
public class ValidationException extends Exception {
    public ValidationException(String message) {
        super(message);
    }

    public ValidationException(String message, Throwable cause) {
        super(message, cause);
    }
}
