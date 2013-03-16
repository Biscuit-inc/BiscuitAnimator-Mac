package edsdk.a;

import com.sun.jna.NativeLong;
import com.sun.jna.Structure;

public class EdsDirectoryItemInfo extends Structure {
    /// C type : EdsUInt32

    public NativeLong size;
    /// C type : EdsBool
    public int isFolder;
    /// C type : EdsUInt32
    public NativeLong groupID;
    /// C type : EdsUInt32
    public NativeLong option;
    /// C type : EdsChar[256]
    public byte[] szFileName = new byte[(256)];
    /// C type : EdsUInt32
    public NativeLong format;

    public EdsDirectoryItemInfo() {
        super();
        initFieldOrder();
    }

    protected void initFieldOrder() {
        setFieldOrder(new java.lang.String[]{"size", "isFolder", "groupID", "option", "szFileName", "format"});
    }

    /**
     * @param size C type : EdsUInt32<br>
     * @param isFolder C type : EdsBool<br>
     * @param groupID C type : EdsUInt32<br>
     * @param option C type : EdsUInt32<br>
     * @param szFileName C type : EdsChar[256]<br>
     * @param format C type : EdsUInt32
     */
    public EdsDirectoryItemInfo(NativeLong size, int isFolder, NativeLong groupID, NativeLong option, byte szFileName[], NativeLong format) {
        super();
        this.size = size;
        this.isFolder = isFolder;
        this.groupID = groupID;
        this.option = option;
        if (szFileName.length != this.szFileName.length) {
            throw new IllegalArgumentException("Wrong array size !");
        }
        this.szFileName = szFileName;
        this.format = format;
        initFieldOrder();
    }

    public static class ByReference extends EdsDirectoryItemInfo implements Structure.ByReference {
    };

    public static class ByValue extends EdsDirectoryItemInfo implements Structure.ByValue {
    };
}
