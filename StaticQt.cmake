function(disable_qt_plugins theTarget)
  if(NOT TARGET ${QT_PREFIX}::Core)
    return()
  endif()

  get_target_property(QtType ${QT_PREFIX}::Core TYPE)

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
  if(NOT TARGET ${QT_PREFIX}::Core)
    return()
  endif()

  get_target_property(QtType ${QT_PREFIX}::Core TYPE)
  if(NOT ("${QtType}" STREQUAL "STATIC_LIBRARY"))
    return()
  endif()

  function(link_if_exists _theLib)
    if(TARGET ${_theLib})
      target_link_libraries(${theTarget} PRIVATE ${_theLib})
    endif()
  endfunction()
  link_if_exists(${QT_PREFIX}::QXcbIntegrationPlugin)
  link_if_exists(${QT_PREFIX}::QXcbGlxIntegrationPlugin)
  link_if_exists(${QT_PREFIX}::QXcbEglIntegrationPlugin)
  link_if_exists(${QT_PREFIX}::QWaylandIntegrationPlugin)
  link_if_exists(${QT_PREFIX}::QWaylandXdgShellIntegrationPlugin)
  link_if_exists(${QT_PREFIX}::QWaylandXdgShellV5IntegrationPlugin)
  link_if_exists(${QT_PREFIX}::QWaylandXdgShellV6IntegrationPlugin)
  link_if_exists(${QT_PREFIX}::QWaylandWlShellIntegrationPlugin)
  link_if_exists(${QT_PREFIX}::QWaylandBradientDecorationPlugin)
  link_if_exists(${QT_PREFIX}::QWaylandFullScreenShellV1IntegrationPlugin)
  link_if_exists(${QT_PREFIX}::QWindowsIntegrationPlugin)
  link_if_exists(${QT_PREFIX}::QCocoaIntegrationPlugin)
  link_if_exists(${QT_PREFIX}::QEglFSIntegrationPlugin)
  link_if_exists(${QT_PREFIX}::QEglFSX11IntegrationPlugin)
  link_if_exists(${QT_PREFIX}::QEglFSKmsEglDeviceIntegrationPlugin)
  link_if_exists(${QT_PREFIX}::QEglFSKmsGbmIntegrationPlugin)
  link_if_exists(${QT_PREFIX}::QWasmIntegrationPlugin)

  link_if_exists(${QT_PREFIX}::QJpegPlugin)
  link_if_exists(${QT_PREFIX}::QTiffPlugin)
  link_if_exists(${QT_PREFIX}::QGifPlugin)
  link_if_exists(${QT_PREFIX}::QTgaPlugin)
  link_if_exists(${QT_PREFIX}::QWebpPlugin)
endfunction()
