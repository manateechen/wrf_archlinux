#!/bin/sh
# @Author: Benjamin Held
# @Date:   2018-10-23 09:09:29
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2018-11-18 10:37:51

function print_options () {
  printf "${YELLOW} 1: WRFV3 version 3.9.1\n${NC}"
  printf "${YELLOW} 2: WRFV3 version 3.8.1\n${NC}"
  printf "${YELLOW} 3: WRFV3 version 3.8.0\n${NC}"
}

# define terminal colors
RED='\033[0;31m'
GREEN='\033[0;32m'
LIGHT_BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Default selection
SELECT_VALUE=1

# check for script arguments
if [ $# -ne 1 ] 
then
  while true; do
    printf "${LIGHT_BLUE}Select the WRF version that should be deployed:\n${NC}"
    print_options        
    read INPUT
    case ${INPUT} in
      [123]* ) SELECT_VALUE=${INPUT}; break;;
      * ) printf "${RED}Please use a numeric value in [1-3].${NC}\n";;
    esac
  done
else
  case ${1} in
    [123]* ) SELECT_VALUE=${1} ;;
    ['--help']* ) printf "${LIGHT_BLUE}Usage:\n${NC}"; print_options;;
    * ) printf "${RED}Error: False argument. Please use a numeric value in [1-3] or --help.${NC}\n";;
  esac
fi

case ${SELECT_VALUE} in
  [1]* ) FILE_NAME='wrf_dev_391.tar.gz';;
  [2]* ) FILE_NAME='wrf_dev_381.tar.gz';;
  [3]* ) FILE_NAME='wrf_dev_380.tar.gz';;
esac

# creating url for the selectied wrf tar
URL_PATH="https://bheld.eu/data/wrf_deploy/${FILE_NAME}"
cd ${HOME}
printf "${YELLOW}\nLoading wrf archive: ${NC}\n"
wget ${URL_PATH}
printf "${YELLOW}\nUnpacking archive: ${NC}\n"
tar -xzf ${FILE_NAME}
rm ${FILE_NAME}
printf "${YELLOW}\nFinished wrf deployment.${NC}\n"