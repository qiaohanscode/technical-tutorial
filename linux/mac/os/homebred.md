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
  
### Update brew installed applications
```
//update brew repository
brew update

//install update for applications which have been installed with brew
brew upgrade
```

### Install Openjdk@21
```
//search available package of jdk
brew search jdk

//find information about jdk 21
brew info openjdk@21

//install openjdk 21
brew install openjdk@21

// For the system Java wrappers to find this JDK, symlink it with
sudo ln -sfn /opt/homebrew/opt/openjdk/libexec/openjdk.jdk \
/Library/Java/JavaVirtualMachines/openjdk.jdk

//If you need to have openjdk@21 first in your PATH, run:
echo 'export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"' >> ~/.zshrc

//add JAVA_HOME to .zprofile
echo 'export JAVA_HOME=/opt/homebrew/opt/openjdk/bin' >> ~/.zprofile
```

### Install Openjdk@17
```
//search available package of jdk
brew search jdk

//find information about jdk 17
brew info openjdk@17

//install openjdk 17
brew install openjdk@17

// For the system Java wrappers to find this JDK, symlink it with
sudo ln -sfn /opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk \
/Library/Java/JavaVirtualMachines/openjdk-17.jdk

//If you need to have openjdk@17 first in your PATH, run:
echo 'export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"' >> ~/.zshrc

//add JAVA_HOME to .zprofile
echo 'export JAVA_HOME=/opt/homebrew/opt/openjdk@17/bin' >> ~/.zprofile
```

### Install Maven
```
//download and unzip maven binary
tar -xvf $MAVEN_BINARY_FILE $TARGET_DIR

//add maven installation path to ~/.zprofile
echo "export JAVA_HOME=/opt/homebrew/Cellar/openjdk@17/17.0.10/libexec/openjdk.jdk/Contents/Home" >> ~/.zprofile

//activate the change
source ~/.zprofile
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







