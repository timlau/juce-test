rm -rf build
rm -rf BUILDROOT
cmake -S . -B build
cmake --build build
mkdir -p BUILDROOT
DESTDIR=BUILDROOT cmake --install build --prefix=/usr