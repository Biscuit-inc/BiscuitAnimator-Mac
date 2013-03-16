package alpha;

import com.googlecode.javacv.CanvasFrame;
import com.googlecode.javacv.cpp.opencv_core.IplImage;
import java.awt.BorderLayout;
import javax.swing.JPanel;

//Rewrite for dual monitor ease of use
public class ExtcapWindow extends JPanel implements Runnable {

    Frame frame = new Frame();
    //Without using canvas frame because it sucks
    public static final CanvasFrame canvas = new CanvasFrame("");
    IplImage imgcheck = frame.frame();

    public ExtcapWindow() {
        setLayout(new BorderLayout());
        canvas.setDefaultCloseOperation(javax.swing.JFrame.EXIT_ON_CLOSE);
        error_Check();
        while (true) {
            try {
                System.setProperty("sun.java2d.opengl", "True");
                IplImage img = frame.frame();
                canvas.showImage(img);
            } catch (RuntimeException e) {
                throw e;
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    private void error_Check() {
        if (imgcheck == null) {
            NoCam_Error noCam_Error = new NoCam_Error();
        }
    }

    @Override
    public void run() {
        throw new UnsupportedOperationException("Not supported yet.");
    }
}