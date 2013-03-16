/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package alpha;

import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;

/**
 *
 * @author Christopher Williams
 */
public class NoCam_Error {

    JFrame errfr = new JFrame();
    JPanel errwin = new JPanel();
    private JLabel errmsg;

    public NoCam_Error() {

        errfr.getContentPane().add(errwin);
        errfr.setVisible(true);
        errfr.setAlwaysOnTop(true);
        errfr.setTitle("ERROR!!!");
        errfr.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        errfr.setSize(350, 100);
        errfr.setLocationRelativeTo(null);
        errwin.setLayout(null);

        error_Message();
    }

    private void error_Message() {
        errmsg = new JLabel("No Camera Found! Try plugging/replugging in your camera.");
        errmsg.setBounds(30, 10, 295, 25);
        errwin.add(errmsg);
    }
}
