{ ... }:
{
  programs.git = {
    enable = true;
    userName = "Zorkyx22";
    userEmail = "icu.zorkyx@gmail.com";
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      pull = {
        rebase = "false";
      };
    };
  };
} 
