# Dotfiles

## Management:

- Managed with stow
  - in dotfiles directory, run `stow !(bookmarklets)/` to create all links
    - note the `!(bookmarklets)/` glob because we don't need bookmarklets to be symlinked, they are just in this repo because they fit the theme
    - can run `stow -nv !(bookmarklets)/` to see what it will do without affecting the filesystem first
  - run `stow -D !(bookmarklets)/` to remove all links

## Goodies:

### Neovim:

- LSP setup for Python, Javascript, C/C++, Go, Java (!), Lua with lsp-zero.nvim, nvim-jdtls, and mason.nvim
- DAP (debugging) setup for Python, C/C++, Java (!!), Go with nvim-dap and nvim-dap-ui
  - dot-repeatable keybindings for stepping over, running to cursor, and toggling breakpoints!
- snippets, formatting on save
- fuzzy searching with telescope.nvim
  - search git files by default, fall back to all files if not in git repo
- script running on save in tmux pane with Vimux/vim-tmux-navigator
- git integration with vim-fugitive and diffview.nvim
  - toggle git status, git log, and other windows opened and closed with same keybind
- LaTeX setup with VimTeX

### Tmux:

- convenient searching in scrollback buffer with `ctrl+/`
- jump to any word in visible part of scrollback buffer with tmux-jump
- copy text in scrollback buffer to clipboard with tmux-yank
- save tmux sessions with tmux-resurrect

### Karabiner-Elements:

- caps lock to escape if pressed alone, control if pressed with another key
- `ctrl+w` deletes previous word everywhere like in Vim
- left/right shift moves forward/backward by one word
- yabai keybinds
- type letters with accents by pressing vowel + t/n/s as a chord

### Yabai:

- no disabling of System Integrity Protection
- only set window border if more than one window on screen
- swap current window with window on opposite display

### Bash:

- `ble.sh` configuration for better line editing, especially configured for Vim mode
- aliases/convenient shell functions in `.bash_profile`

### Notetaking:

- using Neovim with obsidian.nvim
- synced via iCloud Drive to Obsidian app on phone
- launched via `note` script
- automatically backed up daily to private GitHub repository using launchd (code not in this repository)

### Scripts:

- `note`: open note with command-line argument, use fzf to search if multiple matches
  - automatically rename tmux window to name of note
  - `note today` opens daily note
- `stopwatch`: Python stopwatch utility to be stopped with `ctrl+c`
- `multiplex`: open and tile minimal browser windows for last 4 URLs in clipboard (for watching multiple streams at once)
- `sc2mp3`: easily download MP3 files from SoundCloud and tag them with title, artist, album, and album art using yt-dlp

### Vim:

- portable, single-file .vimrc to have nice defaults when working on a remote machine

### Surfingkeys:

- open clipboard's GitHub URL (like "brookhong/Surfingkeys")
- when on DuckDuckGo, easily switch to Google with same query
- nice dark colorscheme for omnibar

### Bookmarklets:

- remove viewed jobs from various job boards (LinkedIn, Indeed)
- toggle full-page overlay with message for taking breaks
