VER=`echo $OPENCV_VERSION | tr -d .`
LIBS=opencv/build/x86/vc10/bin/opencv_*$VER.dll
7z x OpenCV-$OPENCV_VERSION.exe $LIBS
mkdir -p com/googlecode/javacv/cpp/windows-x86/
cp $LIBS $LIBS2 com/googlecode/javacv/cpp/windows-x86/
jar cvf opencv-$OPENCV_VERSION-windows-x86.jar com/
rm -Rf com/
