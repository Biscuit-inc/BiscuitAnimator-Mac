package edsdk.a;

import com.sun.jna.NativeLong;
import com.sun.jna.Structure;

public class EdsPictureStyleDesc extends Structure {
    /// C type : EdsInt32

    public NativeLong contrast;
    /// C type : EdsUInt32
    public NativeLong sharpness;
    /// C type : EdsInt32
    public NativeLong saturation;
    /// C type : EdsInt32
    public NativeLong colorTone;
    /// C type : EdsUInt32
    public NativeLong filterEffect;
    /// C type : EdsUInt32
    public NativeLong toningEffect;

    public EdsPictureStyleDesc() {
        super();
        initFieldOrder();
    }

    protected void initFieldOrder() {
        setFieldOrder(new java.lang.String[]{"contrast", "sharpness", "saturation", "colorTone", "filterEffect", "toningEffect"});
    }

    /**
     * @param contrast C type : EdsInt32<br>
     * @param sharpness C type : EdsUInt32<br>
     * @param saturation C type : EdsInt32<br>
     * @param colorTone C type : EdsInt32<br>
     * @param filterEffect C type : EdsUInt32<br>
     * @param toningEffect C type : EdsUInt32
     */
    public EdsPictureStyleDesc(NativeLong contrast, NativeLong sharpness, NativeLong saturation, NativeLong colorTone, NativeLong filterEffect, NativeLong toningEffect) {
        super();
        this.contrast = contrast;
        this.sharpness = sharpness;
        this.saturation = saturation;
        this.colorTone = colorTone;
        this.filterEffect = filterEffect;
        this.toningEffect = toningEffect;
        initFieldOrder();
    }

    public static class ByReference extends EdsPictureStyleDesc implements Structure.ByReference {
    };

    public static class ByValue extends EdsPictureStyleDesc implements Structure.ByValue {
    };
}
