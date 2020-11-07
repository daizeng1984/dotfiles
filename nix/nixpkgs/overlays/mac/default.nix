self: super: {
  Firefox = super.callPackage ./firefox {};
  VLC = super.callPackage ./vlc {};

}

