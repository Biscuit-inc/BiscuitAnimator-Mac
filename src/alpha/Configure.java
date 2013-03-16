/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package alpha;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Properties;

/**
 *
 * @author Christopher Williams
 */
public class Configure {

    static Properties prop = new Properties();
    static String path = "settings/config.xml";
    VideoWriter vw = new VideoWriter();

    public static void saveConfigStrings(String key, String string) {
        try {
            File file = new File(path);
            boolean exist = file.exists();
            if (!exist) {
                file.createNewFile();
            }
            OutputStream write = new FileOutputStream(path);
            prop.setProperty(key, string);
            prop.storeToXML(write, "Frames per Second");
        } catch (RuntimeException e) {
            throw e;
        } catch (Exception e) {
        }
    }

    public static void saveConfigInts(String key, int value) {
        try {
            File file = new File(path);
            boolean exist = file.exists();
            if (!exist) {
                file.createNewFile();
            }
            OutputStream write = new FileOutputStream(path);
            prop.setProperty(key, Integer.toString(value));
            prop.storeToXML(write, "Frames per Second");
        } catch (RuntimeException e) {
            throw e;
        } catch (Exception e) {
        }
    }

    //Loads the XML when you export each time
    protected static void loadConfig(String path) {
        try {
            InputStream read = new FileInputStream(path);
            prop.loadFromXML(read);
            String fps = prop.getProperty("fps");
            String width = prop.getProperty("Width");
            String height = prop.getProperty("Height");
            String format = prop.getProperty("Video file Format");
            System.out.println("Frame rate selected = " + fps);
            System.out.println("Width: " + width);
            System.out.println("Height: " + height);
            System.out.println("File Format: " + format);
            setFormat(format);
            setWidth(Integer.parseInt(width));
            setHeight(Integer.parseInt(height));
            setFPS(Float.parseFloat(fps));
            read.close();
        } catch (FileNotFoundException e) {
        } catch (IOException e) {
        }
    }

    protected static String setFormat(String f) {
        VideoWriter.videoFormat = f;
        return f;
    }

    protected static int setWidth(int w) {
        VideoWriter.videoWidth = w;
        return w;
    }

    protected static int setHeight(int h) {
        VideoWriter.videoHeight = h;
        return h;
    }

    protected static void setFPS(float FPS) {
        if (FPS == 10) {
            VideoWriter.fpsselection = 0;
        }
        if (FPS == 12) {
            VideoWriter.fpsselection = 1;
        }

        if (FPS == 15) {
            VideoWriter.fpsselection = 2;
        }

        if (FPS == 20) {
            VideoWriter.fpsselection = 3;
        }

        if (FPS == 24) {
            VideoWriter.fpsselection = 4;
        }

        if (FPS == 30) {
            VideoWriter.fpsselection = 5;
        }
    }
}
