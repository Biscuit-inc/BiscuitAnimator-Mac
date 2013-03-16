package edsdk.a;

import com.sun.jna.Pointer;
import com.sun.jna.Structure;
import com.sun.jna.ptr.NativeLongByReference;

public class EdsIStream extends Structure {
    /// C type : void*

    public Pointer context;
    /// C type : EdsReadStream*
    public NativeLongByReference read;
    /// C type : EdsWriteStream*
    public NativeLongByReference write;
    /// C type : EdsSeekStream*
    public NativeLongByReference seek;
    /// C type : EdsTellStream*
    public NativeLongByReference tell;
    /// C type : EdsGetStreamLength*
    public NativeLongByReference getLength;

    public EdsIStream() {
        super();
        initFieldOrder();
    }

    protected void initFieldOrder() {
        setFieldOrder(new java.lang.String[]{"context", "read", "write", "seek", "tell", "getLength"});
    }

    /**
     * @param context C type : void*<br>
     * @param read C type : EdsReadStream*<br>
     * @param write C type : EdsWriteStream*<br>
     * @param seek C type : EdsSeekStream*<br>
     * @param tell C type : EdsTellStream*<br>
     * @param getLength C type : EdsGetStreamLength*
     */
    public EdsIStream(Pointer context, NativeLongByReference read, NativeLongByReference write, NativeLongByReference seek, NativeLongByReference tell, NativeLongByReference getLength) {
        super();
        this.context = context;
        this.read = read;
        this.write = write;
        this.seek = seek;
        this.tell = tell;
        this.getLength = getLength;
        initFieldOrder();
    }

    public static class ByReference extends EdsIStream implements Structure.ByReference {
    };

    public static class ByValue extends EdsIStream implements Structure.ByValue {
    };
}
