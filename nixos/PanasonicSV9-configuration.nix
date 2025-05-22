# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader with resolution semi fixed
  boot.loader = {
    systemd-boot = {
      enable = true;
      consoleMode = "auto";
    };
    efi = {
      canTouchEfiVariables = true;
    };
  };

  # Sets hostname
  networking.hostName = "PanasonicSV9-NixOS"; # Define your hostname.
  
  # Enable networkManager and fireWall 
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
  
  # Autoupdate/upgrade
  system.autoUpgrade = {
        enable = true;
        dates = "04:00";
  };

  # Enable preload
  services.preload.enable = true;
  
  # Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Xserver (contains anything X11)
  services.xserver = {
    enable = true;
    
     # Display Manager (GDM currently)
     displayManager.gdm = {
       enable = true;
       wayland = true;
     };

    # Desktop Manager (contains desktop enviorments)
    desktopManager = {
 
      # Gnome with fixed scaling 
      gnome = {
        enable = true;
        extraGSettingsOverridePackages = [ pkgs.mutter ];
        extraGSettingsOverrides = ''
          [org.gnome.mutter]
          experimental-features=['scale-monitor-framebuffer']
        '';
      };
     };
    
    # Window managers
    windowManager = {
     
     # dwm
     dwm = {
       enable = true;
     };

     # i3
     # i3 = {
     #   enable = true;
     #   package = pkgs.i3-gaps;
      #  extraPackages = with pkgs; [
         # rofi
         # i3status
         # i3lock
         # i3blocks
      # ];
     # };
    };
   };
 
   # Tells system to look for dwm source elseWhere
   services.xserver.windowManager.dwm.package = pkgs.dwm.overrideAttrs {
       # Location of dwm config
       src = /home/spaceman/.suckless/dwm;
   };
    


   # TLP for battery (laptop ONLY, will conflict wil gnome power profiles)
   # services.tlp = {
   #   enable = true;
   # };

   # Enable ly instead of gdm
   # services = {
   #   displayManager.ly = {
   #    enable = true;
   #  };
   #};

   # Hyprland
    # programs.hyprland = {
    #  # Install the packages from nixpkgs
    #  enable = true;
    #  # Optional, hint Electron apps to use Wayland:
    #  #environment.sessionVariables.NIXOS_OZONE_WL = "1";
   #}; 

   # Configure keymap in X11
  services.xserver.xkb = {
    layout = "jp";
    variant = "";
  };

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.touchpad.naturalScrolling = true;

  # Gives * when typing passwd
  security = {
    sudo.extraConfig = 
      "Defaults pwfeedback";
  }; 

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.spaceman = {
    isNormalUser = true;
    description = "Spaceman";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
  };

  # Sets fish for shell
  programs.fish.enable = true; 

  # Sets $EDITOR variable
  environment.variables.EDITOR = "nvim";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Steam install/enable
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = false; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = false; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = false; # Open ports in the firewall for Steam Local Network Game Transfers
  };
    
  # Xbox controller driver
  hardware.xone.enable = true;

  # Flatpak install/enable
  services.flatpak.enable = true;

  # Main place to install apps
  environment = { 
    systemPackages = with pkgs; [
    
    # Terminals
    wezterm
    ghostty
    alacritty

    # Terminal Shit
    vim 
    git
    bat
    wget
    curl
    btop
    tree
    tmux
    unzip
    kitty
    hwinfo
    neovim
    figlet
    pfetch
    sysstat
    gnumake
    tealdeer
    pciutils
    neofetch
    alsa-utils
    asciiquarium
    brightnessctl
    xorg.xbacklight
    nvtopPackages.full

    # Nvim config
    fd
    fzf
    gcc
    luajit
    lua-language-server
    tree-sitter
    ripgrep
    xclip # X11 Only I think
    wl-clipboard # Wayland Only
    nodejs

    # Gnome Extras
    gnome-tweaks   
    gnome-extension-manager
    gnome-software # For flatpaks
    gradience # Gnome adwaita theming
    alacarte
    nautilus-open-any-terminal
    lm_sensors # For freon
            # Gnome extensions 
            gnomeExtensions.desktop-cube
            gnomeExtensions.logo-menu
            gnomeExtensions.dash-to-dock
            gnomeExtensions.compiz-windows-effect
            gnomeExtensions.compiz-alike-magic-lamp-effect
            gnomeExtensions.extension-list
            gnomeExtensions.blur-my-shell
            gnomeExtensions.freon
            gnomeExtensions.impatience
            gnomeExtensions.just-perfection
            gnomeExtensions.media-controls
            gnomeExtensions.top-bar-organizer
            gnomeExtensions.appindicator
            gnomeExtensions.user-avatar-in-quick-settings

    # Window Manager Extras
    feh # X11 Only
    dunst
    swww # Wayland Only
    networkmanagerapplet # Network Applet
    volctl # Volume Applet | should replace
    blueman # Includes Bluetooth Applet
    waypaper # Despite the name | works on both
    pywal16 # Color by wallpaper
        imagemagick # Color gen backend
    rofi # X11 Only
    picom # X11 Only 
    pcmanfm
    lxappearance
            # Themes
            gruvbox-dark-gtk
            gruvbox-dark-icons-gtk
    betterlockscreen

    # Hyprland Extras
    #eww
    #wofi
    #tofi
    #waybar
    #hyprlock
    #hyprpolkitagent
    #xdg-desktop-portal-hyprland

    # Dwm Extras with package overrides
    (pkgs.dmenu.overrideAttrs (oldAttrs: {
        name = "dmenu-custom";
        src = /home/spaceman/.suckless/dmenu;
    }))
    (pkgs.slstatus.overrideAttrs (oldAttrs: {
        name = "slstatus-custom";
        src = /home/spaceman/.suckless/slstatus;
    }))
    #(pkgs.dwmblocks.overrideAttrs (oldAttrs: {
    #    name = "dwmblocks-custom";
    #    src = /home/spaceman/.suckless/dwmblocks;
    #}))

    # Themeing
    papirus-icon-theme
    bibata-cursors
 
    # Browser
    brave
    firefox

    # Coding/School
    scenebuilder
    jetbrains-toolbox
    jdk23 # For intellij

    # My Stuff/Non-School
	
	    # Music/Media
	    strawberry
	    vlc
	    mpv

	    # Games/Gaming Utils
	    discord
	    lutris
	    protonup-qt

	    # Keyboard Fix
	    # input-remapper # For Panasonic Only

	    # Testing
	    distrobox

	    # Extras/Misc
	    mission-center
        obs-studio
    ];
    
 };

  # Distrobox
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  # Main place to install fonts
  fonts.packages = with pkgs; [
    hermit
    iosevka
    nerdfonts
    corefonts
    vistafonts
    jetbrains-mono
  ];

  # Xfce
  environment.xfce.excludePackages = with pkgs.xfce; [
    mousepad
    parole
    ristretto
    xfce4-appfinder
   ## xfce4-notifyd
   ## xfce4-screenshooter
   ## xfce4-session
   ## xfce4-settings
     xfce4-taskmanager
     xfce4-terminal 
     thunar
  ];

  # Gnome
  environment.gnome.excludePackages = with pkgs; [
    orca
    # evince
    # file-roller
    geary
    # gnome-disk-utility
    # gnomeExtensions
    # adwaita-icon-theme
    # nixos-background-info
    # gnome-backgrounds
    # gnome-bluetooth
    # gnome-color-manager
    # gnome-control-center
    # gnomeExtensions
    gnome-tour # GNOME Shell detects the .desktop file on first log-in.
    gnome-user-docs
    # baobab
    epiphany
    # gnome-text-editor
    gnome-calculator
    gnome-calendar
    gnome-characters
    gnome-clocks
    # gnome-console
    gnome-contacts
    # gnome-font-viewer
    # gnome-logs
    gnome-maps
    gnome-music
    # gnome-system-monitor
    gnome-weather
    # loupe
    # nautilus
    gnome-connections
    simple-scan
    snapshot
    totem
    yelp
    gnome-software
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon. EXAMPLE
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
