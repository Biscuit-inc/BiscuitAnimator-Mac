/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package alpha;

import com.googlecode.javacv.OpenCVFrameGrabber;
import com.googlecode.javacv.cpp.opencv_core;

/**
 *
 * @author Christopher Williams
 */
//Gets image from webcam camera
public class Frame {

    final static OpenCVFrameGrabber grabber = new OpenCVFrameGrabber(0); //0 for first camera 1 for next etc.

    public opencv_core.IplImage frame() {
        try {
            grabber.start();
            opencv_core.IplImage img = grabber.grab();
            if (img != null) {
                return img;
            }
        } catch (RuntimeException e) {
            throw e;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
