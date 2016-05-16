#TODO: cross platform functiondb.sh
add_custom_command(OUTPUT functiondb.h 
  COMMAND sh ${CMAKE_CURRENT_SOURCE_DIR}/functiondb.sh > ${CMAKE_CURRENT_BINARY_DIR}/functiondb.h
)

add_executable(classdesc classdesc.cc functiondb.h ${XDR_OBJS})
add_executable(insert-friend insert-friend.cc functiondb.h ${XDR_OBJS})

if(ENABLE_XDR)
  add_definitions(-DXDR_PACK -DHAVE_LONGLONG -DTR1)
  add_library(xdr_pack xdr_pack.cc)
  
  target_link_libraries(classdesc xdr_pack)


endif()




set(CLASSDESC_EXE ${CMAKE_CURRENT_BINARY_DIR}/classdesc)
set(INSERT_FRIEND_EXE ${CMAKE_CURRENT_BINARY_DIR}/insert-friend)
set(CLASSDESC_INC ${CMAKE_CURRENT_SOURCE_DIR})
