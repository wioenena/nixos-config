{
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
    ./git.nix
    ./nix-ld.nix
    ./steam.nix
    ./neovim.nix
    ./openssh.nix
    ./flatpak.nix
  ];

  programs = {
    bat.enable = true;
    bat.extraPackages = with pkgs.bat-extras; [
      batdiff
      batman
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
    bandwhich

    # Nix
    home-manager

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

    # --- Audio Control & Effects ---
    easyeffects

    # --- Wayland Desktop Environment Utilities ---
    wl-clipboard

    # --- Desktop Environment Utilities ---

    # --- Development & Technical Tools & Editors ---
    pkgs-unstable.vscode
    pkgs-unstable.zed-editor
    jetbrains-toolbox
    yaak
    bruno
    postman
    gh
    devtoolbox
    imhex
    nasm
    bun
    gcc
    clang
    (
      with dotnetCorePackages;
      combinePackages [
        sdk_10_0
        sdk_9_0
        sdk_8_0
      ]
    )
    deno
    go
    nodejs
    uv # Python package and project manager
    zvm # Zig version manager
    rustup
    openjdk
    godot
    godot-mono
    unityhub

    # --- Reverse Engineering Tools ---
    # ghidra

    # --- Web Browsing ---
    brave

    # --- Ricing & Visuals ---
    fastfetch
    cava
    clock-rs

    # --- Graphics & Design ---
    gimp
    pinta
    upscayl
    eyedropper
    switcheroo
    curtail
    inkscape
    krita
    libresprite
    blender
    davinci-resolve

    # --- Productivity & Office ---
    obsidian

    # --- Multimedia (Video/Audio Players & Editors) ---
    vlc
    mpv

    # --- Communication & Email ---
    discord

    # --- Security & Privacy ---

    # --- Gaming & Compatibility Layers ---
    wineWowPackages.stableFull
    winetricks
    (bottles.override {
      removeWarningPopup = true;
    })
    heroic
    prismlauncher
    protonplus
    mangohud
    goverlay

    # --- Others ---
  ];
}
