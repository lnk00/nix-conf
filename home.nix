{ pkgs, lib, config, ... }:


 
{

  home.username = "lnk0";
  home.homeDirectory = lib.mkForce "/Users/lnk0";

  home.stateVersion = "24.05";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # Utils
    zoxide
    htop
    curl
    jq
    thefuck

    # Tui
    gitui
    yazi

    # Swift
    cocoapods

    # Nodejs
    nodejs_18
    nodePackages.typescript
    nodePackages.typescript-language-server

    # Go
    go
    gopls

    # Dotnet
    dotnet-sdk_7
  ];

  programs.git = {
    enable = true;
    userName = "Damien Dumontet";
    userEmail = "damien.dumontet@protonmail.com";
    extraConfig = {
      core.editor = "helix";
    };
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [
      "--cmd cd"
    ]; 
  };

  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.helix = {
    enable = true;
    languages = {
    language = [
      {
        name = "typescript";
        auto-format = true;
        formatter = { command = "prettier"; args = ["--parser" "typescript"]; };
      }
      {
        name = "nix";
        auto-format = true;
        formatter = { command = "nixpkgs-fmt"; };
      }
    ];
  };
    settings = {
      theme = "tokyonight-custom";
      editor = {
        line-number = "relative";
        lsp.display-messages = true;
        indent-guides = {
          render = true;
          character = "┆";
          skip-levels = 1;
        };
      };
      keys = {
        normal = {
          up = "no_op";
          down = "no_op";
          left = "no_op";
          right = "no_op";
          space = {
            q = ":quit";
            w = ":write";
            z = ":reload";
          };
          g = {
            c = ":buffer-close";
          };
        };
        insert = {
          up = "no_op";
          down = "no_op";
          left = "no_op";
          right = "no_op";
          j = {
            k = "normal_mode";
          };
        };
      };
    };
    themes = {
      tokyonight-custom = let
        bg = "transaparent";
        fg = "#c0caf5";
        fg-dark = "#a9b1d6";
      in {
        "inherits" = "tokyonight";
        "ui.background" = { bg = bg; };
        "ui.text" = { bg = bg; fg = fg; };
        "ui.statusline" = { bg = bg; fg = fg-dark; };
        "ui.cursor" = { bg = "#c0caf5"; fg = "#1a1b26"; };
        "ui.cursor.match" = { fg = "#ff9e64"; modifiers = ["bold"]; };
      };
    };
  };
 
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; }
        { name = "romkatv/powerlevel10k"; tags = [ "as:theme" "depth:1" ]; }
      ];
    };

    plugins = [
      {
        name = "powerlevel10k-config";
        src = lib.cleanSource ./config_files;
        file = "p10k.zsh";
      }
    ];
      

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "thefuck" ];
      theme = "robbyrussell";
    };
 
    shellAliases = {
      ff = "yazi .";
    };

    localVariables = {
      POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD = true;
    };
  };


  programs.alacritty = {
    enable = true;


    settings = {
      import = [ pkgs.alacritty-theme.tokyo-night ];
      window.decorations = "Buttonless";
      window.opacity = 0.8;
      window.blur = true;
      window.padding = {
				x = 24;
				y = 24;
			};
      font = {
        size = 15.0;
        normal.family = "GeistMono Nerd Font Mono";
        bold.family = "GeistMono Nerd Font Mono";
        italic.family = "GeistMono Nerd Font Mono";
      };
    };
  };


  home.file."${config.xdg.configHome}/aerospace/aerospace.toml" = {
    text = ''
      [gaps]
      inner.horizontal = 12
      inner.vertical =   12
      outer.left =       12
      outer.bottom =     12
      outer.top =        12
      outer.right =      12

      [mode.main.binding]
      cmd-h = 'focus left'
      cmd-j = 'focus down'
      cmd-k = 'focus up'
      cmd-l = 'focus right'

      alt-cmd-h = 'move left'
      alt-cmd-j = 'move down'
      alt-cmd-k = 'move up'
      alt-cmd-l = 'move right'

      alt-cmd-minus = 'resize smart -50'
      alt-cmd-equal = 'resize smart +50'

      alt-1 = 'workspace 1'
      alt-2 = 'workspace 2'
      alt-3 = 'workspace 3'
      alt-4 = 'workspace 4'

      alt-tab = 'workspace-back-and-forth'
    '';
  };
}
