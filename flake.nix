{
  description = "Example Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager }:
  let
    configuration = { config, lib, pkgs, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [ 
          pkgs.vim
          pkgs.helix
          pkgs.nil
        ];

      homebrew = {
        enable = true;
        # onActivation = {
        #   autoUpdate = true;
        #   cleanup = "uninstall";
        #   upgrade = true;
        # };

        casks = [
          "font-geist"
          "font-geist-mono-nerd-font"
          "font-hack-nerd-font"
          "font-sf-pro"
          "sf-symbols"
          "ghostty"
          "nikitabobko/tap/aerospace"
          "raycast"
          "microsoft-teams"
          "slack"
          "rider"
          "objectivesharpie"
          "vlc"
          "linearmouse"
          "proxyman"
          "zed"
          "google-chrome"
          "timemator"
        ];
      };

      nix.gc = {
        automatic = true;
        interval = { Day = 7; };
        options = "--delete-older-than 30d";
      };


      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;
      # nix.package = pkgs.nix;

      services.jankyborders.enable = true;
      services.jankyborders.active_color = "0xFFC4A7E7";
      services.jankyborders.inactive_color = "0x00FFFFFF";
      services.jankyborders.hidpi = true;
      services.jankyborders.blur_radius = 5.0;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      nix.extraOptions = ''
        extra-platforms = x86_64-darwin aarch64-darwin
      '';

      # Create /etc/zshrc that loads the nix-darwin environment.
      programs.zsh.enable = true;

      environment.shellAliases = {
        nxsource = "darwin-rebuild switch --flake ~/.config/nix-darwin --impure";
        nxconf = "hx ~/.config/nix-darwin/flake.nix";
        nxpush = "cd ~/.config/nix-darwin && git add . && git commit -m 'update' && git push";
        hmconf = "hx ~/.config/nix-darwin/home.nix";
      };

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 4;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";

      system.defaults = {
        dock.autohide = true;
        dock.mru-spaces = false;
        dock.minimize-to-application = true;
        dock.orientation = "right";
        dock.show-recents = false;
        WindowManager.AutoHide = true;
        finder.AppleShowAllExtensions = true;
        finder.AppleShowAllFiles = true;
        finder.FXPreferredViewStyle = "clmv";
        finder.ShowPathbar = true;
        NSGlobalDomain.KeyRepeat = 1;
        NSGlobalDomain.AppleInterfaceStyle = "Dark";
        dock.persistent-apps = [];
      };

    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#lnk0s-Mac-mini
    darwinConfigurations."lnk0s-Mac-mini" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
        ({ config, pkgs, ...}: {
          # install the overlay
        })
        inputs.home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.lnk0 = import ./home.nix;
          }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."lnk0s-Mac-mini".pkgs;
  };
}
