# nixos/configuration.nix
{ pkgs, ... }:

let
  home-manager = builtins.fetchTarball {
    url = "https://github.com/nix-community/home-manager/archive/release-26.05.tar.gz";
    sha256 = "0z9ivs49j8n7r20kbyh86x59fl3izd90407djz678jfmwvp65pyp";
  };
in
{
  imports = [
    ./hardware-configuration.nix
    "${home-manager}/nixos"
    ./nix-extra/kde.nix
    ./nix-extra/fonts.nix
  ];

  home-manager = {
    users.spaceman = import ./home-manager/home.nix;
    backupFileExtension = "bak";
    useGlobalPkgs = true;
  };

  # Flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    systemd-boot = {
      enable = true;
      consoleMode = "auto";
    };
    efi = {
      canTouchEfiVariables = true;
    };
  };

  networking = {
    hostName = "Flow-Z13-NixOS";
    networkmanager.enable = true;
    firewall.enable = true;
  };

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
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
  };

  # System services
  services = {
    # Sets keyboard
    xserver.xkb = {
      layout = "us";
      variant = "";
    };
    libinput.touchpad.naturalScrolling = true; # Enables natural scrolling for touchpad
    gvfs.enable = true; # Automounting
    power-profiles-daemon.enable = true; # Power profiles
    upower.enable = true; # Upower | needed for bar
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."spaceman" = {
    isNormalUser = true;
    description = "Spaceman";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.fish;
  };

  # User shell
  programs.fish.enable = true;

  # * pwfeedback while typing in terminal
  security.sudo.extraConfig = ''
    Defaults pwfeedback
  '';

  # Custom systemd service to enable keyboard lights on boot
  systemd.services.kbs-backlight-max = {
    description = "Set keyboard backlight to max on boot";
    wantedBy = [ "multi-user.target" ];
    serviceConfig.Type = "oneshot";
    script = ''
      led=/sys/class/leds/asus::kbd_backlight
      for i in $(seq 1 30); do
        if [ -e "$led/max_brightness" ] && [ -e "$led/brightness" ]; then
          cat "$led/max_brightness" > "$led/brightness"
          exit 0
        fi
        sleep 1
      done
      echo "KB backlight led id not appear" >&2
      exit 1
    '';
  };

  systemd.services.wpa_supplicant.environment.OPENSSL_CONF = pkgs.writeText "openssl.cnf" ''
    openssl_conf = openssl_init
    [openssl_init]
    ssl_conf = ssl_sect
    [ssl_sect]
    system_default = system_default_sect
    [system_default_sect]
    Options = UnsafeLegacyRenegotiation
    [system_default_sect]
    CipherString = Default:@SECLEVEL=0
  '';

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };

  # User services
  # services = {
  #   displayManager.ly.enable = true; # TUI display manager
  # };

  services.displayManager.noctalia-greeter = {
    enable = true;
    settings = {
      cursor = {
        theme = "Bibata-Modern-Ice";
        size = 24;
        path = pkgs.bibata-cursors;
      };
    };
  };

  # User programs that need enable instead of pkgs
  programs = {
    niri.enable = true; # Window manager
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment = {
    # Sets $EDITOR variable
    variables.EDITOR = "nvim";

    # List of packages installed in system profile
    systemPackages = with pkgs; [

      # Terminal shit
      vim
      git
      feh
      bat
      wget
      curl
      btop
      tree
      tmux
      unzip
      nitch
      hwinfo
      pfetch
      gnumake
      tealdeer
      superfile
      alsa-utils
      quickshell
      asciiquarium
      brightnessctl

      # Hyprland shit
      wofi
      ashell
      waybar

      # Themes
      papirus-icon-theme
      bibata-cursors

      # Media
      vlc
      mpv
      discord
      protonup-qt

      # Browser
      librewolf

      # Experimenting
      # godot
      # httrack

      # Extra/Misc
      pcmanfm
      mission-center
      networkmanagerapplet

    ];
  };

  # "No touch" - Peter Griffin
  system.stateVersion = "26.05";
}
