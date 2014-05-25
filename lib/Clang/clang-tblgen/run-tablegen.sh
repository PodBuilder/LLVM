#!/bin/sh

#  run-tablegen.sh
#  LLVM
#
#  Created by William Kent on 5/25/14.
#  Copyright (c) 2014 William Kent. All rights reserved.

set -e

LLVM_TBLGEN=${BUILT_PRODUCTS_DIR}/llvm-tblgen
[ -x "${LLVM_TBLGEN}" ] || {
    echo llvm-tblgen missing or not executable 2>&1
    exit 1
}

CLANG_TBLGEN=${BUILT_PRODUCTS_DIR}/clang-tblgen
[ -x "${CLANG_TBLGEN}" ] || {
    echo clang-tblgen missing or not executable 2>&1
    exit 1
}

LLVMTableGen () {
    # usage: $0 input.td output.h "-flags -flags -flags"
    mkdir -p `dirname $2`
    
    if [ "$1" -nt "$2" ]; then
        echo Generating `basename $2`
        $LLVM_TBLGEN $3 -I ${TOP_SRCROOT}/include -o $2 $1
    fi
}

ClangTableGen () {
    # usage: $0 input.td output.h "-flags -flags -flags"
    mkdir -p `dirname $2`
    
    if [ "$1" -nt "$2" ]; then
        echo Generating `basename $2`
        $CLANG_TBLGEN $3 -I ${TOP_SRCROOT}/include -o $2 $1
    fi
}

ClangTableGen "${TOP_SRCROOT}/include/clang/Basic/Attr.td" "${PROJECT_TEMP_DIR}/ClangCommonTableGen/Attrs.inc" "-gen-clang-attr-classes"
ClangTableGen "${TOP_SRCROOT}/include/clang/Basic/Attr.td" "${PROJECT_TEMP_DIR}/ClangCommonTableGen/AttrImpl.inc" "-gen-clang-attr-impl"
ClangTableGen "${TOP_SRCROOT}/include/clang/Basic/Attr.td" "${PROJECT_TEMP_DIR}/ClangCommonTableGen/AttrDump.inc" "-gen-clang-attr-dump"
ClangTableGen "${TOP_SRCROOT}/include/clang/Basic/StmtNodes.td" "${PROJECT_TEMP_DIR}/ClangCommonTableGen/StmtNodes.inc" "-gen-clang-stmt-nodes"
ClangTableGen "${TOP_SRCROOT}/include/clang/Basic/DeclNodes.td" "${PROJECT_TEMP_DIR}/ClangCommonTableGen/DeclNodes.inc" "-gen-clang-decl-nodes"
ClangTableGen "${TOP_SRCROOT}/include/clang/Basic/CommentNodes.td" "${PROJECT_TEMP_DIR}/ClangCommonTableGen/CommentNodes.inc" "-gen-clang-comment-nodes"
ClangTableGen "${TOP_SRCROOT}/include/clang/AST/CommentHTMLTags.td" "${PROJECT_TEMP_DIR}/ClangCommonTableGen/CommentHTMLTags.inc" "-gen-clang-comment-html-tags"
ClangTableGen "${TOP_SRCROOT}/include/clang/AST/CommentHTMLTags.td" "${PROJECT_TEMP_DIR}/ClangCommonTableGen/CommentHTMLTagsProperties.inc" "-gen-clang-comment-html-tags-properties"
ClangTableGen "${TOP_SRCROOT}/include/clang/AST/CommentHTMLNamedCharacterReferences.td" "${PROJECT_TEMP_DIR}/ClangCommonTableGen/CommentHTMLNamedCharacterReferences.inc" "-gen-clang-comment-html-named-character-references"
ClangTableGen "${TOP_SRCROOT}/include/clang/AST/CommentCommands.td" "${PROJECT_TEMP_DIR}/ClangCommonTableGen/CommentCommandInfo.inc" "-gen-clang-comment-command-info"
ClangTableGen "${TOP_SRCROOT}/include/clang/AST/CommentCommands.td" "${PROJECT_TEMP_DIR}/ClangCommonTableGen/CommentCommandList.inc" "-gen-clang-comment-command-list"

ClangTableGen "${TOP_SRCROOT}/include/clang/Basic/Diagnostic.td" "${PROJECT_TEMP_DIR}/ClangCommonTableGen/DiagnosticGroups.inc" "-gen-clang-diag-groups -I${TOP_SRCROOT}/include/clang/Basic"
ClangTableGen "${TOP_SRCROOT}/include/clang/Basic/Diagnostic.td" "${PROJECT_TEMP_DIR}/ClangCommonTableGen/DiagnosticIndexName.inc" "-gen-clang-diags-index-name -I${TOP_SRCROOT}/include/clang/Basic"
ClangTableGen "${TOP_SRCROOT}/include/clang/Basic/Attr.td" "${PROJECT_TEMP_DIR}/ClangCommonTableGen/AttrList.inc" "-gen-clang-attr-list"
ClangTableGen "${TOP_SRCROOT}/include/clang/Basic/arm_neon.td" "${PROJECT_TEMP_DIR}/ClangCommonTableGen/arm_neon.inc" "-gen-arm-neon-sema"
ClangTableGen "${TOP_SRCROOT}/include/clang/Basic/arm64_simd.td" "${PROJECT_TEMP_DIR}/ClangCommonTableGen/arm_simd.inc" "-gen-arm64-simd-sema"

ClangTableGen "${TOP_SRCROOT}/include/clang/Basic/Attr.td" "${PROJECT_TEMP_DIR}/ClangCommonTableGen/AttrSpellings.inc" "-gen-clang-attr-spelling-list"

ClangTableGen "${TOP_SRCROOT}/include/clang/Basic/Attr.td" "${PROJECT_TEMP_DIR}/ClangCommonTableGen/AttrIdentifierArg.inc" "-gen-clang-attr-identifier-arg-list"
ClangTableGen "${TOP_SRCROOT}/include/clang/Basic/Attr.td" "${PROJECT_TEMP_DIR}/ClangCommonTableGen/AttrTypeArg.inc" "-gen-clang-attr-type-arg-list"
ClangTableGen "${TOP_SRCROOT}/include/clang/Basic/Attr.td" "${PROJECT_TEMP_DIR}/ClangCommonTableGen/AttrLateParsed.inc" "-gen-clang-attr-late-parsed-list"

ClangTableGen "${TOP_SRCROOT}/include/clang/Basic/Attr.td" "${PROJECT_TEMP_DIR}/ClangCommonTableGen/AttrTemplateInstantiate.inc" "-gen-clang-attr-template-instantiate"
ClangTableGen "${TOP_SRCROOT}/include/clang/Basic/Attr.td" "${PROJECT_TEMP_DIR}/ClangCommonTableGen/AttrParsedAttrList.inc" "-gen-clang-attr-parsed-attr-list"
ClangTableGen "${TOP_SRCROOT}/include/clang/Basic/Attr.td" "${PROJECT_TEMP_DIR}/ClangCommonTableGen/AttrParsedAttrKinds.inc" "-gen-clang-attr-parsed-attr-kinds"
ClangTableGen "${TOP_SRCROOT}/include/clang/Basic/Attr.td" "${PROJECT_TEMP_DIR}/ClangCommonTableGen/AttrSpellingListIndex.inc" "-gen-clang-attr-spelling-index"
ClangTableGen "${TOP_SRCROOT}/include/clang/Basic/Attr.td" "${PROJECT_TEMP_DIR}/ClangCommonTableGen/AttrParsedAttrImpl.inc" "-gen-clang-attr-parsed-attr-impl"

ClangTableGen "${TOP_SRCROOT}/include/clang/Basic/Attr.td" "${PROJECT_TEMP_DIR}/ClangCommonTableGen/AttrPCHRead.inc" "-gen-clang-attr-pch-read"
ClangTableGen "${TOP_SRCROOT}/include/clang/Basic/Attr.td" "${PROJECT_TEMP_DIR}/ClangCommonTableGen/AttrPCHWrite.inc" "-gen-clang-attr-pch-write"

LLVMTableGen "${TOP_SRCROOT}/include/clang/Driver/Options.td" "${PROJECT_TEMP_DIR}/ClangCommonTableGen/Options.inc" "-gen-opt-parser-defs -I${TOP_SRCROOT}/include/clang/Driver"
LLVMTableGen "${TOP_SRCROOT}/include/clang/Driver/CC1AsOptions.td" "${PROJECT_TEMP_DIR}/ClangCommonTableGen/CC1AsOptions.inc" "-gen-opt-parser-defs"

clang_diag_gen () {
    component=$1
    ClangTableGen "${TOP_SRCROOT}/include/clang/Basic/Diagnostic.td" "${PROJECT_TEMP_DIR}/ClangCommonTableGen/Diagnostic${component}Kinds.inc" "-gen-clang-diags-defs -clang-component=${component} -I${TOP_SRCROOT}/include/clang/Basic"
}

clang_diag_gen Analysis
clang_diag_gen AST
clang_diag_gen Comment
clang_diag_gen Common
clang_diag_gen Driver
clang_diag_gen Frontend
clang_diag_gen Lex
clang_diag_gen Parse
clang_diag_gen Sema
clang_diag_gen Serialization
