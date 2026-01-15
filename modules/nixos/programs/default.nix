{
  inputs,
  pkgs,
  pkgs-unstable,
  ...
}:
let
  system = pkgs.stdenv.hostPlatform.system;
in
{
  imports = [
    ./fish
    ./dconf
    ./git.nix
    ./nix-ld.nix
    ./steam.nix
    ./neovim.nix
    ./openssh.nix
    ./flatpak.nix
    ./gnome-keyring.nix
  ];

  programs = {
    bat.enable = true;
    bat.extraPackages = with pkgs.bat-extras; [
      batdiff
      batman
      prettybat
    ];

    direnv.enable = true;
    direnv.loadInNixShell = true;
    direnv.nix-direnv.enable = true;
    direnv.enableFishIntegration = true;
    direnv.silent = true;

    htop.enable = true;
    less.enable = true;
    nano.enable = true;
    starship.enable = true;
    tmux.enable = true;

    zoxide.enable = true;
    zoxide.enableFishIntegration = true;

    fzf.keybindings = true;
    fzf.fuzzyCompletion = true;
    obs-studio = {
      enable = true;
      plugins = with pkgs; [ obs-studio-plugins.obs-vkcapture ];
    };
    localsend.enable = true;
  };

  environment.systemPackages = with pkgs; [
    # --- Core System Utilities (GNU Standard) ---
    coreutils
    gnutar
    findutils
    diffutils
    gnugrep
    gnused
    gawk
    util-linux
    procps
    binutils
    file
    psmisc
    dateutils
    stress-ng

    # --- Modern CLI Tools (Better Alternatives) ---
    ripgrep
    eza
    fzf
    btop
    jq
    tree
    stow

    # --- Networking & Download ---
    wget
    curl
    rsync
    yt-dlp
    qbittorrent

    # --- Graphics & Design ---
    gimp
    pinta
    upscayl
    eyedropper
    curtail
    switcheroo

    # --- Multimedia (Video/Audio Players & Editors) ---
    vlc
    mpv
    shotcut
    handbrake
    kooha
    mousai

    # --- Audio Control & Effects ---
    pavucontrol
    easyeffects

    # --- Wayland Desktop Environment Utilities ---
    wl-clipboard
    grim
    slurp
    playerctl

    # --- For window managers ---
    dunst

    # --- Desktop Environment Utilities ---
    dconf-editor
    nwg-look

    # --- Development & Technical Tools & Editors ---
    alacritty
    vscode
    zed-editor
    jetbrains-toolbox
    yaak
    gh
    devtoolbox
    imhex
    gnome-boxes
    podman-desktop
    postman

    # --- Web Browsing ---
    brave

    # --- Ricing & Visuals ---
    feh
    fastfetch
    cava
    clock-rs

    # --- Nix & System Management ---
    home-manager

    # --- Communication & Email ---
    discord
    thunderbird

    # --- Gaming & Compatibility Layers ---
    wineWowPackages.stableFull
    winetricks
    (bottles.override {
      removeWarningPopup = true;
    })
    heroic
    prismlauncher
    protonplus
    mangojuice

    # --- Productivity & Office ---
    obsidian

    # --- Security & Privacy ---
    protonvpn-gui
    proton-pass

    # --- Flake Inputs (Custom Packages) ---
    inputs.awww.packages.${system}.awww
    inputs.matugen.packages.${system}.default
  ];
}
