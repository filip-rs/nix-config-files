{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "filip";
  home.homeDirectory = "/home/filip";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  nixpkgs.config.allowUnfree = true;

# {
#   home-manager.users.justinas = {
#     dconf.settings = {
#       "org/gnome/desktop/background" = {
#         picture-uri-dark = "file://${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.src}";
#       };
#       "org/gnome/desktop/interface" = {
#         color-scheme = "prefer-dark";
#       };
#     };

    gtk = {
      enable = true;
      theme = {
        name = "Adwaita-dark";
        package = pkgs.gnome.gnome-themes-extra;
      };
    };

    # Wayland, X, etc. support for session vars


  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;

    initExtra = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
    '';

# 
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "thefuck" ];
      theme = "robbyrussell";
    };


    shellAliases = {
      makevenv="python -m venv .venv";
      pyvenv="chmod +x .venv/bin/activate && source .venv/bin/activate";
      please="sudo";
      fking="sudo";
      bro="sudo";
      pls="sudo";
      wifilist="nmcli device wifi list";
      wificonnect="nmcli device wifi connect";
      c="clear";
      nfch="neofetch";
      lss="eza --tree --icons --level=2";
      lsss="eza --tree --icons --level=3";
      lssss="eza --tree --icons --level=4";
      ls="eza --icons";
      la="eza --long --header --icons --git --all";
      py="python";
      #wifix="rfkill unblock wlan";
      serialfix="sudo chmod +766 /dev/ttyACM0";
      #cpufetch="cpufetch --style fancy --color 230,50,45:240,230,230:0,0,0:250,70,65:170,170,170";
      fetch="fastfetch";
      ff="clear && fastfetch";
      update="sudo nixos-rebuild switch";
      home="home-manager switch";
      # desktopentry="/usr/share/applications/";
      # nvide="nohup neovide & disown";
      # desktopentry="cd /usr/share/applications/";
      bt="sudo systemctl start bluetooth";
      btui="bluetuith";
      #webpconvert="for file in *.webp; dwebp $file -o ${file/%.webp/.png} && rm $file";
      #heicconvert="for file in *.heic; do heif-convert $file ${file/%.heic/.png}; done";
      #gpt="chatgpt.sh -cc";

      nixconf="sudo nvim /etc/nixos/configuration.nix";
      homeconf="nvim ~/.config/home-manager/home.nix";


      #### might actually enable this one day
      # qrc="qrencode -t UTF8";


      #mccmd="mcrcon -H 129.241.208.10 -P 25575 -p ";
      };
    history.size = 10000;
    };


# defaultapps
  xdg.mimeApps.enable = true;
  xdg.mimeApps.defaultApplications = {
    "x-scheme-handler/http" = "librewolf.desktop";
    "x-scheme-handler/https" = "librewolf.desktop";
  };

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''
      exec-once = waybar
      exec-once = swaync
      exec-once = swaybg -i ~/Downloads/wallimg.png
      exec-once = nm-applet --no-agent --indicator # systray app for Network/Wifi
      exec-once = nwg-dock-hyprland -i 32 -nolauncher -l "top" -mb -49


      monitor=,preferred,auto,1

      env = GDK_SCALE,1
      env = XCURSOR_SIZE, 21
      env = GDK_DPI_SCALE,1
      # env = GTK_THEME,Breeze-Dark
      env = GTK_THEME,Orchis-Dark-Compact
 

      # █ █▄░█ █▀█ █░█ ▀█▀
      # █ █░▀█ █▀▀ █▄█ ░█░

      input {
        kb_layout = no
        kb_variant = winkeys
        kb_options = caps:escape

        # kb_options = grp:lctrl_lalt_toggle

        follow_mouse = 1
        
        accel_profile = flat
        sensitivity = 0.5 # -1.0 - 1.0, 0 means no modification.
        
        touchpad {
          natural_scroll = yes
          disable_while_typing = no
          scroll_factor = 0.2
        }
      }

      ############## GENERAL

      general {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more

        gaps_in = 4
        gaps_out = 7
        border_size = 1
        #border_size = 0
        col.active_border = rgba(eeeeee44) 
        # col.active_border=rgba(cdd6f4cc)
        col.inactive_border = rgba(00000044)

        layout = dwindle
      }
        
      misc {
        disable_hyprland_logo = yes
        animate_manual_resizes = true
        vrr = 0
      }


      
      decoration {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        rounding = 14
      }


      dwindle {
          # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more

          pseudotile = yes 
          preserve_split = yes      # you probably want this
      }
      
      master {
          # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
          #new_is_master = true
      }
      
      gestures {
          workspace_swipe = on
          workspace_swipe_forever = true
          # workspace_swipe_numbered = true
      }

      layerrule = blur,logout_dialog
      windowrulev2=noblur,class:^()$,title:^()

  
      $mainMod = SUPER

      # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
      bind = $mainMod, Q, exec, alacritty  #open the terminal
      bind = $mainMod, X, killactive, # close the active window
      bind = $mainMod, W, exec, librewolf # close the active window
      # bind = $mainMod, O, exec, swaylock # Lock the screen
      # bind = $mainMod, U, exec, wlogout --protocol layer-shell # show the logout window
      bind = $mainMod SHIFT, M, exit, # Exit Hyprland all together no (force quit Hyprland)
      bind = $mainMod, E, exec, thunar # Show the graphical file browser
      bind = $mainMod, V, togglefloating, # Allow a window to float
      bind = $mainMod, F, fullscreen, # Allow a window to float
      bind = $mainMod, SPACE, exec, wofi --show drun# Show the graphicall app launcher
      bind = $mainMod SHIFT, S, exec, grim -g "$(slurp)" - | wl-copy # take a screenshot
      bind = $mainMod SHIFT, N, exec, swaync-client -t -sw # open notif centre


      bind = $mainMod, D, exec, hyprctl dispatch workspace +1 # Move 1 workspace to the right
      bind = $mainMod, A, exec, hyprctl dispatch workspace -1 # Move 1 workspace to the left
      
      bind = MOD5, D, exec, hyprctl dispatch workspace +1 # Move 1 workspace to the right
      bind = MOD5, A, exec, hyprctl dispatch workspace -1 # Move 1 workspace to the left

      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod SHIFT, mouse:272, resizewindow

      # Alt+Tab to cycle through windows
      bind = ALT, TAB, cyclenext
      # bind = SUPER, SHIFT TAB, cyclenext, previous

      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      bind = $mainMod SHIFT, 1, movetoworkspace, 1
      bind = $mainMod SHIFT, 2, movetoworkspace, 2
      bind = $mainMod SHIFT, 3, movetoworkspace, 3
      bind = $mainMod SHIFT, 4, movetoworkspace, 4
      bind = $mainMod SHIFT, 5, movetoworkspace, 5
      bind = $mainMod SHIFT, 6, movetoworkspace, 6
      bind = $mainMod SHIFT, 7, movetoworkspace, 7
      bind = $mainMod SHIFT, 8, movetoworkspace, 8
      bind = $mainMod SHIFT, 9, movetoworkspace, 9
      bind = $mainMod SHIFT, 0, movetoworkspace, 10



      # ▄▀█ █▄░█ █ █▀▄▀█ ▄▀█ ▀█▀ █ █▀█ █▄░█
      # █▀█ █░▀█ █ █░▀░█ █▀█ ░█░ █ █▄█ █░▀█
      
      
      # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
      
      
      animations {
          enabled = yes
          bezier = wind, 0.1, 0.9, 0.1, 1    # Small overshoot on standard animation
          bezier = winIn, 0.1, 1.05, 0.1, 1  # Minor overshoot for entry
          bezier = winOut, 0.3, 0.2, 0.05, 1    # Smooth without overshoot on exit
          bezier = liner, 1, 1, 1, 1            # Linear for steady animations
      
          animation = windows, 1, 4, wind, slide        # Faster animation with subtle overshoot
          animation = windowsIn, 1, 4, winIn, slide
          animation = windowsOut, 1, 4, winOut, slide
          animation = windowsMove, 1, 4, wind, slide
          animation = border, 1, 1, liner
          animation = borderangle, 1, 100, liner, loop  # Border angle animation
          animation = fade, 1, 7, default               # Slightly faster fade
          animation = workspaces, 1, 4, wind
      }
      '';
    };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello
    pkgs.prismlauncher
    pkgs.notion-app-enhanced
    pkgs.slack
    # pkgs.discord

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/filip/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  };


  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
