# openssl
set(OPENSSL_OLDVER 1.1.1d)
set(OPENSSL_NEWVER 1.1.1d)
########################################
function(build_openssl)
  string(TOUPPER ${OPENSSL_OLDVER} OLDVER)
  string(TOUPPER ${OPENSSL_NEWVER} NEWVER)
  if(NOT (XP_DEFAULT OR XP_PRO_OPENSSL_${OLDVER} OR XP_PRO_OPENSSL_${NEWVER}))
    return()
  endif()
  if(WIN32)
    if(NOT (XP_DEFAULT OR XP_PRO_NASM))
      message(STATUS "openssl.cmake: requires nasm")
      set(XP_PRO_NASM ON CACHE BOOL "include nasm" FORCE)
      xpPatchProject(${PRO_NASM})
    endif()
    ExternalProject_Get_Property(nasm SOURCE_DIR)
    set(NASM_EXE "-DCMAKE_ASM_NASM_COMPILER=${SOURCE_DIR}/nasm.exe")
  endif()
  if(XP_DEFAULT)
    set(OPENSSL_VERSIONS ${OPENSSL_OLDVER} ${OPENSSL_NEWVER})
  else()
    if(XP_PRO_OPENSSL_${OLDVER})
      set(OPENSSL_VERSIONS ${OPENSSL_OLDVER})
    endif()
    if(XP_PRO_OPENSSL_${NEWVER})
      list(APPEND OPENSSL_VERSIONS ${OPENSSL_NEWVER})
    endif()
  endif()
  list(REMOVE_DUPLICATES OPENSSL_VERSIONS)
  list(LENGTH OPENSSL_VERSIONS NUM_VER)
  if(NUM_VER EQUAL 1)
    if(OPENSSL_VERSIONS VERSION_EQUAL OPENSSL_OLDVER)
      set(boolean OFF)
    else() # OPENSSL_VERSIONS VERSION_EQUAL OPENSSL_NEWVER
      set(boolean ON)
    endif()
    set(ONE_VER "set(XP_USE_LATEST_OPENSSL ${boolean}) # currently only one version supported\n")
  endif()
  set(MOD_OPT "set(VER_MOD)")
  set(USE_SCRIPT_INSERT ${ONE_VER}${MOD_OPT})
  configure_file(${PRO_DIR}/use/usexp-openssl-config.cmake ${STAGE_DIR}/share/cmake/
    @ONLY NEWLINE_STYLE LF
    )
  foreach(ver ${OPENSSL_VERSIONS})
    set(XP_CONFIGURE
      -DXP_NAMESPACE:STRING=xpro
      -DOPENSSL_VER:STRING=${ver}
      ${NASM_EXE}
      )
    xpCmakeBuild(openssl_${ver} "" "${XP_CONFIGURE}" opensslTargets_${ver})
    list(APPEND opensslTargets ${opensslTargets_${ver}})
  endforeach()
  if(ARGN)
    set(${ARGN} "${opensslTargets}" PARENT_SCOPE)
  endif()
endfunction()
