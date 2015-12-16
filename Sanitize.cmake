function(sanitize_clang theTarget)
    if(NOT APPLE AND NOT WIN32) # Only for linux.
      # TODO : http://stackoverflow.com/a/30176092/1495627
      # Need to check for the libstdc++ abi.
      # target_compile_definitions(${TheTarget} PUBLIC
      #  $<$<CONFIG:Debug>:_GLIBCXX_DEBUG>
      #  $<$<CONFIG:Debug>:_GLIBCXX_DEBUG_PEDANTIC>
      #  )
    endif()

    target_compile_options(${theTarget} PUBLIC
      $<$<CONFIG:Debug>:-fsanitize=undefined>
      )
    target_link_libraries(${theTarget}
      $<$<CONFIG:Debug>:-lubsan> )
endfunction()

function(sanitize_gcc theTarget)
    target_compile_definitions(${TheTarget} PUBLIC
      $<$<CONFIG:Debug>:_GLIBCXX_DEBUG>
      $<$<CONFIG:Debug>:_GLIBCXX_DEBUG_PEDANTIC>
      )

    if(NOT ISCORE_COTIRE) ## Sanitizer won't work with PCHs
      target_compile_options(${theTarget} PUBLIC
        $<$<CONFIG:Debug>:-fsanitize=undefined>
      )
      target_link_libraries(${theTarget}
        $<$<CONFIG:Debug>:-fsanitize=undefined> )
    endif()
endfunction()

function(sanitize_msvc theTarget)
endfunction()

function(sanitize_build theTarget)
    if ("${CMAKE_CXX_COMPILER_ID}" MATCHES "Clang")
        sanitize_clang(${theTarget})
    elseif ("${CMAKE_CXX_COMPILER_ID}" MATCHES "MSVC")
        sanitize_msvc(${theTarget})
    elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
        sanitize_gcc(${theTarget})
    endif()
endfunction()
