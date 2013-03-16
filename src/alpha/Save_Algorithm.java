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
public class Save_Algorithm {

    Properties prop = new Properties();
    static int scenenum = 1;
    final static File scene = new File(Save_as.pathname + "/scene_1/");
    String path = Save_as.pathname + Save_as.c.getSelectedFile().getName() + ".animation";
    String proj = Save_as.projpath;
    public static File imgdir = new File(scene + "/imgs/");
    public static File audiodir = new File(scene + "/audio/");
    public static File videodir = new File(Save_as.pathname + "/Videos/");
    protected File notes = new File(Save_as.pathname + "/notes/");
    File dir = new File(Save_as.pathname);

    public Save_Algorithm() throws IOException {
        dir.mkdir();
        videodir.mkdir();
        notes.mkdir();
        scene.mkdir();
        imgdir.mkdir();
        audiodir.mkdir();
    }

    //new scene folder
    public static void newScene() {
        scenenum++;
        File nscene = new File(Save_as.pathname + "/scene_" + scenenum + "/");
        File nimgdir = new File(nscene + "/imgs/");
        File naudiodir = new File(nscene + "/audio/");
        nscene.mkdir();
        nimgdir.mkdir();
        naudiodir.mkdir();
    }

    //Create Project File
    public void projectFile(String key, int value, long canonprop) {
        try {
            File file = new File(path);
            boolean exist = file.exists();
            if (!exist) {
                file.createNewFile();
            }
            OutputStream write = new FileOutputStream(path);
            prop.setProperty(key, Integer.toString(value));
            prop.setProperty(key, Long.toString(canonprop));
            prop.setProperty("Path", Integer.toString(1));
            prop.storeToXML(write, "Project Specific Settings");
        } catch (RuntimeException e) {
            throw e;
        } catch (Exception e) {
        }
    }

    //Load project file
    public void loadProj() {
        try {
            InputStream read = new FileInputStream(path);
            prop.loadFromXML(read);
            String fnum = prop.getProperty("Last Captured Picture");
            String snum = prop.getProperty("Number of Scenes");
            System.out.println("Number of Scenes = " + snum);
            System.out.println("Frame Numbers = " + fnum);
            setFrameNum(Integer.parseInt(fnum));
            setSceneNum(Integer.parseInt(snum));
            read.close();
        } catch (FileNotFoundException e) {
        } catch (IOException e) {
        }
    }

    public void setFrameNum(int frame) {
        Controls.framename = frame;
    }

    public void setSceneNum(int scene) {
        scenenum = scene;
    }
}