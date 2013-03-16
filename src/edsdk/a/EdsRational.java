package edsdk.a;

import com.sun.jna.NativeLong;
import com.sun.jna.Structure;

public class EdsRational extends Structure {
    /// C type : EdsInt32

    public NativeLong numerator;
    /// C type : EdsUInt32
    public NativeLong denominator;

    public EdsRational() {
        super();
        initFieldOrder();
    }

    protected void initFieldOrder() {
        setFieldOrder(new java.lang.String[]{"numerator", "denominator"});
    }

    /**
     * @param numerator C type : EdsInt32<br>
     * @param denominator C type : EdsUInt32
     */
    public EdsRational(NativeLong numerator, NativeLong denominator) {
        super();
        this.numerator = numerator;
        this.denominator = denominator;
        initFieldOrder();
    }

    public static class ByReference extends EdsRational implements Structure.ByReference {
    };

    public static class ByValue extends EdsRational implements Structure.ByValue {
    };
}
