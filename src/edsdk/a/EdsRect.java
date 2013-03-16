package edsdk.a;

import com.sun.jna.Structure;

public class EdsRect extends Structure {
    /// C type : EdsPoint

    public EdsPoint point;
    /// C type : EdsSize
    public EdsSize size;

    public EdsRect() {
        super();
        initFieldOrder();
    }

    protected void initFieldOrder() {
        setFieldOrder(new java.lang.String[]{"point", "size"});
    }

    /**
     * @param point C type : EdsPoint<br>
     * @param size C type : EdsSize
     */
    public EdsRect(EdsPoint point, EdsSize size) {
        super();
        this.point = point;
        this.size = size;
        initFieldOrder();
    }

    public static class ByReference extends EdsRect implements Structure.ByReference {
    };

    public static class ByValue extends EdsRect implements Structure.ByValue {
    };
}
