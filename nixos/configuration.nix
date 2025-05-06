# Edit this configuration file to define what should be installed on
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
  networking.hostName = "Panasonic-NixOS"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  
  # Enable networkManager to control network
  networking.networkmanager.enable = true;

  # Enable firewall
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
     
      # Xfce in no desktop mode (a separate WM needs to be loaded to use)
            # xfce = {
            #enable = true;
            #noDesktop = true;
            #enableXfwm = false;
            #};
    };
    
    # Window managers
    windowManager = {
      
     # bspwm (for Xfce)
            #bspwm = {
            #enable = true;
       # Needs to be ABSOLUTE PATH | /home/user/.config/bspwm/bspwmrc
       # configFile = "";
            #};
            
            #bspwm.sxhkd = {
        # Needs to be ABSOLUTE PATH | /home/user/.config/sxhkd/sxhkdrc
        # configFile = "";
            #};

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
 
   # TLP for battery (laptop ONLY, will conflict wil gnome power profiles)
   # services.tlp = {
   #   enable = true;
   # };

   # Thermald for overheat protection
    # services.thermald = {
    # enable = true;
   #};

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
   #  # Whether to enable XWayland
   #  xwayland.enable = true;
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
  # services.xserver.libinput.enable = true;

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

  # Steam install/nable
  programs.steam.enable = true; 

  # Flatpak install/enable
  services.flatpak.enable = true;

  # Main place to install apps
  environment = { 
    systemPackages = with pkgs; [
    
    # Terminals
    ghostty
    alacritty

    # Terminal Shit
    vim 
    git
    bat
    fzf
    wget
    curl
    btop
    tree
    hwinfo
    neovim
    figlet
    pfetch
    neofetch

    # Neovim with tonybanters config
    gcc
    nodejs

    # Gnome Extras
    gnome-tweaks   
    gnome-extension-manager
    gnome-software # For flatpaks
    alacarte
    lm_sensors # For freon

    # Xfce Extras
    # xfce.xfce4-panel
    # xfce.xfce4-settings
    # xfce.xfce4-pulseaudio-plugin
    
    # Window Manager Extras
    feh
    # rofi
    # nitrogen # X11 Only
    # picom  
    # lxappearance
    # betterlockscreen

    # Bspwm Extras
            #sxhkd

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
	    input-remapper

	    # Testing
	    distrobox

	    # Extras/Misc
	    mission-center
     
    ];
    
    # Intellij Shit
    #  etc = with pkgs; {
    #    "jdk23".source = jdk23;
    #  };
    
      #variables.JAVA_HOME = ${pkgs.jdk23.home}/lib/openjdk;
  };

  # Distrobox
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  #programs.java.enable = true;
  # environment.variables.JAVA_HOME = ${pkgs.jdk23.home}/lib/openjdk;  

  # Main place to install fonts
  fonts.packages = with pkgs; [
    hermit
    nerdfonts
    corefonts
    vistafonts
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
        #evince
    # file-roller
    geary
    # gnome-disk-utility
    # gnome-shell-extensions
    # adwaita-icon-theme
    # nixos-background-info
    # gnome-backgrounds
    # gnome-bluetooth
    # gnome-color-manager
    # gnome-control-center
    # gnome-shell-extensions
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
