cmake ${CMAKE_ARGS} \
      -G Ninja \
      -DCMAKE_POLICY_VERSION_MINIMUM=3.5 \
      -DCMAKE_BUILD_TYPE=Release \
      -S . -B build

cmake --build build
cmake --install build

# Separate debugging symbols on Linux
if [ -n "${OBJCOPY}" ]
then
  mkdir -p ${PREFIX}/lib/debug
  ${OBJCOPY} --only-keep-debug ${PREFIX}/bin/hdb++cm-srv ${PREFIX}/lib/debug/hdb++cm-srv.dbg
  chmod 664 ${PREFIX}/lib/debug/hdb++cm-srv.dbg
  ${OBJCOPY} --strip-debug ${PREFIX}/bin/hdb++cm-srv
  ${OBJCOPY} --add-gnu-debuglink=${PREFIX}/lib/debug/hdb++cm-srv.dbg ${PREFIX}/bin/hdb++cm-srv
fi
