package edsdk.a;

import com.sun.jna.NativeLong;
import com.sun.jna.Structure;

public class EdsSize extends Structure {
    /// C type : EdsInt32

    public NativeLong width;
    /// C type : EdsInt32
    public NativeLong height;

    public EdsSize() {
        super();
        initFieldOrder();
    }

    protected void initFieldOrder() {
        setFieldOrder(new java.lang.String[]{"width", "height"});
    }

    /**
     * @param width C type : EdsInt32<br>
     * @param height C type : EdsInt32
     */
    public EdsSize(NativeLong width, NativeLong height) {
        super();
        this.width = width;
        this.height = height;
        initFieldOrder();
    }

    public static class ByReference extends EdsSize implements Structure.ByReference {
    };

    public static class ByValue extends EdsSize implements Structure.ByValue {
    };
}
