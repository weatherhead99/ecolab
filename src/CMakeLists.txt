set(ECOLAB_SRCS automorph.cc auxil.cc arrays.cc sparse_mat.cc findFirst.cc graph.cc
  netcomplexity.cc naugraph.c nautil.c nauty.c nautinv.c cachedDBM.cc TCL_obj.cc igraph.cc
  cairo_types.cc cairo_base.cc plot.cc  tclgraph.cc analysis.cc random.cc )

set(CDHDRS ref.cd random.cd random_basic.cd TCL_obj_base.cd netcomplexity.cd graph.cd cachedDBM.cd sparse_mat.cd analysis.cd analysisBLT.cd analysisCairo.cd plot.cd)



foreach(cdhdr ${CDHDRS})

  get_filename_component(fbase ${cdhdr} NAME_WE)
  set(inf ${CMAKE_SOURCE_DIR}/include/${fbase}.h)
  classdesc_generate_cd(${inf} ${cdhdr} ${CMAKE_SOURCE_DIR}/include)
endforeach()

#find the generated cd files
include_directories(${CMAKE_CURRENT_BINARY_DIR})


find_library(cairo cairo)

add_library(ecolab SHARED ${ECOLAB_SRCS} ${CDHDRS})
target_link_libraries(ecolab cairo)