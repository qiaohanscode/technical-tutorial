# git-tutorial
create a new repository on the command line
```sh
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
configure credential helper store
```sh
git config --global credential.helper 'store --file ~/.github-credentials'
git credential-store --file ~/.github-credentials store
protocol=https
host=github.com
username=GIT_USER
password=PRIVATE_ACCESS_TOKEN

```

