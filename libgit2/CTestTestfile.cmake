# CMake generated Testfile for 
# Source directory: /Users/bhale/dev/sources/git-viewer-for-macos/vendor/libgit2
# Build directory: /Users/bhale/dev/sources/git-viewer-for-macos/libgit2
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(libgit2_clar "libgit2_clar" "-ionline")
add_test(libgit2_clar-cred_callback "libgit2_clar" "-v" "-sonline::clone::cred_callback")
