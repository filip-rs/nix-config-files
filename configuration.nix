# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <home-manager/nixos>
      # (import "${home-manager}/nixos")
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixflipper"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Oslo";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };
  fonts.packages = with pkgs; [
    nerdfonts
  ];


  nixpkgs.config.allowUnfree = true;


  # Enable the X11 windowing system.
  # services.xserver.enable = true;



  # Configure keymap in X11
  services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # hardware.pulseaudio.enable = true;
  # OR
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.tailscale.enable = true;
  services.flatpak.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  #services.xserver.displayManager.sddm.enable = true;

  virtualisation.docker.enable = true;


  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
  };

  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = false;
  security.polkit.enable = true;

  networking.networkmanager.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.filip = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
    packages = with pkgs; [
      tree
    ];
  };


#   home-manager.users.filip = { pkgs, ... }: {
#     home.packages = [ pkgs.atool pkgs.httpie ];
# #     # programs.bash.enable = false;
# #     programs.zsh = {
# #       enable = true;
# #       enableCompletion = true;
# #       syntaxHighlighting.enable = true;
# #       autosuggestions.enable = true;
# #     };
# 
#      home.file.".config/hypr/hyprland.conf".text = ''
#        monitor=,preferred,auto,1
#        exec-once waybar
#        input {
#        kb_layout = no
#        }
#        bind=SUPER,Q,exec,alacritty
#      '';
#     home.stateVersion = "24.11";
#   };


  programs.firefox.enable = true;
  programs.tmux.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.variables.BROWSER = "librewolf";


  programs.zsh.enable = true;
  programs.zsh.promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";

  # programs.zoxide = {
  #   enable = true;
  #   enableZshIntegration = true;
  #   enableBashIntegration = true;
  #   options = [
  #     "--cmd cd"
  #   ];
  # };

  users.defaultUserShell = pkgs.zsh;


  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim     
    networkmanager
    neovim
    zsh
    wget
    hyprland
    wlsunset
    xdg-desktop-portal-hyprland
    wlroots
    xwayland
    libinput
    mesa
    vulkan-loader
    wayland
    wayland-protocols
    alacritty
    waybar
    neofetch
    fastfetch
    home-manager
    tmux
    killall
    xfce.thunar
    wofi
    htop
    zoxide
    eza
    pavucontrol
    sddm
    swaynotificationcenter
    obs-studio
    slurp
    grim
    vimPlugins.nvim-fzf
    vimPlugins.telescope-nvim
    lua
    fzf
    nodejs
    browsh
    w3m
    gh
    mullvad
    mullvad-vpn
    help2man
    tldr
    preload
    unzip
    zsh-powerlevel10k
    git
    wl-clipboard
    wayclip
    librewolf
    oguri
    feh
    swaybg
    networkmanagerapplet
    nwg-look
    thefuck
    nwg-dock-hyprland
    wlogout
    meslo-lgs-nf
    fzf
    fzf-zsh
    meson
    brightnessctl
    pipewire
    jetbrains-mono
    hyprlock
    clang
    gcc
    gnumake
    tailscale
    python3
    pulseaudio
    pamixer
    vscode
    zed-editor
    hyprcursor
    shades-of-gray-theme
    sweet
    whitesur-gtk-theme
    minikube
    docker
    docker-compose
    udiskie
    angryipscanner
    ninja
    cmake
    SDL2
    SDL2_image
    libjpeg
    libpng
    libtiff
  ];
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:


  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?

}

