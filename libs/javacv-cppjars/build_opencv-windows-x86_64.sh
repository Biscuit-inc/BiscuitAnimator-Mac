VER=`echo $OPENCV_VERSION | tr -d .`
LIBS="opencv/build/x64/vc10/bin/opencv_*$VER.dll opencv/build/x64/vc10/bin/opencv_*${VER}_64.dll"
7z x OpenCV-$OPENCV_VERSION.exe $LIBS
mkdir -p com/googlecode/javacv/cpp/windows-x86_64/
cp $LIBS $LIBS2 com/googlecode/javacv/cpp/windows-x86_64/
jar cvf opencv-$OPENCV_VERSION-windows-x86_64.jar com/
rm -Rf com/
