#!/bin/tcsh
setenv WPSDATADIRECTORY $HOME/WPS_DATA
setenv WRFDIRECTORY $HOME/kode/WRF
setenv TEST_DIR $WRFDIRECTORY/TESTS
setenv DIR $WRFDIRECTORY/Build_WRF/LIBRARIES
setenv CC gcc
setenv CXX g++
setenv FC gfortran
setenv FCFLAGS -m64
setenv F77 gfortran
setenv FFLAGS -m64
setenv JASPERLIB $DIR/grib2/lib
setenv JASPERINC $DIR/grib2/include

setenv LDFLAGS -L$DIR/grib2/lib
setenv CPPFLAGS -I$DIR/grib2/include

setenv PATH $DIR/netcdf/bin:$PATH

setenv NETCDF $DIR/netcdf
setenv PATH $DIR/mpich/bin:$PATH

setenv NETCDF_classic 1
