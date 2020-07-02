#!/bin/tcsh

source ~/kode/bashScripts/sourceWRF.csh
mkdir -p $DIR 
mkdir -p $TEST_DIR
cd $TEST_DIR 
wget https://www2.mmm.ucar.edu/wrf/OnLineTutorial/compile_tutorial/tar_files/Fortran_C_tests.tar
tar -xf Fortran_C_tests.tar
# Test #1: Fixed Format Fortran Test: TEST_1_fortran_only_fixed.f
gfortran TEST_1_fortran_only_fixed.f
./a.out

# Test #2: Free Format Fortran: TEST_2_fortran_only_free.f90
gfortran TEST_2_fortran_only_free.f90
./a.out


# Test #3: C: TEST_3_c_only.c
gcc TEST_3_c_only.c
./a.out

# Test #4: Fortran Calling a C Function (our gcc and gfortran have different defaults, so we force both to always use 64 bit [-m64] when combining them): TEST_4_fortran+c_c.c, and TEST_4_fortran+x_f.f90
gcc -c -m64 TEST_4_fortran+c_c.c
gfortran -c -m64 TEST_4_fortran+c_f.f90
gfortran -m64 TEST_4_fortran+c_f.o TEST_4_fortran+c_c.o
./a.out

# Test #5:csh
./TEST_csh.csh

# Test #6:perl
./TEST_perl.pl

# Test #7:sh
./TEST_sh.sh

# The following standard UNIX commands are mandatory:
#ar           head          sed
#awk          hostname      sleep
#cat          ln            sort
#cd           ls            tar
#cp           make          touch
#cut          mkdir         tr
#expr         mv            uname
#file         nm            wc
#grep         printf        which
#gzip         rm            m4


cd $DIR
wget https://www2.mmm.ucar.edu/wrf/OnLineTutorial/compile_tutorial/tar_files/mpich-3.0.4.tar.gz
wget https://www2.mmm.ucar.edu/wrf/OnLineTutorial/compile_tutorial/tar_files/netcdf-4.1.3.tar.gz
wget https://www2.mmm.ucar.edu/wrf/OnLineTutorial/compile_tutorial/tar_files/jasper-1.900.1.tar.gz
wget https://www2.mmm.ucar.edu/wrf/OnLineTutorial/compile_tutorial/tar_files/libpng-1.2.50.tar.gz
wget https://www2.mmm.ucar.edu/wrf/OnLineTutorial/compile_tutorial/tar_files/zlib-1.2.7.tar.gz

# NetCDF
tar xzvf netcdf-4.1.3.tar.gz #or just .tar if no .gz present
cd netcdf-4.1.3
./configure --prefix=$DIR/netcdf --disable-dap --disable-netcdf-4 --disable-shared
make
make install
cd ..

# MPICH
tar xzvf mpich-3.0.4.tar.gz #or just .tar if no .gz present
cd mpich-3.0.4
./configure --prefix=$DIR/mpich
make
make install
cd ..

# zlib
tar xzvf zlib-1.2.7.tar.gz     #or just .tar if no .gz present
cd zlib-1.2.7
./configure --prefix=$DIR/grib2
make
make install
cd ..

# libpng
tar xzvf libpng-1.2.50.tar.gz     #or just .tar if no .gz present
cd libpng-1.2.50
./configure --prefix=$DIR/grib2
make
make install
cd ..

# JasPer
tar xzvf jasper-1.900.1.tar.gz     #or just .tar if no .gz present
cd jasper-1.900.1
./configure --prefix=$DIR/grib2
make
make install
cd ..

# Library Compatibility Tests
cd $TEST_DIR
wget https://www2.mmm.ucar.edu/wrf/OnLineTutorial/compile_tutorial/tar_files/Fortran_C_NETCDF_MPI_tests.tar
tar -xf Fortran_C_NETCDF_MPI_tests.tar

# Test #1: Fortran + C + NetCDF
cp ${NETCDF}/include/netcdf.inc .

gfortran -c 01_fortran+c+netcdf_f.f
gcc -c 01_fortran+c+netcdf_c.c
gfortran 01_fortran+c+netcdf_f.o 01_fortran+c+netcdf_c.o -L${NETCDF}/lib -lnetcdff -lnetcdf
./a.out

# Test #2: Fortran + C + NetCDF + MPI
cp ${NETCDF}/include/netcdf.inc .

mpif90 -c 02_fortran+c+netcdf+mpi_f.f
mpicc -c 02_fortran+c+netcdf+mpi_c.c
mpif90 02_fortran+c+netcdf+mpi_f.o 02_fortran+c+netcdf+mpi_c.o -L${NETCDF}/lib -lnetcdff -lnetcdf
mpirun ./a.out

# Static Geography Data
mkdir -p $WPSDATADIRECTORY
cd $WPSDATADIRECTORY
#wget https://www2.mmm.ucar.edu/wrf/src/wps_files/geog_low_res_mandatory.tar.gz
#gunzip geog_low_res_mandatory.tar.gz
#tar -xf geog_low_res_mandatory.tar
#wget https://www2.mmm.ucar.edu/wrf/src/wps_files/geog_high_res_mandatory.tar.gz
#gunzip geog_high_res_mandatory.tar.gz
#tar -xf geog_high_res_mandatory.tar
# mv geog WPS_GEOG # not needed
# NB: edit line 39 of namelist.wps: geog_data_path = '/home/joveve/kode/WRF/Build_WRF/WPS_GEOG_LOW_RES/'
cd $WRFDIRECTORY/Build_WRF

# Real-time Data
mkdir -p DATA
cd DATA
$HOME/kode/bashScripts/getNCEPdata "20200701" "00 03 06"
cd ..

# BUILD WRF
cd $WRFDIRECTORY/Build_WRF
git clone https://github.com/wrf-model/WRF
cd WRF
./configure # use option 34 1
#./compile em_real > & log.compile
#ls -ls main/*.exe
cd ..

# BUILD WPS
git clone https://github.com/wrf-model/WPS
cd WPS
sed -i "39s|.*| geog_data_path = '$WPSDATADIRECTORY'|" namelist.wps
#./configure # use option 3
#./compile >& log.compile
#ls -lh geogrid/src/geogrid.exe
#ls -lh ungrib/src/ungrib.exe
#ls -lh metgrid/src/metgrid.exe
cd ..


## Run WPS and WRF
cd WPS
#./geogrid.exe >& log.geogrid
#./link_grib.csh $WPSDATADIRECTORY 
#ln -sf ungrib/Variable_Tables/Vtable.GFS Vtable
#./ungrib.exe
#./metgrid.exe >& log.metgrid



