#!/bin/bash

echo "Setting environment variables for SCM-CCPP on Theia with icc/ifort"

#load the modules in order to compile the GMTB SCM
echo "Loading intel and netcdf modules..."
module purge
module load intel/14.0.2
module load netcdf/4.3.0

#set the FC environment variable to ifort
echo "Setting the FC environment variable to use ifort"
export FC=ifort

#prepend the anaconda installation to the path so that the anaconda version of python (with its many installed modules) is used; check if the path already contains the right path first
echo "Checking if the path to the anaconda python distribution is in PATH"
echo $PATH | grep '/contrib/ananconda/2.3.0/bin$' >&/dev/null
if [ $? -ne 0 ]; then
	echo "anaconda path not found in PATH; prepending anaconda path to PATH environment variable"
	export PATH=/contrib/anaconda/2.3.0/bin:$PATH
else
	echo "PATH already has the anaconda path in it"
fi

#install f90nml for the local user

#check to see if f90nml is installed locally
echo "Checking if f90nml python module is installed"
python -c "import f90nml"

if [ $? -ne 0 ]; then
	echo "Not found; installing f90nml"
	cd scripts/f90nml-0.19
	python setup.py install --user
	cd ../..
else
	echo "f90nml is installed"
fi
