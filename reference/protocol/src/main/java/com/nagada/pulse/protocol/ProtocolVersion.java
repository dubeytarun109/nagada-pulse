package com.nagada.pulse.protocol;

/**
 * Semantic versioning metadata for the Nagada Pulse Sync protocol.
 * Allows clients and servers to negotiate protocol compatibility.
 */
public class ProtocolVersion {
    private final int major;
    private final int minor;
    private final int patch;

    public ProtocolVersion(int major, int minor, int patch) {
        this.major = major;
        this.minor = minor;
        this.patch = patch;
    }

    public int getMajor() {
        return major;
    }

    public int getMinor() {
        return minor;
    }

    public int getPatch() {
        return patch;
    }

    /**
     * Returns true if this version is compatible with the given version.
     * Compatible if same major version.
     */
    public boolean isCompatibleWith(ProtocolVersion other) {
        return this.major == other.major;
    }

    @Override
    public String toString() {
        return major + "." + minor + "." + patch;
    }
}
