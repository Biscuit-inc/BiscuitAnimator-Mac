=CPPJARs for JavaCV 0.4 on Linux, Mac OS X, Windows, and Android=
==Introduction==
The JAR files of OpenCV and FFmpeg found in this package are meant to be used with [http://code.google.com/p/javacv/ JavaCV]. They were built on Fedora 17, so they may not work on all distributions of Linux, especially older ones. The binaries for Android were compiled for ARMv7 processors featuring an FPU, so they will not work on ancient devices such as the HTC Magic or some others with an ARMv6 CPU.

To compile binaries for an Android device with no FPU, first make sure this is what you want. Without FPU, the performance of either OpenCV or FFmpeg is bound to be unacceptable. If you still wish to continue down that road, then replace "libs/armeabi-v7a" by "libs/armeabi" and "-march=armv7-a -mfloat-abi=softfp -mfpu=vfp -mfpu=neon" with "-march=armv5te -mtune=xscale -msoft-float", inside the patch files.

==Rebuilding Instructions==
Required software:
 * A recent version of Linux (or Mac OS X) with at least Java SE 6
 * OpenCV 2.4.4  http://sourceforge.net/projects/opencvlibrary/files/
 * FFmpeg 1.1.3  http://ffmpeg.org/download.html
  * For Windows  http://ffmpeg.zeranoe.com/builds/  Known compatible builds:
   * http://ffmpeg.zeranoe.com/builds/win32/shared/ffmpeg-1.1.1-win32-shared.7z
   * http://ffmpeg.zeranoe.com/builds/win64/shared/ffmpeg-1.1.1-win64-shared.7z
 * Android NDK r8d  http://developer.android.com/sdk/ndk/

1. Place the library archives themselves inside this directory
2. Run: $ ANDROID_NDK=/path/to/android-ndk-r8d/ bash build_all.sh <platform-arch>

To build JavaCV against those, we need to actually install the libraries on the system with `make install` and what not. At runtime, however, JavaCV can load the libraries from the created JAR files above, a useful feature for standalone applications or Java applets. Moreover, tricks such as the following work with JNLP:
{{{
    <resources os="Linux" arch="x86 i386 i486 i586 i686">
        <jar href="lib/javacv-linux-x86.jar"/>
        <jar href="lib/opencv-2.4.4-linux-x86.jar"/>
    </resources>
    <resources os="Linux" arch="x86_64 amd64">
        <jar href="lib/javacv-linux-x86_64.jar"/>
        <jar href="lib/opencv-2.4.4-linux-x86_64.jar"/>
    </resources>
}}}

Thanks to Jose Gómez for testing this out!

----
Copyright (C) 2011,2012,2013 Samuel Audet <samuel.audet@gmail.com>
Project site: http://code.google.com/p/javacv/
