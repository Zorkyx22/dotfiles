{config, pkgs, ...}:
{
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      custom = "$HOME/.zsh-custom";
      theme = "headline";
    };
  };
}
