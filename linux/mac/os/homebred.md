### install Homebrew
- check for Homebrew
  ```
  brew
  ```
- install brew
  ```
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ```
- verify Homebrew installation
  ```
  brew doctor
  ```
### After a macOS upgrade
After a macOS upgrade, the upgrade process may remove the Command Line Tools. You may encounter an error like

```
xcrun: error: invalid active developer path (/Library/Developer/CommandLineTools),
missing xcrun at: /Library/Developer/CommandLineTools/usr/bin/xcrun
```

Checking for the Command Line Tools folder may show that the folder is there
```
$ xcode-select -p
/Library/Developer/CommandLineTools
```

But look closely and the Command Line Tools folder may be missing essential folders
```
$ ls -l /Library/Developer/CommandLineTools
total 0
drwxr-xr-x  5 root  wheel  160 Jan  9 07:43 Library
drwxr-xr-x  5 root  wheel  160 Apr 24 16:19 SDKs
drwxr-xr-x  7 root  wheel  224 Apr 24 16:19 usr

$ ls -l /Library/Developer/CommandLineTools
total 0
drwxr-xr-x  7 root  wheel  224 Apr 24 16:19 usr
```

Homebrew will show problems,
```
% brew doctor

Warning: Git could not be found in your PATH.
Homebrew uses Git for several internal functions, and some formulae use Git
checkouts instead of stable tarballs. You may want to install Git:
  brew install git

Warning: No developer tools installed.
Install the Command Line Tools:
  xcode-select --install
```
Now re-install Xcode Command Line Tools
```
$ xcode-select --install
```







