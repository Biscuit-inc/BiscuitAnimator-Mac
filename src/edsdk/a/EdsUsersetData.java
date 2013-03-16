package edsdk.a;

import com.sun.jna.NativeLong;
import com.sun.jna.Structure;

public class EdsUsersetData extends Structure {
    /// C type : EdsUInt32

    public NativeLong valid;
    /// C type : EdsUInt32
    public NativeLong dataSize;
    /// C type : EdsChar[32]
    public byte[] szCaption = new byte[(32)];
    /// C type : EdsUInt8[1]
    public byte[] data = new byte[(1)];

    public EdsUsersetData() {
        super();
        initFieldOrder();
    }

    protected void initFieldOrder() {
        setFieldOrder(new java.lang.String[]{"valid", "dataSize", "szCaption", "data"});
    }

    /**
     * @param valid C type : EdsUInt32<br>
     * @param dataSize C type : EdsUInt32<br>
     * @param szCaption C type : EdsChar[32]<br>
     * @param data C type : EdsUInt8[1]
     */
    public EdsUsersetData(NativeLong valid, NativeLong dataSize, byte szCaption[], byte data[]) {
        super();
        this.valid = valid;
        this.dataSize = dataSize;
        if (szCaption.length != this.szCaption.length) {
            throw new IllegalArgumentException("Wrong array size !");
        }
        this.szCaption = szCaption;
        if (data.length != this.data.length) {
            throw new IllegalArgumentException("Wrong array size !");
        }
        this.data = data;
        initFieldOrder();
    }

    public static class ByReference extends EdsUsersetData implements Structure.ByReference {
    };

    public static class ByValue extends EdsUsersetData implements Structure.ByValue {
    };
}
