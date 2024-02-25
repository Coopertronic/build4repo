# build4repo
Build a package with the PKGBUILD and send it to the repo folder. A script that enables me to build a PACKAGE and send it to my side repo. It should clean up all it's own junk and work from one command. Only a password will be required for remote servers and sudo calls.

## check PKGBUILD exists

## makepkg
makepkg -csrf --sign
## copy to repo
cp -vir *.zst.* ~/pkgbuild/ctos-side-repo/x86_64/
