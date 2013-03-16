///*
// * To change this template, choose Tools | Templates
// * and open the template in the editor.
// */
package alpha;

import com.googlecode.javacv.FFmpegFrameRecorder;
import com.googlecode.javacv.cpp.opencv_core;
import static com.googlecode.javacv.cpp.opencv_highgui.*;

///**
// *
// * @author Christopher Williams
// */
public class VideoWriter {

    private int CODEC_ID_H264;
    private int PIX_FMT_YUV420P;
    public static float fpsselection = 2;
    private float FPS = 15;
    protected static int videoWidth = 1280;
    protected static int videoHeight = 720;
    protected static String videoFormat = ".wmv";

    public VideoWriter() {
        writer();
    }

    public float getFPS() {
        if (fpsselection == 0) {
            FPS = 10;
        }
        if (fpsselection == 1 || fpsselection == -1) {
            FPS = 12;
        }
        if (fpsselection == 2) {
            FPS = 15;
        }
        if (fpsselection == 3) {
            FPS = 20;
        }
        if (fpsselection == 4) {
            FPS = 24;
        }
        if (fpsselection == 5) {
            FPS = 30;
        }
        return FPS;
    }

    private void writer() {
        FFmpegFrameRecorder recorder = new FFmpegFrameRecorder(Save_Algorithm.videodir + "/test" + videoFormat, videoWidth, videoHeight);
        try {
            recorder.setVideoCodec(CODEC_ID_H264);
            recorder.setPixelFormat(PIX_FMT_YUV420P);
            recorder.setFrameRate(FPS);
            recorder.setFormat("wmv");
            recorder.start();
            for (int i = 0; i < Controls.framename; i++) {
                opencv_core.IplImage images = cvLoadImage(Save_Algorithm.imgdir + "/image_" + i + ".tiff");
                recorder.record(images);
                System.out.println("Recording");
                System.out.println("FPS: " + getFPS());
            }
            recorder.stop();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
