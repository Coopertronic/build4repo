# build4repo

This script depends on `ctos-functions` in the [useful-bash-scripts](https://github.com/Coopertronic/useful-bash-functions) repo.

Build a package with the `PKGBUILD` and send it to the repo folder. A script that enables me to build a package for ArchLinux and send it to my side repo. It should clean up all it's own junk and work from one command. Only a password will be required for remote servers and `sudo` calls.

## Check PKGBUILD Exists

At first the script checks if there are any build scripts and assets in the `.pkgbuild` folder in the `PKGBUILD` folder. It will then copy the files out of the `.pkgbuild` folder into the `PKGBUILD` folder and then move the `.pkgbuild` folder to `../`

If the `.pkgbuild` folder does not exist then it will say so, but will not exit the script as some `PKGBUILD` scripts don't require any assets or install scripts to be there before `makepkg` is run.

## makepkg

When the script runs it will invoke:

`makepkg -csrf --sign`

If no `PKGBUILD` is found the script will exit and ask you to check your location.

## Copy to your repo

When the script has successfully built a package it will copy it to the repo folder. You can have this as whatever you want. I have mine put it here:

`cp -vir *.zst.* ~/pkgbuild/ctos-side-repo/x86_64/`

##### Warning!

~~The script will look for older packages of the same suffix and deletes them. This has a slight bug at the moment where it does not check if the older files are actually for a different package, meaning that if `calamares` is built after `clalmares-settings` it will delete the settings package as well as the older calamares package. This can be an issue if you are building multiple packages as you will need the shortest similar prefixed package to be built first.~~

This warning has been fixed!

### Clean up

When the package has been successfully built the script will delete everything in the `PKGBUILD` folder and move the `.pkgbuild` folder from ../ back into the `PKGBUILD` folder. 

The script will then ask you to add a commit message before updating the git repo. I keep my PKGBUILD folders in a git repo so that any automatic changes that are made to scripts are updated. These changes are normally just git version numbers.

### The Hand-off

##### Warning!!

###### This is currently Broken!!

The flags -n and -y work on their own. Nothing else is possible because of unchecked loops.

When the script has finished it can be asked to  hand-off to another script that will update your package repo with the new packages. I use a git repo to store my built signed packages and then pull them from the remote server that serves the packages.

The `build4repo` script can be called with 3 different flags that relate to the hand-off as follows:

- 0 = ask to hand-off
- 1 = no hand-off
- 2 = yes hand-off

The `build4repo` script will now accept flags in place of these integers for a more human readable format as follows:

- No flag = default (ask to hand-off)
- `--no-rebuild or -n` = no hand-off
- `--rebuild-db or -y` = yes hand-off

## Future ideas

Some ideas on expanding the script to make it more useful.

- [ ] A config file that allows you set the location for your package repo folder and the hand-off script.

- [x] Create a routine that checks if a package is actually old and not something that just has a similar name. 

- [ ] Don't copy `.zst` and `.sig` files if they are identical in the package repo.
- [ ] Get the `--noconfirm` flag running if passed, so that the script can pass it to `makepkg` to help automate the build procedure. This should also translated to the `to_continue` function in `ctos-functions` in the form of a wrapper called `auto-continue`, which will accept a `-c` flag to continue without input, ignoring the `to_continue` function.

- [ ] Create a `buildList` script that accepts an array of folder names for `PKGBUILD` files and builds them, only updating the repo database when the list is complete.
