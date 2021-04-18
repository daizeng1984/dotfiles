self: super: with super; {
  Firefox = let version = "85.0.2"; in import(./util.nix) { inherit version; super=self;
    Name = "Firefox";
    src = fetchurl {
      name = "Firefox-${version}.dmg";
      url = "https://download-installer.cdn.mozilla.net/pub/firefox/releases/${version}/mac/en-GB/Firefox%20${version}.dmg";
      sha256 = "1iqpvqh8n47j81xq6qqq1pcd1vv5d98ahad8ab45a43d6fc2spyr";
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

  Shifty = let version = "1.1.2"; in import(./util.nix) { inherit version; super=self;
    Name = "Shifty";
    src = fetchurl {
      name = "Shifty-${version}.zip";
      url = "https://github.com/thompsonate/Shifty/releases/download/v${version}/Shifty-${version}.zip";
      sha256 = "0fkm80m4crzr3i66z16fvmwbsl0wv9w8jiwzlldsq1s9a3qyvnki";
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
  

  MonitorControl = let version = "2.1.0"; in import(./util.nix) { inherit version; super=self;
    Name = "MonitorControl";
    src = fetchurl {
      name = "MonitorControl.${version}.dmg";
      url = "https://github.com/MonitorControl/MonitorControl/releases/download/v${version}/MonitorControl.${version}.dmg";
      sha256 = "01pjmh94zvxk2zb73jdm4yi36qi2cvm28f9f0zqyk8q2l2b1lan0";
    };
  };
  
  Cog = let version = "4ea289ba"; in import(./util.nix) { inherit version; super=self;
    Name = "Cog";
    src = fetchurl {
      name = "Cog-${version}.zip";
      url = "https://balde.losno.co/cog/Cog-${version}.zip";
      sha256 = "1g7f3mw1ygi3kdcpiiixyjg1hnbhl0ryccdxqq287q0lsd14854f";
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

