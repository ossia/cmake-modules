function(sanitize_clang theTarget)
    target_compile_options(${theTarget} PUBLIC
        -fsanitize=undefined
        -fsanitize=integer
        -fsanitize=address
        -fno-omit-frame-pointer
        )
    target_link_libraries(${theTarget} PUBLIC
        -fsanitize=address
        )
endfunction()

function(sanitize_appleclang theTarget)
target_compile_options(${theTarget} PUBLIC
    -fsanitize=address
    -fno-omit-frame-pointer
  )
target_link_libraries(${theTarget} PUBLIC
    -fsanitize=address
  )
endfunction()

function(sanitize_gcc theTarget)
    if(NOT SCORE_PCH) ## Sanitizer won't work with PCHs
      target_compile_options(${theTarget} PUBLIC
        -fsanitize=undefined
        -fsanitize=address
        -fno-omit-frame-pointer
        -fuse-ld=gold
      )
      target_link_libraries(${theTarget} PUBLIC
          -fsanitize=address
          -fsanitize=undefined
          -fuse-ld=gold
      )
    endif()
endfunction()

function(sanitize_msvc theTarget)
endfunction()

function(sanitize_build theTarget)
    if ("${CMAKE_CXX_COMPILER_ID}" MATCHES "AppleClang")
        sanitize_appleclang(${theTarget})
    elseif ("${CMAKE_CXX_COMPILER_ID}" MATCHES "Clang")
        if(APPLE)
            sanitize_appleclang(${theTarget})
        else()
            sanitize_clang(${theTarget})
        endif()
    elseif ("${CMAKE_CXX_COMPILER_ID}" MATCHES "MSVC")
        sanitize_msvc(${theTarget})
    elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
        sanitize_gcc(${theTarget})
    endif()
endfunction()
