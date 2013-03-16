package edsdk.a;

import com.sun.jna.NativeLong;
import com.sun.jna.Structure;

public class EdsPoint extends Structure {
    /// C type : EdsInt32

    public NativeLong x;
    /// C type : EdsInt32
    public NativeLong y;

    public EdsPoint() {
        super();
        initFieldOrder();
    }

    protected void initFieldOrder() {
        setFieldOrder(new java.lang.String[]{"x", "y"});
    }

    /**
     * @param x C type : EdsInt32<br>
     * @param y C type : EdsInt32
     */
    public EdsPoint(NativeLong x, NativeLong y) {
        super();
        this.x = x;
        this.y = y;
        initFieldOrder();
    }

    public static class ByReference extends EdsPoint implements Structure.ByReference {
    };

    public static class ByValue extends EdsPoint implements Structure.ByValue {
    };
}
