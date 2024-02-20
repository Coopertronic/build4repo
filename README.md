# build4repo
build a package with the PKGBUILD and send it to the repo folder.

## check PKGBUILD exists

## makepkg
makepkg -csrf --sign
## copy to repo
cp -vir *.zst.* ~/pkgbuild/ctos-side-repo/x86_64/
## clean up

