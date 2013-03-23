/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Controllers;

import alpha.Controls;
import static edsdk.a.EdSdkLibrary.kEdsPropID_Av;
import static edsdk.a.EdSdkLibrary.kEdsPropID_ISOSpeed;
import static edsdk.a.EdSdkLibrary.kEdsPropID_Tv;
import static edsdk.a.EdSdkLibrary.kEdsPropID_WhiteBalance;
import edsdk.utils.CanonConstants;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.Insets;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.lang.reflect.Field;
import java.util.LinkedList;
import javax.swing.BorderFactory;
import javax.swing.JComboBox;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;

/**
 *
 * @author Christopher Williams
 */
public class Canon extends JFrame {

    JFrame canonf = new JFrame();
    static JPanel content = new JPanel(new GridBagLayout());
    static JLabel label = new JLabel();

    private static void createUI() {
        JFrame frame = new JFrame();
        content.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10));
        GridBagConstraints gbc = new GridBagConstraints();

        gbc.anchor = GridBagConstraints.EAST;
        gbc.fill = gbc.HORIZONTAL;
        gbc.insets = new Insets(3, 3, 3, 3);
        gbc.gridy = 1;

        addCombobox(content, gbc, "White Balance", "WB_", new Callback() {
            public void call(int value) {
                Controls.camera.setProperty(kEdsPropID_WhiteBalance, value);
            }
        });
        addCombobox(content, gbc, "Shutter Speed", "Speed_", new Callback() {
            public void call(int value) {
                Controls.camera.setProperty(kEdsPropID_Tv, value);
            }
        });
        addCombobox(content, gbc, "Aperature", "F_", new Callback() {
            public void call(int value) {
                Controls.camera.setProperty(kEdsPropID_Av, value);
            }
        });
        addCombobox(content, gbc, "Iso", "ISO_", new Callback() {
            public void call(int value) {
                Controls.camera.setProperty(kEdsPropID_ISOSpeed, value);
            }
        });

        frame.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        frame.setContentPane(content);
        frame.setSize(300, 200);
        frame.setVisible(true);
    }

    private static void addCombobox(JPanel content, GridBagConstraints gbc, String label, String prefix, final Callback callback) {
        gbc.gridx = 0;
        gbc.weightx = 0;
        content.add(new JLabel(label), gbc);

        gbc.gridx = 1;
        gbc.weightx = 1;
        // find the items ...

        LinkedList<String> items = new LinkedList<String>();


        for (Field field : CanonConstants.class
                .getDeclaredFields()) {
            if (field.getName()
                    .startsWith(prefix)) {
                items.add(field.getName());
            }
        }
        final JComboBox combo = new JComboBox(items.toArray(new String[]{}));
        combo.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent event) {
                try {
                    int value = CanonConstants.class
                            .getDeclaredField(combo.getSelectedItem().toString()).getInt(null);
                    callback.call(value);
                } catch (IllegalArgumentException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                } catch (SecurityException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                } catch (IllegalAccessException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                } catch (NoSuchFieldException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }
            }
        });
        gbc.gridx = 1;
        gbc.weightx = 1;
        content.add(combo, gbc);

        gbc.gridy++;


    }

    interface Callback {

        public void call(int value);
    }

    public Canon() {
        createUI();
        //setIconImage(Toolkit.getDefaultToolkit().getImage("icon.png"));
    }
}
