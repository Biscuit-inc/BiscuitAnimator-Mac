package edsdk.utils.commands;

import com.sun.jna.NativeLong;
import edsdk.a.EdSdkLibrary;
import edsdk.a.EdSdkLibrary.EdsVoid;
import edsdk.a.EdSdkLibrary.__EdsObject;
import edsdk.utils.CanonTask;
import edsdk.utils.CanonUtils;
import java.io.File;

/**
 * Takes an image and downloads it to the file system
 *
 * @author Christopher Williams
 *
 */
public class ShootTask extends CanonTask<File> {

    private File dest = null;

    public ShootTask() {
    }

    public ShootTask(File dest) {
        this.dest = dest;
    }

    @Override
    public void run() {
        int result = -1;
        while (result != EdSdkLibrary.EDS_ERR_OK) {
            System.out.println("Trying to take image...");
            result = sendCommand(EdSdkLibrary.kEdsCameraCommand_TakePicture, 0);
            System.out.println("result= " + result + ", might mean " + CanonUtils.toString(result));
            try {
                Thread.sleep(1000);
            } catch (InterruptedException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        System.out.println("Took image, waiting for file");
        notYetFinished();
    }

    @Override
    public NativeLong apply(NativeLong inEvent, __EdsObject inRef, EdsVoid inContext) {
        if (inEvent.intValue() == EdSdkLibrary.kEdsObjectEvent_DirItemCreated) {
            System.out.println("Picture taken!");
            setResult(CanonUtils.download(inRef, dest, false));
            finish();
        }

        return null;
    }
}
