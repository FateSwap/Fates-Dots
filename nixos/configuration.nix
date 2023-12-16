# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  # boot.loader.systemd-boot.enable = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "nodev";
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "Nixos-Stone"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  
  # Disable IPv6
  networking.enableIPv6 = false;
  boot.kernelParams = ["ipv6.disable=1"];
  
  # Graphics Driver
  
  # Enable OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {

    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
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
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
    open = false;

    # Enable the Nvidia settings menu,
	# accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
 
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

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.spaceman = {
    isNormalUser = true;
    description = "Spaceman";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Power Management
  services.tlp.enable = true;

  # Preload
  services.preload.enable = true;  

  # Audio
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;  

  # Display Manager
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.sddm.wayland.enable = true;
  services.xserver.enable = true;

  # Enable WM/DE
     
     # Hyprland
     programs.hyprland.enable = true;
     programs.hyprland.xwayland.enable = true;
     programs.hyprland.enableNvidiaPatches = true;
  
     # bspwm
     services.xserver.windowManager.bspwm.enable = true;
    
  # Shell
  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;
  
  # Steam
  programs.steam.enable = true;
  hardware.enableRedistributableFirmware = true;
  
  # GTK Theme (WIP)
 
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    
  # System Tools
    tlp
    vim
    vifm 
    wget
    git
    feh
    grub2
    os-prober
    lshw
    curl
    fish
    btop
    htop
    preload
    unzip
    zsync
    pfetch
    neofetch
    xdg-user-dirs

  # Audio
    pulseaudio
    ncpamixer
    pamixer
    pavucontrol
  
  # Brightness
    brightnessctl
    
  # Display Manager
    sddm
    sddm-chili-theme  
 
  # Window Manager/Desktop Env 
    # Hyprland 
      hyprland
      hyprland-protocols
      xdg-desktop-portal-hyprland
      kitty
      alacritty
      wofi
      waybar
    # bspwm
     # bspwm
     # sxhkd
     # polybar

  # WM/DE Utilities
    swww
    grim
    slurp 

  # Themes
    dracula-theme
    dracula-icon-theme

  # My Packages
    firefox 
    brave
    steam
    vscodium 
    hyprpicker
     
  ];
  
  fonts.packages = with pkgs; [ 
   # List all fonts here
    nerdfonts
    hermit
    noto-fonts
    font-awesome



  ];
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
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
  system.stateVersion = "23.05"; # Did you read the comment?

}
