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
      bind C-c run \"tmux save-buffer - | xclip -i -sel clip\"
      bind C-v run \"tmux set-buffer $(xclip -o -sel clip); tmux paste-buffer\"
    ";
  };
}
