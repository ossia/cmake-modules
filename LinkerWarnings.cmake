function(add_linker_warnings theTarget)
    if(APPLE)
       # target_link_libraries(${theTarget} PRIVATE "-Wl,-fatal_warnings")
    endif()
endfunction()
