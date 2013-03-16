/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package alpha;

import java.awt.Choice;
import java.awt.Rectangle;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextField;
import javax.swing.UIManager;

/**
 *
 * @author Christopher Williams
 */
//Not Functional Yet
public class VideoSettings extends JFrame {

    private JLabel lfps, vidw, vidh, vidf;
    private JButton ok;
    JPanel settings = new JPanel();
    private int width = 640;
    private int height = 480;
    private Choice fps = new Choice();
    private JTextField videowidth = new JTextField("1280");
    private JTextField videoheight = new JTextField("720");
    private Choice videoformat = new Choice();
    private Rectangle rok;

    public VideoSettings() {
        try {
            UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
        } catch (RuntimeException e) {
            throw e;
        } catch (Exception e) {
            e.printStackTrace();
        }
        setUndecorated(false);
        getContentPane().add(settings);
        setTitle("Settings");
        setSize(width, height);
        setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        setLocationRelativeTo(null);
        setResizable(true);
        setVisible(true);
        settings.setLayout(null);

        JLabel();
        drawbuttons();
        repaint();
    }

    private void JLabel() {
        lfps = new JLabel("FPS");
        lfps.setBounds(30, 10, 80, 25);
        settings.add(lfps);

        vidw = new JLabel("Video Width");
        vidw.setBounds(120, 10, 80, 25);
        settings.add(vidw);

        vidh = new JLabel("Video Height");
        vidh.setBounds(200, 10, 80, 25);
        settings.add(vidh);

        vidf = new JLabel("Video Format");
        vidf.setBounds(290, 10, 80, 25);
        settings.add(vidf);
    }

    private void drawbuttons() {

        ok = new JButton("Save");
        rok = new Rectangle((width / 2) - 50, 400, 80, 25);
        ok.setBounds(rok);
        settings.add(ok);

        fps.setBounds(30, 40, 80, 25);
        fps.add("10");
        fps.add("12");
        fps.add("15");
        fps.add("24");
        fps.add("30");
        fps.select(2);
        settings.add(fps);

        videowidth.setBounds(120, 40, 70, 20);
        settings.add(videowidth);

        videoheight.setBounds(200, 40, 70, 20);
        settings.add(videoheight);

        videoformat.setBounds(290, 40, 80, 25);
        videoformat.add("avi");
        videoformat.add("wmv");
        videoformat.add("mov");
        videoformat.select(1);
        settings.add(videoformat);

        ok.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent a) {
                int width = Integer.parseInt(videowidth.getText());
                int height = Integer.parseInt(videoheight.getText());
                int format = videoformat.getSelectedIndex();
                int fpsselection = fps.getSelectedIndex();
                int f = 0;
                String formatstring = ".wmv";

                if (format == 0) {
                    formatstring = ".avi";
                }

                if (format == 1 || format == -1) {
                    formatstring = ".wmv";
                }

                if (format == 2) {
                    formatstring = ".mov";
                }

                if (fpsselection == 0) {
                    f = 10;
                }

                if (fpsselection == 1 || fpsselection == -1) {
                    f = 12;
                }

                if (fpsselection == 2) {
                    f = 15;
                }

                if (fpsselection == 3) {
                    f = 24;
                }

                if (fpsselection == 4) {
                    f = 30;
                }

                Configure.saveConfigStrings("Video file Format", formatstring);
                Configure.saveConfigInts("fps", f);
                Configure.saveConfigInts("Width", width);
                Configure.saveConfigInts("Height", height);
                dispose();
            }
        });
    }
}
