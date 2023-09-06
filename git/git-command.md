# git-tutorial
create a new repository on the command line
```sh
create a new repository on Github.com
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/qiaohanscode/git-tutorial.git
git push -u origin main
```
delete branch from local repository
```sh
git branch -d main
```
delete branch from remote repository
```sh
git branch -d -r origin/main
git push -d origin main
```
create a new remote branch and push the changes to the new remote branch
```
git branch new-feature-branch & git switch new-feature-branch | git checkout -b new-feature-branch
git branch -u origin/new-feature-branch & git push origin new-feature-branch | git push -u origin new-feature-branch
```
change remote repository url
````aidl
git remote set-url origin <new-url> <old-url>
````
checkout a new remote branch after fetch
```
git switch new-remote-branch
```
create a tag and push to remote
```
git tag --list
git tag 0.0.4
git push --tag origin 0.0.4
```
delete a remote tag
```
git push --delete origin 0.0.4
```
compare current working to last commit
```
git diff
```
compare stash 1 with branch HEAD
```
git diff stash@{1} HEAD
```
compare between $COMMIT_1 und $COMMIT_2
```
git diff $COMMIT_1 $COMMIT_2
```
create a stash 
```
git stash push -m "message for stash"
```
show the change of  stash 1
```
git stash show -p 1
```
configure credential helper store
```sh
git config --global credential.helper 'store --file ~/.github-credentials'
git credential-store --file ~/.github-credentials store
protocol=https
host=github.com
username=GIT_USER
password=PRIVATE_ACCESS_TOKEN

```
change user.name and user.email
```
git config --global user.name=qiaohanscode
git config --global user.email=timhanq@hotmail.com
```
remove commit history
````
git checkout --orphan <branch_without_commit_history>
git add .
git commit -m "initial commit"
git branch -D main
git branch -m main
git push -f origin main
````

force commit unrecognized modification in binary files
````
git rm --cached src/main/resources/init-h2-file/dev.mv.db src/main/resources/init-h2-file/dev.trace.db
git commit -m "old h2 db file removed from working tree"
git push 
git add .
git commit -m "new user added to local h2"
git push 
````

change information of a certain commit
```
git switch branch_with_commit_to_change

git rebase -i previous_commit 
/* the last commit before the commit which information should be changed */

edit commit_to_change 
/* marks the commit to be changed in the editor opened by git rebase */

git commit --amend --author="qiaohanscode <timhanq@hotmail.com>" --date="$(date --date 'Mon, 04 Sep 2023 15:23:06 +0200')" 
/* change the author in the console opened by git rebase */

git rebase --continue 
/* return to the editor opended by git rebase */

git commit -m "commit information" 
/* add commit message in the editor opened by git rebase */

/* repeat the step above and process all the changes */

git rebase --continue 
/* the rebase will be terminated after all the commits have been processed */
```

fetch and remove any remote-tracking references that no longer exist on the remote
```
git fetch --all --prune
```
