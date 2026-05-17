{...}:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    oh-my-zsh = {
      enable = true;
      custom = "$HOME/.zsh-custom";
    };
    initContent = ''
      export EDITOR=nvim
      source $HOME/.zsh-custom/themes/headline.zsh-theme
      '';
  };
}
