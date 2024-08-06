# Patch the full path to the Eigen/Core header since the CMake logic is broken.
eigen_path=\"${PREFIX}/include/eigen3/Eigen/Core\"
sed -i "s#<eigen3/Eigen/Core>#$eigen_path#" psi4/src/psi4/libmints/matrix.h

mkdir build && cd build

# Note that we need to explicitly set the Python variant for the install path
# of the Python module. This is because PY_VER appears to be broken for conda
# build, i.e. it uses the one of the base conda environment, not the one
# specified in the build recipe.
cmake \
    -D CMAKE_INSTALL_PREFIX=${PREFIX} \
    -D CMAKE_PREFIX_PATH="${PREFIX}" \
    -D CMAKE_BUILD_TYPE=Release \
    -D CMAKE_INSTALL_LIBDIR=lib \
    -D PYMOD_INSTALL_LIBDIR="/python3.11/site-packages" \
    -D ENABLE_ddx=True \
    -D LAPACK_TYPE=OPENBLAS \
    -D ENABLE_OPENMP=ON \
    -D LAPACK_LIBRARIES=${PREFIX}/lib/libopenblas.so.0 \
    ..

cmake --build . -j48

cmake --install .

# Forcibly add version information to the Python API since it fails when
# no tag is present in the source code.
sed -i 's/undefined/1.9.1/g' "${PREFIX}/lib/python3.11/site-packages/psi4/metadata.py"
