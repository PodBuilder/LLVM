#!/bin/sh

#  tablegen.sh
#  LLVM
#
#  Created by William Kent on 5/18/14.
#  Copyright (c) 2014 William Kent. All rights reserved.

set -e

LLVM_TBLGEN=${BUILT_PRODUCTS_DIR}/llvm-tblgen
[ -x "${LLVM_TBLGEN}" ] || {
    echo llvm-tblgen missing or not executable 2>&1
    exit 1
}

TableGen () {
    # usage: $0 input.td output.h "-flags -flags -flags"
    mkdir -p `dirname $2`
    
    if [ "$1" -nt "$2" ]; then
        echo Generating `basename $2`
        $LLVM_TBLGEN $3 -I ${TOP_SRCROOT}/include -o $2 $1
    fi
}

TableGen "${SRCROOT}/ARM64.td" "${PROJECT_TEMP_DIR}/ARM64CommonTableGen/ARM64GenRegisterInfo.inc" "-gen-register-info -I${SRCROOT}"
TableGen "${SRCROOT}/ARM64.td" "${PROJECT_TEMP_DIR}/ARM64CommonTableGen/ARM64GenInstrInfo.inc" "-gen-instr-info -I${SRCROOT}"
TableGen "${SRCROOT}/ARM64.td" "${PROJECT_TEMP_DIR}/ARM64CommonTableGen/ARM64GenMCCodeEmitter.inc" "-gen-emitter -mc-emitter -I${SRCROOT}"
TableGen "${SRCROOT}/ARM64.td" "${PROJECT_TEMP_DIR}/ARM64CommonTableGen/ARM64GenMCPseudoLowering.inc" "-gen-pseudo-lowering -I${SRCROOT}"
TableGen "${SRCROOT}/ARM64.td" "${PROJECT_TEMP_DIR}/ARM64CommonTableGen/ARM64GenDAGISel.inc" "-gen-dag-isel -I${SRCROOT}"
TableGen "${SRCROOT}/ARM64.td" "${PROJECT_TEMP_DIR}/ARM64CommonTableGen/ARM64GenFastISel.inc" "-gen-fast-isel -I${SRCROOT}"
TableGen "${SRCROOT}/ARM64.td" "${PROJECT_TEMP_DIR}/ARM64CommonTableGen/ARM64GenCallingConv.inc" "-gen-callingconv -I${SRCROOT}"
TableGen "${SRCROOT}/ARM64.td" "${PROJECT_TEMP_DIR}/ARM64CommonTableGen/ARM64GenSubtargetInfo.inc" "-gen-subtarget -I${SRCROOT}"
TableGen "${SRCROOT}/ARM64.td" "${PROJECT_TEMP_DIR}/ARM64CommonTableGen/ARM64GenDisassemblerTables.inc" "-gen-disassembler -I${SRCROOT}"
TableGen "${SRCROOT}/ARM64.td" "${PROJECT_TEMP_DIR}/ARM64CommonTableGen/ARM64GenAsmWriter.inc" "-gen-asm-writer -I${SRCROOT}"
TableGen "${SRCROOT}/ARM64.td" "${PROJECT_TEMP_DIR}/ARM64CommonTableGen/ARM64GenAsmMatcher.inc" "-gen-asm-matcher -I${SRCROOT}"
