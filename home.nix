{ pkgs, lib, config, ... }:

{

  home.username = "lnk0";
  home.homeDirectory = lib.mkForce "/Users/lnk0";

  home.stateVersion = "24.05";

  programs.home-manager.enable = true;

  home.sessionPath = [
    "$HOME/.cargo/bin"
  ];

  home.packages = with pkgs; [
    # Utils
    zoxide
    htop
    curl
    httpie
    jq
    thefuck
    bitwarden-cli
    jankyborders
    oh-my-posh
    exercism
    flyctl
    aichat
    pipx

    # Tui
    gitui
    yazi
    glow
    gobang

    # Swift
    cocoapods

    # Java
    jdk11

    # Nodejs
    nodejs_22
    nodePackages.yarn
    nodePackages.typescript
    nodePackages.prettier
    nodePackages.typescript-language-server
    nodePackages.vscode-langservers-extracted
    nodePackages."@tailwindcss/language-server"

    # Bun
    bun

    # Go
    go
    gopls

    # Rust
    rustup

    #Elixir
    erlang
    elixir
    elixir-ls
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

  programs.oh-my-posh = {
    enable = true;
    settings = builtins.fromJSON (builtins.unsafeDiscardStringContext (builtins.readFile "${config.xdg.configHome}/nix-darwin/config_files/prompt.json"));
  };

  programs.helix = {
    enable = true;
    settings = {
      theme = "custom_theme";
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
      custom_theme = let
        bg = "transaparent";
      in {
        "inherits" = "rose_pine";
        "ui.background" = { bg = bg; };
        "ui.statusline" = { bg = bg; };
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
      ];
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "thefuck" ];
      theme = "robbyrussell";
    };
 
    shellAliases = {
      ff = "yazi .";
    };

    localVariables = {};
  };


 
  home.file."${config.xdg.configHome}/ghostty/config" = {
    text = ''
      theme = rose-pine
      macos-titlebar-style = hidden
      font-family = "GeistMono Nerd Font Mono"
      font-size = 15
      font-thicken = true
      window-padding-x = 12
      window-padding-y = 12
      cursor-style = block
    '';
  };


  home.file."${config.xdg.configHome}/aerospace/aerospace.toml" = {
    text = ''
      start-at-login = true

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

      alt-shift-1 = 'move-node-to-workspace 1'
      alt-shift-2 = 'move-node-to-workspace 2'
      alt-shift-3 = 'move-node-to-workspace 3'
      alt-shift-4 = 'move-node-to-workspace 4'

      alt-tab = 'workspace-back-and-forth'

      alt-comma = 'layout accordion horizontal vertical'
      alt-slash = 'layout tiles horizontal vertical'

      [[on-window-detected]]
      if.app-id = 'com.apple.iphonesimulator'
      run = 'layout floating'
      
    '';
  };

  home.file."${config.xdg.configHome}/helix/languages.toml" = {
    text = ''
    [[grammar]]
    name = "heex"
    source = { git = "https://github.com/phoenixframework/tree-sitter-heex.git" }
    
    [language-server]
    tailwindcss-ls = { command = "tailwindcss-language-server", args = [ "--stdio" ] }
    html-ls = { command = "vscode-html-language-server", args = [ "--stdio" ] }

    [language-server.eslint]
    command = "vscode-eslint-language-server"
    args = ["--stdio"]

    [language-server.eslint.config]
    codeActionsOnSave = { mode = "all", "source.fixAll.eslint" = true }
    format = { enable = true }
    nodePath = ""
    quiet = false
    rulesCustomizations = []
    run = "onType"
    validate = "on"
    experimental = {}
    problems = { shortenToSingleLine = false }

    [language-server.eslint.config.codeAction]
    disableRuleComment = { enable = true, location = "separateLine" }
    showDocumentation = { enable = false }

    [language-server.vscode-json-language-server.config]
    json = { validate = { enable = true }, format = { enable = true } }
    provideFormatter = true

    [language-server.vscode-css-language-server.config]
    css = { validate = { enable = true } }
    scss = { validate = { enable = true } }
    less = { validate = { enable = true } }
    provideFormatter = true

    [[language]]
    name = "typescript"
    language-servers = [ "typescript-language-server", "eslint" ]
    formatter = { command = "prettier", args = [ "--parser", "typescript" ] }
    auto-format = true

    [[language]]
    name = "tsx"
    language-servers = [ "typescript-language-server", "eslint", "tailwindcss-ls" ]
    formatter = { command = "prettier", args = [ "--parser", "typescript" ] }
    auto-format = true

    [[language]]
    name = "javascript"
    language-servers = [ "typescript-language-server", "eslint"]
    formatter = { command = "prettier", args = [ "--parser", "typescript" ] }
    auto-format = true

    [[language]]
    name = "jsx"
    language-servers = [ "typescript-language-server", "eslint", "tailwindcss-ls" ]
    formatter = { command = "prettier", args = [ "--parser", "typescript" ] }
    auto-format = true

    [[language]]
    name = "json"
    formatter = { command = "prettier", args = [ "--parser", "json" ] }
    auto-format = true

    [[language]]
    name = "css"
    language-servers = [ "vscode-css-language-server", "tailwindcss-ls" ]
    formatter = { command = "prettier", args = ["--parser", "css"] }
    auto-format = true

    [[language]]
    name = "elixir"
    file-types = ["ex", "exs"]
    language-servers = ["elixir-ls", "tailwindcss-ls", "html-ls"]
    auto-format = true

    [[language]]
    name = "heex"
    file-types = ["heex", "neex"]
    language-servers = ["elixir-ls", "html-ls"]
    auto-format = true
    '';
  };
}
