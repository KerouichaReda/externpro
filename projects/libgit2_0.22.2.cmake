# libgit2
set(VER 0.22.2)
xpProOption(libgit2_${VER} DBG)
set(REPO https://github.com/smanders/libgit2)
set(PRO_LIBGIT2_${VER}
  NAME libgit2_${VER}
  WEB "libgit2" https://libgit2.github.com/ "libgit2 website"
  LICENSE "open" "https://github.com/libgit2/libgit2/blob/master/README.md#license" "GPL2 with linking exception"
  DESC "portable, pure C implementation of the Git core methods"
  REPO "repo" ${REPO} "forked libgit2 repo on github"
  GRAPH BUILD_DEPS libssh2_1.5.0
  VER ${VER}
  GIT_ORIGIN git://github.com/smanders/libgit2.git
  GIT_UPSTREAM git://github.com/libgit2/libgit2.git
  GIT_TAG xp${VER}
  GIT_REF v${VER}
  DLURL ${REPO}/archive/v${VER}.tar.gz
  DLMD5 67e0aca83964bfbb5c8806854f13fa41
  DLNAME libgit2-${VER}.tar.gz
  PATCH ${PATCH_DIR}/libgit2_${VER}.patch
  DIFF ${REPO}/compare/libgit2:
  )
