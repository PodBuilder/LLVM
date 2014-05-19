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
        echo Processing `basename $2`
        $LLVM_TBLGEN $3 -I ${SRCROOT}/include -o $2 $1
    fi
}

TableGen "${SRCROOT}/lib/Target/X86/X86.td" "${PROJECT_TEMP_DIR}/X86CommonTableGen/X86GenRegisterInfo.inc" "-gen-register-info -I${SRCROOT}/lib/Target/X86"
TableGen "${SRCROOT}/lib/Target/X86/X86.td" "${PROJECT_TEMP_DIR}/X86CommonTableGen/X86GenDisassemblerTables.inc" "-gen-disassembler -I${SRCROOT}/lib/Target/X86"
TableGen "${SRCROOT}/lib/Target/X86/X86.td" "${PROJECT_TEMP_DIR}/X86CommonTableGen/X86GenInstrInfo.inc" "-gen-instr-info -I${SRCROOT}/lib/Target/X86"
TableGen "${SRCROOT}/lib/Target/X86/X86.td" "${PROJECT_TEMP_DIR}/X86CommonTableGen/X86GenAsmWriter.inc" "-gen-asm-writer -I${SRCROOT}/lib/Target/X86"
TableGen "${SRCROOT}/lib/Target/X86/X86.td" "${PROJECT_TEMP_DIR}/X86CommonTableGen/X86GenAsmWriter1.inc" "-gen-asm-writer -asmwriternum=1 -I${SRCROOT}/lib/Target/X86"
TableGen "${SRCROOT}/lib/Target/X86/X86.td" "${PROJECT_TEMP_DIR}/X86CommonTableGen/X86GenAsmMatcher.inc" "-gen-asm-matcher -I${SRCROOT}/lib/Target/X86"
TableGen "${SRCROOT}/lib/Target/X86/X86.td" "${PROJECT_TEMP_DIR}/X86CommonTableGen/X86GenDAGISel.inc" "-gen-dag-isel -I${SRCROOT}/lib/Target/X86"
TableGen "${SRCROOT}/lib/Target/X86/X86.td" "${PROJECT_TEMP_DIR}/X86CommonTableGen/X86GenFastISel.inc" "-gen-fast-isel -I${SRCROOT}/lib/Target/X86"
TableGen "${SRCROOT}/lib/Target/X86/X86.td" "${PROJECT_TEMP_DIR}/X86CommonTableGen/X86GenCallingConv.inc" "-gen-callingconv -I${SRCROOT}/lib/Target/X86"
TableGen "${SRCROOT}/lib/Target/X86/X86.td" "${PROJECT_TEMP_DIR}/X86CommonTableGen/X86GenSubtargetInfo.inc" "-gen-subtarget -I${SRCROOT}/lib/Target/X86"
