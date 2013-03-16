/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package alpha;

import Controllers.Canon;
import static edsdk.a.EdSdkLibrary.kEdsPropID_Av;
import static edsdk.a.EdSdkLibrary.kEdsPropID_ISOSpeed;
import static edsdk.a.EdSdkLibrary.kEdsPropID_Tv;
import static edsdk.a.EdSdkLibrary.kEdsPropID_WhiteBalance;
import com.googlecode.javacv.FrameGrabber.Exception;
import edsdk.utils.CanonCamera;
import java.awt.Cursor;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.ItemEvent;
import java.awt.event.ItemListener;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.AbstractButton;
import javax.swing.JComponent;
import javax.swing.JFileChooser;
import javax.swing.JMenu;
import javax.swing.JMenuBar;
import javax.swing.JMenuItem;
import javax.swing.JPopupMenu;
import javax.swing.JToggleButton;
import javax.swing.SwingConstants;
import javax.swing.event.PopupMenuEvent;
import javax.swing.event.PopupMenuListener;

/**
 *
 * @author Christopher Williams
 */
public class Toolbar {

    protected static JFileChooser c = new JFileChooser();
    final JMenuBar toolBar = new JMenuBar();
    //Settings
    JMenuItem vidsets = new JMenuItem("Video Settings");
    JMenu cam = new JMenu("Camera Settings");
    JMenuItem soundsettings = new JMenuItem("Audio Settings");
    //File
    JMenuItem openfile = new JMenuItem("Open Project");
    JMenuItem scene = new JMenuItem("New Scene");
    JMenu swscene = new JMenu("Switch Scenes");
    JMenuItem save = new JMenuItem("Save");
    JMenuItem saveas = new JMenuItem("New Project");
    JMenuItem exit = new JMenuItem("exit");
    JMenuItem export = new JMenuItem("Export");
    //Tools
    JMenuItem capwin = new JMenuItem("Capture Window");
    JMenuItem photo = new JMenuItem("Image Editor");
    JMenuItem video = new JMenuItem("Video Editor");
    //Help
    JMenuItem about = new JMenuItem("About...");
    JMenuItem mshelp = new JMenuItem("Help");
    //cascades
    JMenuItem s = new JMenuItem("Scene 1");
    JMenuItem canonControls = new JMenuItem("Canon Controller");
    JMenuItem nikonControls = new JMenuItem("Nikon Controller");
    JMenuItem webcamControls = new JMenuItem("Webcam Controller");

    public Toolbar() {

        cam.add(canonControls);
        cam.add(nikonControls);
        cam.add(webcamControls);
        swscene.add(s);
        toolBar.add(createMoreButton());
        toolBar.add(createPrograms());
        toolBar.add(createSettings());
        toolBar.add(createHelp());

        actionMethod();
    }

    //scene adding algorithm
    private void addMenuItem() {
        JMenuItem s = new JMenuItem("Scene " + Save_Algorithm.scenenum);
        swscene.add(s);

        s.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent actionevent) {
                
            }
        });
    }

    //Settings menu
    private AbstractButton createSettings() {
        final JToggleButton settingsButton = new JToggleButton("Settings");
        settingsButton.setCursor(Cursor.getPredefinedCursor(Cursor.HAND_CURSOR));
        settingsButton.addItemListener(new ItemListener() {
            public void itemStateChanged(ItemEvent e) {
                if (e.getStateChange() == ItemEvent.SELECTED) {
                    createSettingsMenu((JComponent) e.getSource(), settingsButton);
                }
            }
        });
        settingsButton.setFocusable(false);
        settingsButton.setHorizontalTextPosition(SwingConstants.LEADING);
        return settingsButton;
    }

    //Help menu
    private AbstractButton createHelp() {
        final JToggleButton helpButton = new JToggleButton("Help");
        helpButton.setCursor(Cursor.getPredefinedCursor(Cursor.HAND_CURSOR));
        helpButton.addItemListener(new ItemListener() {
            public void itemStateChanged(ItemEvent e) {
                if (e.getStateChange() == ItemEvent.SELECTED) {
                    createHelpMenu((JComponent) e.getSource(), helpButton);
                }
            }
        });
        helpButton.setFocusable(false);
        helpButton.setHorizontalTextPosition(SwingConstants.LEADING);
        return helpButton;
    }

    //File menu
    private AbstractButton createMoreButton() {
        final JToggleButton moreButton = new JToggleButton("File");
        moreButton.setCursor(Cursor.getPredefinedCursor(Cursor.HAND_CURSOR));
        moreButton.addItemListener(new ItemListener() {
            public void itemStateChanged(ItemEvent e) {
                if (e.getStateChange() == ItemEvent.SELECTED) {
                    createAndShowMenu((JComponent) e.getSource(), moreButton);
                }
            }
        });
        moreButton.setFocusable(false);
        moreButton.setHorizontalTextPosition(SwingConstants.LEADING);
        return moreButton;
    }

    //Tools menu
    private AbstractButton createPrograms() {
        final JToggleButton programs = new JToggleButton("Tools");
        programs.setCursor(Cursor.getPredefinedCursor(Cursor.HAND_CURSOR));
        programs.addItemListener(new ItemListener() {
            public void itemStateChanged(ItemEvent e) {
                if (e.getStateChange() == ItemEvent.SELECTED) {
                    createProgramsMenu((JComponent) e.getSource(), programs);
                }
            }
        });
        programs.setFocusable(false);
        programs.setHorizontalTextPosition(SwingConstants.LEADING);
        return programs;
    }

    //Help menu list
    private void createHelpMenu(final JComponent component, final AbstractButton moreButton) {
        JPopupMenu menu = new JPopupMenu();
        menu.add(about);
        menu.add(mshelp);

        menu.addPopupMenuListener(new PopupMenuListener() {
            public void popupMenuWillBecomeVisible(PopupMenuEvent e) {
            }

            public void popupMenuWillBecomeInvisible(PopupMenuEvent e) {
                moreButton.setSelected(false);
            }

            public void popupMenuCanceled(PopupMenuEvent e) {
                moreButton.setSelected(false);
            }
        });

        menu.show(component, 0, component.getHeight());
    }

    //Settings menu list
    private void createSettingsMenu(final JComponent component, final AbstractButton moreButton) {
        JPopupMenu menu = new JPopupMenu();
        menu.add(vidsets);
        menu.add(cam);
        menu.add(soundsettings);

        menu.addPopupMenuListener(new PopupMenuListener() {
            public void popupMenuWillBecomeVisible(PopupMenuEvent e) {
            }

            public void popupMenuWillBecomeInvisible(PopupMenuEvent e) {
                moreButton.setSelected(false);
            }

            public void popupMenuCanceled(PopupMenuEvent e) {
                moreButton.setSelected(false);
            }
        });
        menu.show(component, 0, component.getHeight());
    }

    //File menu list
    private void createAndShowMenu(final JComponent component, final AbstractButton moreButton) {
        JPopupMenu menu = new JPopupMenu();
        menu.add(openfile);
        menu.add(save);
        menu.add(saveas);
        menu.add(swscene);
        menu.add(scene);
        menu.add(export);
        menu.add(exit);

        menu.addPopupMenuListener(new PopupMenuListener() {
            public void popupMenuWillBecomeVisible(PopupMenuEvent e) {
            }

            public void popupMenuWillBecomeInvisible(PopupMenuEvent e) {
                moreButton.setSelected(false);
            }

            public void popupMenuCanceled(PopupMenuEvent e) {
                moreButton.setSelected(false);
            }
        });

        menu.show(component, 0, component.getHeight());
    }

    //Programs menu list
    private void createProgramsMenu(final JComponent component, final AbstractButton programs) {
        JPopupMenu menu = new JPopupMenu();
        menu.add(capwin);
        menu.add(photo);
        menu.add(video);

        menu.addPopupMenuListener(new PopupMenuListener() {
            public void popupMenuWillBecomeVisible(PopupMenuEvent e) {
            }

            public void popupMenuWillBecomeInvisible(PopupMenuEvent e) {
                programs.setSelected(false);
            }

            public void popupMenuCanceled(PopupMenuEvent e) {
                programs.setSelected(false);
            }
        });

        menu.show(component, 0, component.getHeight());
    }

    //Actions performed when clicked
    private void actionMethod() {

        canonControls.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent actionevent) {
                new Canon();
            }
        });

        scene.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent action) {
                Save_Algorithm.newScene();
                addMenuItem();
            }
        });


        openfile.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent actionEvent) {
                //add TODO code
            }
        });

        capwin.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent actionEvent) {
                //Camera cam = new Camera();
            }
        });

        vidsets.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent actionEvent) {
                VideoSettings vs = new VideoSettings();
            }
        });

        about.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent actionEvent) {
                //add TODO code
            }
        });

        mshelp.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent actionEvent) {
                Help help = new Help();
            }
        });

        photo.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent actionEvent) {
                Photo_editor pe = new Photo_editor();
            }
        });

        export.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent actionEvent) {
                Configure.loadConfig("settings/config.xml");
                VideoWriter vidwriter = new VideoWriter();
            }
        });

        saveas.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent actionevent) {
                Save_as save_as = new Save_as();
            }
        });

        save.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent actionEvent) {
                try {
                    Save_Algorithm sa = new Save_Algorithm();
                    sa.projectFile("Last Captured Picture", Controls.framename, 1);
                    sa.projectFile("Number of Scenes", Save_Algorithm.scenenum, 1);
                    sa.projectFile("Shutter Speed", 1, Controls.camera.getProperty(kEdsPropID_Tv));
                    sa.projectFile("F-stop", 1, Controls.camera.getProperty(kEdsPropID_Av));
                    sa.projectFile("ISO", 1, Controls.camera.getProperty(kEdsPropID_ISOSpeed));
                } catch (IOException ex) {
                    Logger.getLogger(Toolbar.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        });

        exit.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent actionEvent) {
                CanonCamera camera = new CanonCamera();
                camera.endLiveView();
                camera.closeSession();
                CanonCamera.close();
                try {
                    Frame.grabber.stop();
                } catch (Exception ex) {
                    Logger.getLogger(Toolbar.class.getName()).log(Level.SEVERE, null, ex);
                }
                System.exit(0);
            }
        });

        video.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent actionEvent) {
                //need to build a video editor
            }
        });
    }
}