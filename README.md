vim-disapprove-deep-indentation
===============================

This Vim plugin disapproves deeply indented code.

![Disapproval in action](https://github.com/dodie/vim-disapprove-deep-indentation/blob/master/tty.gif "Disapproval")

By default, it shows ```ಠ_ಠ``` at the beginning of each line that is indented at least 5 levels.
It can be configured by with the following variables (setting them to 0 disables the feature):

```
let g:LookOfDisapprovalTabTreshold=5
let g:LookOfDisapprovalSpaceTreshold=(&tabstop*5)
```

![Disapproval in action](https://github.com/dodie/vim-disapprove-deep-indentation/blob/master/screenshot.png "Disapproval")

The plugin uses Vim's conceal feature. It does not modify the source code in any way, the disapproving
look is just a visual indicator.


##Installation

You can easily install this Plugin with
[Pathogen](https://github.com/tpope/vim-pathogen) or
[Vundle](https://github.com/gmarik/vundle).

Vim needs to be compiled with +conceal for the face to appear.

##Inspiration
The idea came from a comment made by [StripTheFlesh](https://www.reddit.com/user/StripTheFlesh) in
[this](https://www.reddit.com/r/programming/comments/5jwjfk/python_36_released/dbjoi2a/) thread on Reddit:

```
Just use ಠ_ಠ for indents. It will remind you to not use a lot indentation levels.
```

