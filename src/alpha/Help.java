/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package alpha;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.UIManager;

/**
 *
 * @author Christopher Williams
 */
public class Help {

    JPanel window = new JPanel();
    JFrame f = new JFrame();
    private int width = 640;
    private int height = 480;

    public Help() {

        try {
            UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
        } catch (RuntimeException e) {
            throw e;
        } catch (Exception e) {
            e.printStackTrace();
        }
        f.getContentPane().add(window);
        f.setTitle("- Help");
        f.setSize(width, height);
        f.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        f.setLocationRelativeTo(null);
        f.setResizable(false);
        f.setVisible(true);
        window.setLayout(null);

        f.repaint();
    }
}
