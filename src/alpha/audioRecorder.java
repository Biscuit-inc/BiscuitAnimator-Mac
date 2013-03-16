/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package alpha;

import java.io.File;
import javax.sound.sampled.AudioFileFormat;
import javax.sound.sampled.AudioFormat;
import javax.sound.sampled.AudioInputStream;
import javax.sound.sampled.AudioSystem;
import javax.sound.sampled.DataLine;
import javax.sound.sampled.TargetDataLine;
import javax.swing.JPanel;

/**
 *
 * @author Christopher Williams
 */
public class audioRecorder extends JPanel {

    AudioFormat audioFormat;
    TargetDataLine targetDataLine;
    protected int audnum = 0;

    public audioRecorder() {
    }

    //This method captures audio input from a
    // microphone and saves it in an audio file.
    protected void captureAudio() {
        try {
            audioFormat = getAudioFormat();
            DataLine.Info dataLineInfo =
                    new DataLine.Info(
                    TargetDataLine.class,
                    audioFormat);
            targetDataLine = (TargetDataLine) AudioSystem.getLine(dataLineInfo);

            new CaptureThread().start();
        } catch (Exception e) {
            e.printStackTrace();
            System.exit(0);
        }
    }

    protected AudioFormat getAudioFormat() {

        int channels = 1;
        //1,2
        float sampleRate = 8000;
        //8000,11025,16000,22050,44100

        if (Controls.sampleRate.getSelectedIndex() == 0) {
            sampleRate = 8000.0f;
        } else if (Controls.sampleRate.getSelectedIndex() == 1) {
            sampleRate = 11025.0f;
        } else if (Controls.sampleRate.getSelectedIndex() == 2) {
            sampleRate = 16000.0f;
        } else if (Controls.sampleRate.getSelectedIndex() == 3) {
            sampleRate = 22050.0f;
        } else if (Controls.sampleRate.getSelectedIndex() == 4) {
            sampleRate = 44100.0f;
        }

        if (Controls.channels.getSelectedIndex() == 0) {
            channels = 1;
        } else if (Controls.channels.getSelectedIndex() == 1) {
            channels = 2;
        }

        int sampleSizeInBits = 16;
        //8,16
        boolean signed = true;
        //true,false
        boolean bigEndian = true;
        //true,false
        return new AudioFormat(sampleRate,
                sampleSizeInBits,
                channels,
                signed,
                bigEndian);
    }

//Inner class to capture data from microphone
// and write it to an output audio file.
    class CaptureThread extends Thread {

        public void run() {
            AudioFileFormat.Type fileType = null;
            File audioFile = null;

            //Set the file type and the file extension
            // based on the selected radio button.
            if (Controls.audioformat.getSelectedIndex() == 0) {
                fileType = AudioFileFormat.Type.WAVE;
                audioFile = new File(Save_Algorithm.audiodir + "\\audio_" + audnum + ".wav");
            } else if (Controls.audioformat.getSelectedIndex() == 1) {
                fileType = AudioFileFormat.Type.AIFC;
                audioFile = new File(Save_Algorithm.audiodir + "\\audio_" + audnum + ".aifc");
            } else if (Controls.audioformat.getSelectedIndex() == 2) {
                fileType = AudioFileFormat.Type.AIFF;
                audioFile = new File(Save_Algorithm.audiodir + "\\audio_" + audnum + ".aif");
            } else if (Controls.audioformat.getSelectedIndex() == 3) {
                fileType = AudioFileFormat.Type.AU;
                audioFile = new File(Save_Algorithm.audiodir + "\\audio_" + audnum + ".au");
            } else if (Controls.audioformat.getSelectedIndex() == 4) {
                fileType = AudioFileFormat.Type.SND;
                audioFile = new File(Save_Algorithm.audiodir + "\\audio_" + audnum + ".snd");
            }

            try {
                
                targetDataLine.open(audioFormat);
                targetDataLine.start();
                AudioSystem.write(
                        new AudioInputStream(targetDataLine),
                        fileType,
                        audioFile);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}