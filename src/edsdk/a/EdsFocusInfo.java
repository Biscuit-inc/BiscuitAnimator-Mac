package edsdk.a;

import com.sun.jna.NativeLong;
import com.sun.jna.Structure;

public class EdsFocusInfo extends Structure {
    /// C type : EdsRect

    public EdsRect imageRect;
    /// C type : EdsUInt32
    public NativeLong pointNumber;
    /// C type : EdsFocusPoint[128]
    public EdsFocusPoint[] focusPoint = new EdsFocusPoint[(128)];
    /// C type : EdsUInt32
    public NativeLong executeMode;

    public EdsFocusInfo() {
        super();
        initFieldOrder();
    }

    protected void initFieldOrder() {
        setFieldOrder(new java.lang.String[]{"imageRect", "pointNumber", "focusPoint", "executeMode"});
    }

    /**
     * @param imageRect C type : EdsRect<br>
     * @param pointNumber C type : EdsUInt32<br>
     * @param focusPoint C type : EdsFocusPoint[128]<br>
     * @param executeMode C type : EdsUInt32
     */
    public EdsFocusInfo(EdsRect imageRect, NativeLong pointNumber, EdsFocusPoint focusPoint[], NativeLong executeMode) {
        super();
        this.imageRect = imageRect;
        this.pointNumber = pointNumber;
        if (focusPoint.length != this.focusPoint.length) {
            throw new IllegalArgumentException("Wrong array size !");
        }
        this.focusPoint = focusPoint;
        this.executeMode = executeMode;
        initFieldOrder();
    }

    public static class ByReference extends EdsFocusInfo implements Structure.ByReference {
    };

    public static class ByValue extends EdsFocusInfo implements Structure.ByValue {
    };
}
