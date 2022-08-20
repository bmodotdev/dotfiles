# Tmux Cheat Sheet

## The tmux prefix
All tmux commands are prefixed by this character combination:

`ctrl + b`

Moving forward, this combo will be referred to as “prefix”.

## General
| combo                 | default   | description                   |
|-----------------------|-----------|-------------------------------|
| `prefix + ctrl + e`   | no        | edit and reload tmux config   |
| `prefix + ctrl + r`   | no        | redload tmux config           |
| `prefix + [`          | yes       | enter copy mode               |

## Windows
| combo                 | default   | description                   |
|-----------------------|-----------|-------------------------------|
| `prefix + c`          | yes       | create new window             |
| `prefix + n`          | yes       | switch to next window         |
| `prefix + l`          | yes       | switch to last window         |

## Panes
| combo                 | default   | description                   |
|-----------------------|-----------|-------------------------------|
| `preifx + ;`          | yes       | switch to last pane           |
| `prefix + \|`         | no        | split plane vertically        |
| `prefix + \ `         | no        | split plane vertically        |
| `prefix + _`          | no        | split plane horizontally      |
| `prefix + - `         | no        | split plane horizontally      |
| `prefix + ctrl + j`   | no        | resize pane down              |
| `prefix + ctrl + k`   | no        | resize pane up                |
| `prefix + ctrl + h`   | no        | resize pane left              |
| `prefix + ctrl + l`   | no        | resize pane right             |
