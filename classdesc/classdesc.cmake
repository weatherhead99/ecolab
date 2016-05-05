#TODO: what if CLASSDESC_EXE is not set?

set(CLASSDESC_EXE ${CMAKE_BINARY_DIR}/classdesc/classdesc)
set(CLASSDESC_INC ${CMAKE_SOURCE_DIR}/classdesc/)

function(classdesc_generate_cd inf outf incdirs)

 #TODO: FIX STUPID SEGFAULT IN CLASSDESC

  add_custom_command(OUTPUT ${outf}
    COMMAND ${CLASSDESC_EXE} -nodef -typeName -i ${inf} >${outf}
    COMMAND ${CLASSDESC_EXE} -nodef -onbase -I ${CLASSDESC_INC} -I ${incdirs} -i ${inf} pack unpack >>${outf}
    COMMAND ${CLASSDESC_EXE} -nodef -onbase -typeName -I ${CLASSDESC_INC} -I ${incdirs} -i ${inf} -respect_private TCL_obj isa >>${outf}

   DEPENDS classdesc
)
  


endfunction()
