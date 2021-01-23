self: super: with super; {
  Firefox = let version = "84.0.2"; in import(./util.nix) { inherit version; super=self;
    Name = "Firefox";
    src = fetchurl {
      name = "Firefox-${version}.dmg";
      url = "https://download-installer.cdn.mozilla.net/pub/firefox/releases/${version}/mac/en-GB/Firefox%20${version}.dmg";
      sha256 = "1dmbkph9izmwymbkyll5lmhqbaikjfg13nbg9izjj27qcf4iijj5";
    };
  };

  VLC = let version = "3.0.11.1"; in import(./util.nix) { inherit version; super=self;
    Name = "VLC";
    src = fetchurl {
      name = "vlc-${version}.dmg";
      url = "https://mirrors.syringanetworks.net/videolan/vlc/${version}/macosx/vlc-${version}.dmg";
      sha256 = "1dcgvrc88jllqr85fg410af8r12zbkx6vmalnb1iww76yv9144h2";
    };
  };

  Phoenix = let version = "2.6.5"; in import(./util.nix) { inherit version; super=self;
    Name = "Phoenix";
    src = fetchurl {
      name = "phoenix-${version}.tar.gz";
      url = "https://github.com/kasper/phoenix/releases/download/${version}/phoenix-${version}.tar.gz";
      sha256 = "1pc2vh27wlyb1jiws3pxwd5zw2gz1srph0k2gqwpj1kicqydvbdx";
    };
  };

  Flux = let version = "master"; in import(./util.nix) { inherit version; super=self;
    Name = "Flux";
    src = fetchurl {
      name = "Flux.zip";
      url = "https://justgetflux.com/mac/Flux.zip";
      sha256 = "0pgpzx4ilrzn4ppb1hb53sjyxckgq3v9jpj7qpiwyl5l35ak0i0q";
    };
  };

  Iterm2 = let version = "3_4_3"; in import(./util.nix) { inherit version; super=self;
    Name = "Iterm2";
    src = fetchurl {
      name = "iTerm2-${version}.zip";
      url = "https://iterm2.com/downloads/stable/iTerm2-${version}.zip";
      sha256 = "1fgnm2mfp3n14ba8rlvl7y630w9pvbvyadyzxabzgpcbhd23imwy";
    };
  };
  

  # Karabiner has launchctl etc. 
  # KarabinerElements = let version = "13.1.0"; in import(./util.nix) { inherit version; inherit super;
  #   Name = "Karabiner-Elements";
  #   src = fetchurl {
  #     name = "Karabiner-Elements-${version}.dmg";
  #     url = "https://github.com/pqrs-org/Karabiner-Elements/releases/download/v${version}/Karabiner-Elements-${version}.dmg";
  #     sha256 = "0pgpzx4ilrzn4ppb1hb53sjyxckgq3v9jpj7qpiwyl5l35ak0i0q";
  #   };
  # };
}

