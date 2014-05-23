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

TableGen "${SRCROOT}/ARM.td" "${PROJECT_TEMP_DIR}/ARMCommonTableGen/ARMGenRegisterInfo.inc" "-gen-register-info -I${SRCROOT}"
TableGen "${SRCROOT}/ARM.td" "${PROJECT_TEMP_DIR}/ARMCommonTableGen/ARMGenInstrInfo.inc" "-gen-instr-info -I${SRCROOT}"
TableGen "${SRCROOT}/ARM.td" "${PROJECT_TEMP_DIR}/ARMCommonTableGen/ARMGenCodeEmitter.inc" "-gen-emitter -I${SRCROOT}"
TableGen "${SRCROOT}/ARM.td" "${PROJECT_TEMP_DIR}/ARMCommonTableGen/ARMGenMCCodeEmitter.inc" "-gen-emitter -mc-emitter -I${SRCROOT}"
TableGen "${SRCROOT}/ARM.td" "${PROJECT_TEMP_DIR}/ARMCommonTableGen/ARMGenMCPseudoLowering.inc" "-gen-pseudo-lowering -I${SRCROOT}"
TableGen "${SRCROOT}/ARM.td" "${PROJECT_TEMP_DIR}/ARMCommonTableGen/ARMGenDAGISel.inc" "-gen-dag-isel -I${SRCROOT}"
TableGen "${SRCROOT}/ARM.td" "${PROJECT_TEMP_DIR}/ARMCommonTableGen/ARMGenFastISel.inc" "-gen-fast-isel -I${SRCROOT}"
TableGen "${SRCROOT}/ARM.td" "${PROJECT_TEMP_DIR}/ARMCommonTableGen/ARMGenCallingConv.inc" "-gen-callingconv -I${SRCROOT}"
TableGen "${SRCROOT}/ARM.td" "${PROJECT_TEMP_DIR}/ARMCommonTableGen/ARMGenSubtargetInfo.inc" "-gen-subtarget -I${SRCROOT}"
TableGen "${SRCROOT}/ARM.td" "${PROJECT_TEMP_DIR}/ARMCommonTableGen/ARMGenDisassemblerTables.inc" "-gen-disassembler -I${SRCROOT}"
TableGen "${SRCROOT}/ARM.td" "${PROJECT_TEMP_DIR}/ARMCommonTableGen/ARMGenAsmWriter.inc" "-gen-asm-writer -I${SRCROOT}"
TableGen "${SRCROOT}/ARM.td" "${PROJECT_TEMP_DIR}/ARMCommonTableGen/ARMGenAsmMatcher.inc" "-gen-asm-matcher -I${SRCROOT}"
