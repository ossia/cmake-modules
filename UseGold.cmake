function(use_gold theTarget)
    if(UNIX AND NOT APPLE)
        target_link_libraries(${theTarget} "-fuse-ld=gold" "-Wl,-z,defs")
    endif()
endfunction()