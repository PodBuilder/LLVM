#!/bin/sh

#  run-tablegen.sh
#  LLVM
#
#  Created by William Kent on 5/17/14.
#  Copyright (c) 2014 William Kent. All rights reserved.

set -e

LLVM_TBLGEN=${BUILT_PRODUCTS_DIR}/llvm-tblgen
[ ! -x "${LLVM_TBLGEN}" ] && {
    echo llvm-tblgen missing or not executable
    exit 1
}

TableGen () {
    # usage: $0 input.td output.h "-flags -flags -flags"
    mkdir -p `dirname $2`
    $LLVM_TBLGEN $3 -I ${DERIVED_FILE_DIR}/generated-include -I ${SRCROOT}/include -o $2 $1
}

TableGen "${SRCROOT}/include/llvm/IR/Intrinsics.td" "${DERIVED_FILE_DIR}/llvm/IR/Intrinsics.gen" "-gen-intrinsic"
