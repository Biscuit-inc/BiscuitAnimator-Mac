package edsdk.a;

import com.sun.jna.NativeLong;
import com.sun.jna.Structure;

public class EdsFocusPoint extends Structure {
    /// C type : EdsUInt32

    public NativeLong valid;
    /// C type : EdsUInt32
    public NativeLong selected;
    /// C type : EdsUInt32
    public NativeLong justFocus;
    /// C type : EdsRect
    public EdsRect rect;
    /// C type : EdsUInt32
    public NativeLong reserved;

    public EdsFocusPoint() {
        super();
        initFieldOrder();
    }

    protected void initFieldOrder() {
        setFieldOrder(new java.lang.String[]{"valid", "selected", "justFocus", "rect", "reserved"});
    }

    /**
     * @param valid C type : EdsUInt32<br>
     * @param selected C type : EdsUInt32<br>
     * @param justFocus C type : EdsUInt32<br>
     * @param rect C type : EdsRect<br>
     * @param reserved C type : EdsUInt32
     */
    public EdsFocusPoint(NativeLong valid, NativeLong selected, NativeLong justFocus, EdsRect rect, NativeLong reserved) {
        super();
        this.valid = valid;
        this.selected = selected;
        this.justFocus = justFocus;
        this.rect = rect;
        this.reserved = reserved;
        initFieldOrder();
    }

    public static class ByReference extends EdsFocusPoint implements Structure.ByReference {
    };

    public static class ByValue extends EdsFocusPoint implements Structure.ByValue {
    };
}
