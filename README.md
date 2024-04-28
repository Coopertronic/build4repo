# Automatic Mass Package Builder and Uploading Machine

This collection of scripts is designed to help automating running and maintaining your own ArchLinux package repository.

Currently these script only work in a specific way:

### `build4repo`

You must be in the same folder as the `PKGBUILD` file to successfully build a package.

Your package repository must be in `$HOME/pkgbuild/ctos-side-repo/` and your architecture must be `x86_64`.

This script is currently only setup with my preferences.

```bash
## Recycle
myLocalRepo="pkgBld/ctos-side-repo"
myArch="x86_64/"
thRepo="$HOME/$myLocalRepo/$myArch"
```



## `build4repo`

This script depends on `ctos-functions` in the [useful-bash-scripts](https://github.com/Coopertronic/useful-bash-functions) repo.

Build a package with the `PKGBUILD` and send it to the repo folder. A script that enables me to build a package for ArchLinux and send it to my side repo. It should clean up all it's own junk and work from one command. Only a password will be required for remote servers and `sudo` calls.

### Check `PKGBUILD` Exists

At first the script checks if there are any build scripts and assets in the `.pkgbuild` folder in the `PKGBUILD` folder. It will then copy the files out of the `.pkgbuild` folder into the `PKGBUILD` folder and then move the `.pkgbuild` folder to `../`

If the `.pkgbuild` folder does not exist then it will say so, but will not exit the script as some `PKGBUILD` scripts don't require any assets or install scripts to be there before `makepkg` is run.

### Build with `makepkg`

When the script runs it will invoke:

```bash
makepkg -csrf --sign
```

If the `-c` flag is used when build4repo is called then `--noconfirm` will be added to the end of the `makepkg` command.

If no `PKGBUILD` is found the script will exit and ask you to check your location.

### Copy to your repo

When the script has successfully built a package it will copy it to the repo folder. You can have this as whatever you want. I have put my repo here:

```bash
cp -vnr *.zst.* ~/pkgbuild/ctos-side-repo/x86_64/
```



#### Clean up

When the package has been successfully built the script will delete everything in the `PKGBUILD` folder and move the `.pkgbuild` folder from ../ back into the `PKGBUILD` folder. 

The script will then ask you to add a commit message before updating your git-repo. I keep my `PKGBUILD` folders in a git-repo so that any automatic changes that are made to scripts are updated. These changes are normally just git version numbers.

#### The Hand-off

The flags -n and -y work on their own. Nothing else is possible because of unchecked loops.

When the script has finished it can be asked to  hand-off to another script that will update your package repo with the new packages. I use a git repo to store my built signed packages and then pull them from the remote server that serves the packages.

The `build4repo` script can be called with 3 different flags that relate to the hand-off as follows:

- 0 = ask to hand-off
- 1 = no hand-off
- 2 = yes hand-off

The `build4repo` script will now accept flags in place of these integers for a more human readable format as follows:

- No flag = default (ask to hand-off)
- `-n` = no hand-off
- `-y` = yes hand-off
- `-c` = do not prompt user to continue or install dependencies

## `buildList`

This is the second script, which is a simple wrapper for the build4repo script. It also depends on

I will now attempt to put this type of info into a config-file. Of course there will need to be an extension to the scripts which check for a config file in `$HOME/.config/build4repo` and exits if one is not found. It can be further expanded to prompt for the creation and ask the user where everything is supposed to be found.

I think the best way to approach making a config-file is to look into `JSON` so I can have 1 config-file that tells the scripts all they need to know.

### The config-file

The config-file needs some key pieces of information:

- the location of where the built packages are stored.
- the location of the package builds repo.
- The Arch you are building for.

## Future ideas

Some ideas on expanding the script to make it more useful.

- [ ] A config file that allows you set the location for your package repo folder and the hand-off script.

- [x] Create a routine that checks if a package is actually old and not something that just has a similar name. 

- [x] Don't copy `.zst` and `.sig` files if they are identical in the package repo.
- [x] Get the `--noconfirm` flag running if passed, so that the script can pass it to `makepkg` to help automate the build procedure. This should also translated to the `to_continue` function in `ctos-functions` in the form of a wrapper called `auto-continue`, which will accept a `-c` flag to continue without input, ignoring the `to_continue` function.

- [x] Create a `buildList` script that accepts an array of folder names for `PKGBUILD` files and builds them, only updating the repo database when the list is complete.

- [ ] Make the git update auto commit message saying that the current git source was built.
