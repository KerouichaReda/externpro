# fftwcmake
set(REPO github.com/smanders/fftw-cmake)
set(PRO_FFTWCMAKE
  NAME fftwcmake
  SUPERPRO fftw
  SUBDIR .
  WEB "fftw-cmake" https://${REPO} "fftw-cmake project on github"
  LICENSE "GPL" "http://www.fftw.org/faq/section1.html#isfftwfree" "same license as FFTW"
  DESC "build FFTW via CMake"
  REPO "repo" https://${REPO} "fftw-cmake repo on github"
  VER 2015.06.03 # latest patch branch commit date
  GIT_ORIGIN git://${REPO}.git
  GIT_TAG patch # what to 'git checkout'
  GIT_REF e1f54fb # create patch from this to 'git checkout'
  PATCH ${PATCH_DIR}/fftw-cmake.patch
  DIFF https://${REPO}/compare/
  )
