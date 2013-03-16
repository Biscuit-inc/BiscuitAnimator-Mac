package edsdk.a;

import com.sun.jna.NativeLong;
import com.sun.jna.Structure;

public class EdsVolumeInfo extends Structure {
    /// C type : EdsUInt32

    public NativeLong storageType;
    /// C type : EdsAccess
    public int access;
    /// C type : EdsUInt64
    public long maxCapacity;
    /// C type : EdsUInt64
    public long freeSpaceInBytes;
    /// C type : EdsChar[256]
    public byte[] szVolumeLabel = new byte[(256)];

    public EdsVolumeInfo() {
        super();
        initFieldOrder();
    }

    protected void initFieldOrder() {
        setFieldOrder(new java.lang.String[]{"storageType", "access", "maxCapacity", "freeSpaceInBytes", "szVolumeLabel"});
    }

    /**
     * @param storageType C type : EdsUInt32<br>
     * @param access C type : EdsAccess<br>
     * @param maxCapacity C type : EdsUInt64<br>
     * @param freeSpaceInBytes C type : EdsUInt64<br>
     * @param szVolumeLabel C type : EdsChar[256]
     */
    public EdsVolumeInfo(NativeLong storageType, int access, long maxCapacity, long freeSpaceInBytes, byte szVolumeLabel[]) {
        super();
        this.storageType = storageType;
        this.access = access;
        this.maxCapacity = maxCapacity;
        this.freeSpaceInBytes = freeSpaceInBytes;
        if (szVolumeLabel.length != this.szVolumeLabel.length) {
            throw new IllegalArgumentException("Wrong array size !");
        }
        this.szVolumeLabel = szVolumeLabel;
        initFieldOrder();
    }

    public static class ByReference extends EdsVolumeInfo implements Structure.ByReference {
    };

    public static class ByValue extends EdsVolumeInfo implements Structure.ByValue {
    };
}
