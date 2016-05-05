set(MODEL_SRCS shadow.cc newman.cc jellyfish.cc webworld.cc netcomplexity.cc)

foreach(model ${MODEL_SRCS})
  get_filename_component(mod_exe_name ${model} NAME_WE)
  add_executable(${mod_exe_name} ${model})

 
endforeach()
