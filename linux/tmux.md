#### Adjusting pane size
- resize up 5 rows -- `Ctrl`+`B` -> `Shift`+`:` -> resize-p -U 5 
- resize down 5 rows -- `Ctrl`+`B` -> `Shift`+`:` -> resize-p -D 5
- resize left 5 rows -- `Ctrl`+`B` -> `Shift`+`:` -> resize-p -L 5
- resize right 5 rows -- `Ctrl`+`B` -> `Shift`+`:` -> resize-p -R 5

#### Navigate
```
ctrl + b -> [ 
# Go to line in the output
shift + g -> line number
```

#### Session
A session in `tmux` is a workspace that contains:
- multiple windows
- each window can have multiple panes
- runs independently of terminals or SSH connections
```
tmux new-session -s my_session
tmux list-sessions
tmux attach-session -t my_session
tmux kill-session -t my_session
```

#### Client
A client is a terminal window that is attached to a tmux session
- Multiple cliets can be connected to the same session at the same time
- Disconnecting a client dones not kill the session
```
tmux list-clients
tmux detach-client -t /dev/pts/3
tmux kill-client -t /dev/pts/3
```

### Appendix

#### tmux tutorial
https://www.ionos.de/digitalguide/server/knowhow/tmux-terminal-multiplexer/

#### Adjusting pane size
https://performancemanager5.successfactors.eu/sf/learning?Treat-As=WEB&bplte_company=AZGROUPPROD&_s.crb=C3HioZeGRncwtbgJx%252fVEUBWT%252bI0%253d
