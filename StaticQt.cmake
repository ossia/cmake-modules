function(disable_qt_plugins theTarget)
  if(NOT TARGET Qt5::Core)
    return()
  endif()

  get_target_property(QtType Qt5::Core TYPE)

  if(NOT ("${QtType}" STREQUAL "STATIC_LIBRARY"))
    return()
  endif()

  set_target_properties(${theTarget}
    PROPERTIES
      QT_NO_PLUGINS
     "${Qt5Core_PLUGINS};${Qt5Gui_PLUGINS};${Qt5Widgets_PLUGINS};${Qt5Network_PLUGINS};${Qt5Qml_PLUGINS}"
  )
endfunction()

function(enable_minimal_qt_plugins theTarget)
  if(NOT TARGET Qt5::Core)
    return()
  endif()

  get_target_property(QtType Qt5::Core TYPE)
  if(NOT ("${QtType}" STREQUAL "STATIC_LIBRARY"))
    return()
  endif()

  if(TARGET Qt5::QXcbIntegrationPlugin)
    target_link_libraries(${theTarget} PRIVATE Qt5::QXcbIntegrationPlugin Qt5::QXcbGlxIntegrationPlugin)
  elseif(TARGET Qt5::QWindowsIntegrationPlugin)
    target_link_libraries(${theTarget} PRIVATE  Qt5::QWindowsIntegrationPlugin)
  elseif(TARGET Qt5::QCocoaIntegrationPlugin)
    target_link_libraries(${theTarget} PRIVATE  Qt5::QCocoaIntegrationPlugin)
  endif()

endfunction()
