https://linuxconfig.org/vim-tutorial
https://www.howtoforge.com/tutorial/how-to-use-markers-and-perform-text-selection-in-vim/

### marks words
using `v` (`shift+v`) to switch to the visual mode, then arks the words with narrow keys.
press `d` to select and the selected text will be cut/deleted

### paste text
using `p` to paste after the cursor

### Undo changes
using `u`

### delete line
using `dd` to delete a single line
using `ndd` (`3dd`) to delete N lines

### delete wordss
`d` and `w` (or `e`) to delete word
`d` and `$` for deleting to end of the line
`0` for beginning of the line
`$` for end of line
`2e` to end of the 2nd word
`4w` to beginning of the 4th word
`d3w` deleting 3 words 

### go to end of line
go to end of the line with `G` 
go to like n with `Gn`
Dis play number of line in file with `Ctrl + g`

### search 
`/keyword` for search forward
`?keyword` for search backward
`n` to jump forward to next keyword
`N` to jump backward to previous keyword