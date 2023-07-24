```
git rebase [-i|--interactive][--onto <newbase>|--keep-base] [<upstream> [<branch>]]
```
- If``<branch>`` is specified, git rebase will perform automatic ``git switch <branch>`` before doing anything else. Otherwise it remains on the current branch.
- If ``<upstream>`` is not specified, the upstream configured in ``branch.<name>.remote`` and ``branch.<name>.merge`` will be used. If ``<upstream>`` can not be identified, the rebase will abort.
- All changes made by commits in the current branch but that are not in `<upstream>` are saved to a temporary area. This is the same set of commits that would be shown by ``git log <upstream>..HEAD``.<br>
- The current branch is reset to ``<upstream>`` or ``<newbase>`` if the --onto option was supplied. This has the exact same effect as ``git reset --hard <newbase>``<br>
- The commits that were previously saved into the temporary area are then reapplied to the current branch, one by one, on order.<br>
``Note any commits in HEAD which introduce the same textual changes as a commit in HEAD..<upstream> are omitted.``
- In case of conflict, ``git rebase`` will stop at the first problematic commit. Use `git diff` to locate the markers(<<<<<<) and tell Git after the conflict has been solved with 
```
git add <filename>
```
After resolving the confilict, you can continue the rebasing process with
```
git rebase --continue

/* alternatively */

git rebase --abort
```
### Example
#### Using ``rebase --onto``
Assume the following history exists,
```
    o---o---o---o---o  master
         \
          o---o---o---o---o  next
                           \
                            o---o---o  topic
```
We want to make ``topic`` forked from branch ``master``,
```
    o---o---o---o---o  master
        |            \
        |             o'--o'--o'  topic
         \
          o---o---o---o---o  next
```
We can get this using the following command:
```
git rebase --onto master next topic
```
Assume the following history exists,
```
          A---B---C topic
         /
    D---E---F---G master
```
The following command 
```
git rebase master topic
```
will cause the result
```
                  A'--B'--C' topic
                 /
    D---E---F---G master
```
If the upstream branch already contains a change you have mode, then that commit will be skipped and warnings will be issued.  For example, running ``git rebase master`` on the following history
```
          A---B---C topic
         /
    D---E---A'---F master
```
will result in:
```
                   B'---C' topic
                  /
    D---E---A'---F master
```
