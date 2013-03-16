package edsdk.a;

import com.sun.jna.NativeLong;
import com.sun.jna.Structure;

public class EdsCapacity extends Structure {
    /// C type : EdsInt32

    public NativeLong numberOfFreeClusters;
    /// C type : EdsInt32
    public NativeLong bytesPerSector;
    /// C type : EdsBool
    public int reset;

    public EdsCapacity() {
        super();
        initFieldOrder();
    }

    protected void initFieldOrder() {
        setFieldOrder(new java.lang.String[]{"numberOfFreeClusters", "bytesPerSector", "reset"});
    }

    /**
     * @param numberOfFreeClusters C type : EdsInt32<br>
     * @param bytesPerSector C type : EdsInt32<br>
     * @param reset C type : EdsBool
     */
    public EdsCapacity(NativeLong numberOfFreeClusters, NativeLong bytesPerSector, int reset) {
        super();
        this.numberOfFreeClusters = numberOfFreeClusters;
        this.bytesPerSector = bytesPerSector;
        this.reset = reset;
        initFieldOrder();
    }

    public static class ByReference extends EdsCapacity implements Structure.ByReference {
    };

    public static class ByValue extends EdsCapacity implements Structure.ByValue {
    };
}
