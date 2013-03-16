package edsdk.a;

import com.sun.jna.NativeLong;
import com.sun.jna.Structure;

public class EdsTime extends Structure {
    /// C type : EdsUInt32

    public NativeLong year;
    /// C type : EdsUInt32
    public NativeLong month;
    /// C type : EdsUInt32
    public NativeLong day;
    /// C type : EdsUInt32
    public NativeLong hour;
    /// C type : EdsUInt32
    public NativeLong minute;
    /// C type : EdsUInt32
    public NativeLong second;
    /// C type : EdsUInt32
    public NativeLong milliseconds;

    public EdsTime() {
        super();
        initFieldOrder();
    }

    protected void initFieldOrder() {
        setFieldOrder(new java.lang.String[]{"year", "month", "day", "hour", "minute", "second", "milliseconds"});
    }

    /**
     * @param year C type : EdsUInt32<br>
     * @param month C type : EdsUInt32<br>
     * @param day C type : EdsUInt32<br>
     * @param hour C type : EdsUInt32<br>
     * @param minute C type : EdsUInt32<br>
     * @param second C type : EdsUInt32<br>
     * @param milliseconds C type : EdsUInt32
     */
    public EdsTime(NativeLong year, NativeLong month, NativeLong day, NativeLong hour, NativeLong minute, NativeLong second, NativeLong milliseconds) {
        super();
        this.year = year;
        this.month = month;
        this.day = day;
        this.hour = hour;
        this.minute = minute;
        this.second = second;
        this.milliseconds = milliseconds;
        initFieldOrder();
    }

    public static class ByReference extends EdsTime implements Structure.ByReference {
    };

    public static class ByValue extends EdsTime implements Structure.ByValue {
    };
}
