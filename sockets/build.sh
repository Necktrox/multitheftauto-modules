#########################
# Remove old binary
#########################
if [ -e "ml_sockets.so" ]; then
    rm ml_sockets.so
fi

#########################
# Prepare build
#########################
autoreconf -ifv
./configure CXXFLAGS='-g -O2 -fPIC'
make clean

#########################
# Do build
#########################
echo Building...
make >_make.log

#########################
# Check for error
#########################
rc=$?
if [ $rc -ne 0 ]; then
    echo "Stopping: make returned error code $rc"
    exit 1
fi

#########################
# Copy binary file
#########################
cp src/.libs/libml_sockets.so ./ml_sockets.so
echo "Build completed "`pwd`"/ml_sockets.so"
exit 0
