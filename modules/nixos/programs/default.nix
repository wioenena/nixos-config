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

    # --- Audio Control & Effects ---
    pavucontrol

    # --- Wayland Desktop Environment Utilities ---
    wl-clipboard

    # --- Desktop Environment Utilities ---
    nwg-look
    gnome-tweaks

    # --- Development & Technical Tools & Editors ---
    ptyxis
    vscode
    zed-editor
    jetbrains-toolbox
    yaak
    gh
    gnome-boxes
    nasm
    bun
    gcc
    clang
    (with dotnetCorePackages; combinePackages [
      sdk_10_0
      sdk_9_0
      sdk_8_0
    ])
    deno
    go
    nodejs
    uv # Python package and project manager
    zvm # Zig version manager
    rustup
    openjdk
		godot
		unityhub

    # --- Web Browsing ---
    brave

    # --- Ricing & Visuals ---
    fastfetch
    cava
    clock-rs

    # --- Nix & System Management ---
    home-manager

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
    mangojuice
  ];
}
