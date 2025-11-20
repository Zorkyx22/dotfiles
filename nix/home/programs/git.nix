{ ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Zorkyx22";
        email = "icu.zorkyx@gmail.com";
      };
      init.defaultBranch = "main";
      pull.rebase = "false";
    };
  };
} 
