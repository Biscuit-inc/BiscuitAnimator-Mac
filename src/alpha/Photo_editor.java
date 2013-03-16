/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package alpha;

import java.awt.GridLayout;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JSlider;
import javax.swing.UIManager;
import javax.swing.event.ChangeEvent;
import javax.swing.event.ChangeListener;

/**
 *
 * @author Christopher Williams
 */
public class Photo_editor extends JFrame {

    JSlider exp, red;
    JLabel lab;

    public Photo_editor() {

        try {
            UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
        } catch (RuntimeException e) {
            throw e;
        } catch (Exception e) {
            e.printStackTrace();
        }
        setLayout(new GridLayout(3, 2, 2, 2));
        setTitle("Pre-Alpha-002-A");
        setSize(720, 480);
        setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        setLocationRelativeTo(null);
        setResizable(true);
        setVisible(true);

        sliderMethod();
        labels();
        eventAdder();
    }

    private void labels() {
        lab = new JLabel("Exposure: 0");
        add(lab);
    }

    private void sliderMethod() {

        //Red
        red = new JSlider(JSlider.HORIZONTAL, 0, 255, 0);
        red.setMajorTickSpacing(10);
        red.setPaintTicks(true);
        red.setSnapToTicks(true);
        add(red);

        //Exposure
        exp = new JSlider(JSlider.HORIZONTAL, 0, 255, 0);
        exp.setMajorTickSpacing(10);
        exp.setPaintTicks(true);
        exp.setSnapToTicks(true);
        add(exp);
    }

    private void eventAdder() {
        event e = new event();
        exp.addChangeListener(e);
    }

    public class event implements ChangeListener {

        public void stateChanged(ChangeEvent e) {
            int exposure = exp.getValue();

            lab.setText("Current Exposure: " + exposure);
        }
    }
}
