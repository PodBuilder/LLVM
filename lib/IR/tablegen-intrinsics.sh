#!/bin/sh

#  tablegen-intrinsics.sh
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

INPUT=${SRCROOT}/include/llvm/IR/Intrinsics.td
OUTPUT=${DERIVED_FILE_DIR}/llvm/IR/Intrinsics.gen

mkdir -p `dirname ${OUTPUT}`
if [ "$INPUT" -nt "$OUTPUT" ]; then
    echo Processing $INPUT
    $LLVM_TBLGEN -gen-intrinsic -I ${SRCROOT}/include -o $OUTPUT $INPUT
fi
