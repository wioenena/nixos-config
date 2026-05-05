{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Libs
    libnotify
    (pkgs.ffmpeg-full.override {
      withUnfree = true;
    })

    # Filesystem utilities
    dosfstools
    exfatprogs
    e2fsprogs
    btrfs-progs
    ntfs3g
  ];
}
