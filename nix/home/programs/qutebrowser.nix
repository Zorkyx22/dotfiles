{ ... }:

{
    programs.qutebrowser = {
      enable = true;
      settings = {
        window.transparent = true;
        editor.command = ["alacritty" "-e" "nvim" "{file}"];
        colors.webpage.darkmode.enabled = false;
      };
      extraConfig = ''
        import catppuccin
        catppuccin.setup(c, 'mocha', True)
        c.aliases['nix'] = 'open https://mynixos.com/search?q='
        c.aliases['ddg'] = 'open https://duckduckgo.com/?q='
        c.aliases['yt'] = 'open https://www.youtube.com/results?search_query='
      '';
 };
}

