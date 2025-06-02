# MY SHITASS FUCKING CONFIG

{ config, pkgs, ... }:

# Home-manager as a NixOS module
#let
#  home-manager = builtins.fetchTarball https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz;
#in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
            #(import "${home-manager}/nixos")
    ];

  # Home-manager shit
    #home-manager.useUserPackages = true;
    #home-manager.useGlobalPkgs = true;
    #home-manager.backupFileExtension = "backup";
    #home-manager.users.spaceman = import ./home.nix;

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
  networking.hostName = "Omenking-NixOS"; # Define your hostname.
  
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
  
  # Nvidia stuff 

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {

    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of 
    # supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    open = false;

    # Enable the Nvidia settings menu,
	# accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  hardware.nvidia.prime = { # specific to laptop with nvidia and intel 
		offload = {
			enable = true;
			enableOffloadCmd = true;
		};
		# Make sure to use the correct Bus ID values for your system!
		intelBusId = "PCI:0:2:0";
		nvidiaBusId = "PCI:1:0:0";
                # amdgpuBusId = "PCI:54:0:0"; For AMD GPU
  };

  # End of nvidia stuff
  
  # Autoupdate/upgrade
  system.autoUpgrade = {
        enable = true;
        dates = "04:00";
  };

  # Enable preload
  services.preload.enable = true;
  
  # Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # SDDM wants to be special for some fucking reason
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  # Xserver (contains anything X11)
  services.xserver = {
    enable = true;

   # # Display Manager (GDM currently)
    displayManager = { 
            # gdm = {
            #   enable = true;
            #   wayland = true;
            # };
   };

   # # Desktop Manager (contains desktop enviorments)
   # desktopManager = {
 
   #   # Gnome with fixed scaling 
   #   gnome = {
   #     enable = true;
   #     extraGSettingsOverridePackages = [ pkgs.mutter ];
   #     extraGSettingsOverrides = ''
   #       [org.gnome.mutter]
   #       experimental-features=['scale-monitor-framebuffer']
   #     '';
   #   };
   #  
   #   # Xfce in no desktop mode (a separate WM needs to be loaded to use)
   #         # xfce = {
   #         #enable = true;
   #         #noDesktop = true;
   #         #enableXfwm = false;
   #         #};
   # };
    
    # Window managers
    windowManager = {
     
     # dwm
     dwm = {
       enable = true;
     };
    };
   };
 
   # Tells system to look for dwm source elseWhere
   services.xserver.windowManager.dwm.package = pkgs.dwm.overrideAttrs {
       # Location of dwm config
       src = /home/spaceman/.suckless/dwm;
   };
    
   # Enable ly 
    #services = {
    #  displayManager.ly = {
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
    layout = "us";
    variant = "";
  };

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
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
    extraGroups = [ "networkmanager" "wheel" "audio" "video" ];
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

  # XDG portal when desktop not installed ( for flatpak ) 
  xdg.portal = {
    enable = true;
    wlr.enable = true;
      config = {
          common = {
              default = [ "*" ];
          };
      };
  };

  # Enables automounting with pcmanfm
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  # Main place to install apps
  environment.systemPackages = with pkgs; [
    
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
    nitch
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

    # Home-Manager
        # base16-schemes # All default base16 themes

    # Nvim config
    fd
    fzf
    gcc
    luajit
    tree-sitter
    ripgrep
    xclip # X11 Only I think
    wl-clipboard # Wayland Only
    nodejs # Provides npm for mason.nvim
    rustup # Provide cargo for mason.nvim
    
    # Gnome Extras
    #gnome-tweaks   
    #gnome-extension-manager
    #gnome-software # For flatpaks
    #gradience # Gnome adwaita theming
    #alacarte
    #nautilus-open-any-terminal
    #lm_sensors # For freon
    #        # Gnome extensions 
    #        gnomeExtensions.desktop-cube
    #        gnomeExtensions.logo-menu
    #        gnomeExtensions.dash-to-dock
    #        gnomeExtensions.compiz-windows-effect
    #        gnomeExtensions.compiz-alike-magic-lamp-effect
    #        gnomeExtensions.extension-list
    #        gnomeExtensions.blur-my-shell
    #        gnomeExtensions.freon
    #        gnomeExtensions.impatience
    #        gnomeExtensions.just-perfection
    #        gnomeExtensions.media-controls
    #        gnomeExtensions.top-bar-organizer
    #        gnomeExtensions.appindicator
    #        gnomeExtensions.user-avatar-in-quick-settings



    # Window Manager Extras
    feh # X11 Only
    dunst
    swww # Wayland Only
    networkmanagerapplet # Network Applet
    volctl # Volume Applet | should replace
    blueman # Includes Bluetooth Applet
    xdg-user-dirs # Generates basic dirs
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
            amarok
	    vlc
	    mpv

	    # Games/Gaming Utils
	    discord
            godot
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

  # Distrobox
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  # They fucked up nerdfonts | gotta do this shit now

  # Main place to install fonts
  fonts.packages = with pkgs; [
    hermit
    iosevka
    corefonts
    vistafonts
    jetbrains-mono
        # All nerd fonts | they removed the nerdfonts package in 25.05
        nerd-fonts._0xproto 
        nerd-fonts._3270 
        nerd-fonts.adwaita-mono 
        nerd-fonts.agave 
        nerd-fonts.anonymice 
        nerd-fonts.arimo 
        nerd-fonts.atkynson-mono 
        nerd-fonts.aurulent-sans-mono 
        nerd-fonts.bigblue-terminal 
        nerd-fonts.bitstream-vera-sans-mono 
        nerd-fonts.blex-mono 
        nerd-fonts.caskaydia-cove 
        nerd-fonts.caskaydia-mono 
        nerd-fonts.code-new-roman 
        nerd-fonts.comic-shanns-mono 
        nerd-fonts.commit-mono 
        nerd-fonts.cousine 
        nerd-fonts.d2coding 
        nerd-fonts.daddy-time-mono 
        nerd-fonts.dejavu-sans-mono 
        nerd-fonts.departure-mono 
        nerd-fonts.droid-sans-mono 
        nerd-fonts.envy-code-r 
        nerd-fonts.fantasque-sans-mono 
        nerd-fonts.fira-code 
        nerd-fonts.fira-mono 
        nerd-fonts.geist-mono 
        nerd-fonts.go-mono 
        nerd-fonts.gohufont 
        nerd-fonts.hack 
        nerd-fonts.hasklug 
        nerd-fonts.heavy-data 
        nerd-fonts.hurmit 
        nerd-fonts.im-writing 
        nerd-fonts.inconsolata 
        nerd-fonts.inconsolata-go 
        nerd-fonts.inconsolata-lgc 
        nerd-fonts.intone-mono 
        nerd-fonts.iosevka 
        nerd-fonts.iosevka-term 
        nerd-fonts.iosevka-term-slab 
        nerd-fonts.jetbrains-mono 
        nerd-fonts.lekton 
        nerd-fonts.liberation 
        nerd-fonts.lilex 
        nerd-fonts.martian-mono 
        nerd-fonts.meslo-lg 
        nerd-fonts.monaspace 
        nerd-fonts.monofur 
        nerd-fonts.monoid 
        nerd-fonts.mononoki 
        nerd-fonts.noto 
        nerd-fonts.open-dyslexic 
        nerd-fonts.overpass 
        nerd-fonts.profont 
        nerd-fonts.proggy-clean-tt 
        nerd-fonts.recursive-mono 
        nerd-fonts.roboto-mono 
        nerd-fonts.sauce-code-pro 
        nerd-fonts.shure-tech-mono 
        nerd-fonts.space-mono 
        nerd-fonts.symbols-only 
        nerd-fonts.terminess-ttf 
        nerd-fonts.tinos 
        nerd-fonts.ubuntu 
        nerd-fonts.ubuntu-mono 
        nerd-fonts.ubuntu-sans 
        nerd-fonts.victor-mono 
        nerd-fonts.zed-mono
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
  system.stateVersion = "25.05"; # Did you read the comment?

}
