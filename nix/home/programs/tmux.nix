{config, pkgs, ...}:

{
  programs.tmux = {
    enable = true;
    prefix = "C-Space";
    mouse = true;
    clock24 = true;
    shell = "${pkgs.zsh}/bin/zsh";
    baseIndex = 1;
    extraConfig = "
run ~/.config/.dotfiles/tmux/plugins/catppuccin/catppuccin.tmux
set-option -g allow-rename off

# Splitting windows
bind | split-window -h
bind - split-window -v
unbind '\"'
unbind %

# reloading config
bind r source-file ~/.config/tmux/tmux.conf

# switch panes using Alt-arrow without prefix
bind -n M-Left select-pane -L
bind -n M-Right select-pane -R
bind -n M-Up select-pane -U
bind -n M-Down select-pane -D";
  };
}
