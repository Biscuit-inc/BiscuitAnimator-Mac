package edsdk.a;

import com.sun.jna.NativeLong;
import com.sun.jna.Structure;
import edsdk.a.EdSdkLibrary.__EdsObject;

public class EdsSaveImageSetting extends Structure {
    /// C type : EdsUInt32

    public NativeLong JPEGQuality;
    /// C type : EdsStreamRef
    public __EdsObject iccProfileStream;
    /// C type : EdsUInt32
    public NativeLong reserved;

    public EdsSaveImageSetting() {
        super();
        initFieldOrder();
    }

    protected void initFieldOrder() {
        setFieldOrder(new java.lang.String[]{"JPEGQuality", "iccProfileStream", "reserved"});
    }

    /**
     * @param JPEGQuality C type : EdsUInt32<br>
     * @param iccProfileStream C type : EdsStreamRef<br>
     * @param reserved C type : EdsUInt32
     */
    public EdsSaveImageSetting(NativeLong JPEGQuality, __EdsObject iccProfileStream, NativeLong reserved) {
        super();
        this.JPEGQuality = JPEGQuality;
        this.iccProfileStream = iccProfileStream;
        this.reserved = reserved;
        initFieldOrder();
    }

    public static class ByReference extends EdsSaveImageSetting implements Structure.ByReference {
    };

    public static class ByValue extends EdsSaveImageSetting implements Structure.ByValue {
    };
}
