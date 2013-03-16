/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package alpha;

import java.awt.BorderLayout;
import java.awt.Container;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JButton;
import javax.swing.JFileChooser;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JTextField;

/**
 *
 * @author Christopher Williams
 */
public class Save_as extends JFrame {

    private JTextField filename = new JTextField(), dir = new JTextField();
    private JButton open = new JButton("Path"), save = new JButton("Save"), openproj = new JButton("Open Project");
    protected static JFileChooser c = new JFileChooser();
    public static String pathname;
    public static String projpath;
    private int saveframenum = Controls.framename;
    private int width = 300;
    private int height = 130;

    public Save_as() {
        setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        setSize(width, height);
        setLocationRelativeTo(null);
        setVisible(true);
        setTitle("Save");
        JPanel p = new JPanel();
        p.add(open);
        p.add(openproj);
        p.add(save);
        Container cp = getContentPane();
        cp.add(p, BorderLayout.SOUTH);
        dir.setEditable(false);
        filename.setEditable(false);
        p = new JPanel();
        p.setLayout(new GridLayout(2, 1));
        p.add(filename);
        p.add(dir);
        cp.add(p, BorderLayout.NORTH);

        openL();
    }

    private void openL() {

        open.setToolTipText("Configure path to save to");
        openproj.setToolTipText("Open an existing project");
        save.setToolTipText("Confirm that the path is correct");

        //Saves path and creates folder
        save.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent ab) {
                try {
                    Save_Algorithm savealg = new Save_Algorithm();
                    savealg.projectFile("Last Captured Picture", saveframenum, 1);
                    savealg.projectFile("Number of Scenes", Save_Algorithm.scenenum, 1);
                } catch (RuntimeException e) {
                    throw e;
                } catch (IOException ex) {
                    Logger.getLogger(Save_as.class.getName()).log(Level.SEVERE, null, ex);
                }
                dispose();
            }
        });

        //Opens existing project
        openproj.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent aa) {
                int rval = c.showOpenDialog(Save_as.this);
                if (rval == JFileChooser.APPROVE_OPTION) {
                    filename.setText(c.getSelectedFile().getName());
                    dir.setText(c.getCurrentDirectory().toString());
                    String filedir = (c.getCurrentDirectory().toString() + "\\");
                    String filedir2 = (c.getCurrentDirectory().toString() + "\\" + c.getSelectedFile().getName() + "\\");
                    System.out.println(filedir);
                    pathname = filedir2;
                    projpath = filedir;
                    dispose();
                }
            }
        });

        //JFileChooser opener
        open.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent a) {
                int rVal = c.showOpenDialog(Save_as.this);
                if (rVal == JFileChooser.APPROVE_OPTION) {
                    filename.setText(c.getSelectedFile().getName());
                    dir.setText(c.getCurrentDirectory().toString());
                    String filedir = (c.getCurrentDirectory().toString() + "\\" + c.getSelectedFile().getName() + "\\");
                    System.out.println(filedir);
                    pathname = filedir;
                }
                if (rVal == JFileChooser.CANCEL_OPTION) {
                    filename.setText("You pressed cancel");
                    dir.setText("");
                }
            }
        });
    }
}