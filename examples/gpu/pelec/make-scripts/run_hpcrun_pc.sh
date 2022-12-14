#!/bin/bash

$HPCTOOLKIT_PELEC_MODULES_BUILD
$HPCTOOLKIT_MODULES_HPCTOOLKIT

BINARY=PeleC
LOC=Exec/RegTests/PMF
DIR=../PeleC/build/${LOC}
EXEC=${DIR}/${BINARY}
INPUT=../PeleC/${LOC}/inputs_ex
OUT=hpctoolkit-${BINARY}-gpu-cuda-pc

CMD="rm -rf ${OUT}.m ${OUT}.d dir.run-pc"
echo $CMD
$CMD

mkdir dir.run-pc
cd dir.run-pc

$HPCTOOLKIT_BEFORE_RUN_PC

# measure an execution of PeleC
CMD="time ${HPCTOOLKIT_PELEC_LAUNCH} ${HPCTOOLKIT_PELEC_LAUNCH_ARGS hpcrun -o $OUT.m -e gpu=nvidia,pc -t ${EXEC} ${INPUT}"
echo $CMD
$CMD

$HPCTOOLKIT_AFTER_RUN_PC

# compute program structure information
CMD="hpcstruct -j 16 --gpucfg yes $OUT.m" 
echo $CMD
$CMD

# combine the measurements with the program structure information
CMD="hpcprof -o $OUT.d $OUT.m"
echo $CMD
$CMD

mv $OUT.d $OUT.m .. 
cd ..
touch log.run-pc.done
