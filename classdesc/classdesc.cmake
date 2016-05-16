#TODO: what if CLASSDESC_EXE is not set?


find_program(CLASSDESC_EXE classdesc HINTS ${CMAKE_BINARY_DIR}/classdesc)


set(CLASSDESC_INC ${CMAKE_SOURCE_DIR}/classdesc/)


message(STATUS "CLASSDESC_EXE: ${CLASSDESC_EXE}")
message(STATUS "CLASSDESC_INC: ${CLASSDESC_INC}")


function(classdesc_generate_cd inf incdirs)

 #TODO: FIX STUPID SEGFAULT IN CLASSDESC
 get_filename_component(fbase ${inf} NAME_WE)
 set(outf ${CMAKE_CURRENT_BINARY_DIR}/${fbase}.cd)


  add_custom_command(OUTPUT ${outf}
    COMMAND ${CLASSDESC_EXE} -nodef -typeName -i ${inf} >${outf}
    COMMAND ${CLASSDESC_EXE} -nodef -onbase -I ${CLASSDESC_INC} -I ${incdirs} -i ${inf} pack unpack >>${outf}
    COMMAND ${CLASSDESC_EXE} -nodef -onbase -typeName -I ${CLASSDESC_INC} -I ${incdirs} -i ${inf} -respect_private TCL_obj isa >>${outf}

   DEPENDS classdesc
   COMMENT "generating ${outf}"
)
  
endfunction()


function(classdesc_generate_xcd inf incdirs tgt)
  get_filename_component(fbase ${inf} NAME_WE)
  set(outf ${fbase}.xcd)
  
  
  message("inf: ${inf}")
  message("outf: ${outf}")

  add_custom_command(OUTPUT ${outf}
    COMMAND ${CLASSDESC_EXE} -typeName -nodef -respect_private -I ${CLASSDESC_INC} -I ${incdirs} -i ${CMAKE_CURRENT_SOURCE_DIR}/${inf} xml_pack xml_unpack xsd_generate json_pack json_unpack >${CMAKE_CURRENT_BINARY_DIR}/${outf} 

    #DEPENDS classdesc #TODO: ARRGH
    COMMENT "generating ${outf}"
    ) 


endfunction()


function(classdesc_xcd xcdfl srcdir incdirs)
get_filename_component(fbase ${xcdfl} NAME_WE)
set(inf ${fbase}.h)

add_custom_command(OUTPUT ${xcdfl} 
    COMMAND ${CLASSDESC_EXE} -typeName -nodef -respect_private -I ${CLASSDESC_INC} -I ${incdirs} -i ${srcdir}/${inf} xml_pack xml_unpack xsd_generate json_pack json_unpack >${CMAKE_CURRENT_BINARY_DIR}/${xcdfl} 

    #DEPENDS classdesc #TODO: ARRGH
    COMMENT "generating ${xcdfl}"
)
endfunction()

function(classdesc_cd cdfl srcdir incdirs)
get_filename_component(fbase ${cdfl} NAME_WE)
set(inf ${fbase}.h)
  add_custom_command(OUTPUT ${cdfl}
    COMMAND ${CLASSDESC_EXE} -nodef -typeName -i ${srcdir}/${inf} >${CMAKE_CURRENT_BINARY_DIR}/${cdfl}
    COMMAND ${CLASSDESC_EXE} -nodef -onbase -I ${CLASSDESC_INC} -I ${incdirs} -i ${srcdir}/${inf} pack unpack >>${CMAKE_CURRENT_BINARY_DIR}/${cdfl}
    COMMAND ${CLASSDESC_EXE} -nodef -onbase -typeName -I ${CLASSDESC_INC} -I ${incdirs} -i ${srcdir}/${inf} -respect_private TCL_obj isa >>${CMAKE_CURRENT_BINARY_DIR}/${cdfl}
   COMMENT "generating ${cdfl}"
)

endfunction()