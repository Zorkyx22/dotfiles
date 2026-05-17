{ inputs, ... }:

{
    programs.firefox = {
      enable = true;
      configPath = "~/.config/mozilla/firefox";
      profiles.default = {
        id = 0;
        name = "default";
        isDefault = true;
        settings = {
          "browser.startup.homepage" = "https://mynixos.com";
          "browser.search.defaultenginename" = "duckduckgo";
          "browser.search.order.1" = "duckduckgo";
        };
        extensions.packages = with inputs.firefox-addons.packages."x86_64-linux"; [
          ublock-origin
          bitwarden
          darkreader
          vimium
      ];
      };
  };
}

