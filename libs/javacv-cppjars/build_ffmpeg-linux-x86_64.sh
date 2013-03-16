tar -xjvf ffmpeg-$FFMPEG_VERSION.tar.bz2
mv ffmpeg-$FFMPEG_VERSION ffmpeg-$FFMPEG_VERSION-linux-x86_64
cd ffmpeg-$FFMPEG_VERSION-linux-x86_64
./configure --enable-shared --enable-gpl --enable-version3 --enable-runtime-cpudetect --disable-outdev=sdl --libdir=/usr/local/lib64/ --shlibdir=/usr/local/lib64/
make -j4
LIBS="libavcodec/libavcodec.so.54 libavdevice/libavdevice.so.54 libavfilter/libavfilter.so.3 libavformat/libavformat.so.54 libavutil/libavutil.so.52 libpostproc/libpostproc.so.52 libswresample/libswresample.so.0 libswscale/libswscale.so.2"
strip $LIBS
mkdir -p com/googlecode/javacv/cpp/linux-x86_64/
cp $LIBS com/googlecode/javacv/cpp/linux-x86_64/
jar cvf ../ffmpeg-$FFMPEG_VERSION-linux-x86_64.jar com/
rm -Rf com/
cd ../
