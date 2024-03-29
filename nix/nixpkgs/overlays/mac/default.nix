self: super: with super; {
  Firefox = let version = "94.0.2"; in import(./util.nix) { inherit version; super=self;
    Name = "Firefox";
    src = fetchurl {
      name = "Firefox-${version}.dmg";
      url = "https://download-installer.cdn.mozilla.net/pub/firefox/releases/${version}/mac/en-GB/Firefox%20${version}.dmg";
      sha256 = "1jki1y7irplba99ax9mx7dx48l8f3kq2wfsj2yhilaw2bgfylwzf";
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

  Iterm2 = let version = "3_4_15"; in import(./util.nix) { inherit version; super=self;
    Name = "Iterm2";
    src = fetchurl {
      name = "iTerm2-${version}.zip";
      url = "https://iterm2.com/downloads/stable/iTerm2-${version}.zip";
      sha256 = "0y0vhxwn1cl0y1gjm5fad5zndb4v448mqcksbmmskpgg73h4wn9j";
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
  
  Cog = let version = "9feaffc9"; in import(./util.nix) { inherit version; super=self;
    Name = "Cog";
    src = fetchurl {
      name = "Cog-${version}.zip";
      url = "https://balde.losno.co/cog/Cog-${version}.zip";
      sha256 = "0q300aarnaim1jhdxxbb261pc1qlblljqr96imvr83j5rvhqay52";
    };
  };

  # TODO:!!!**NOT official google-chrome use at your own risk**
  # https://www.slimjet.com/chrome/google-chrome-old-version.php
  GoogleChrome = let version = "90.0.4430.72"; in import(./util.nix) { inherit version; super=self;
    Name = "GoogleChrome";
    src = fetchurl {
      name = "googlechrome.dmg";
      url = "https://www.slimjet.com/chrome/download-chrome.php?file=files/${version}/googlechrome.dmg";
      sha256 = "1qcc88pz1mgz3gvdma91plcffi6mj2vvb4ldkgfw6z068l5ga2gz";
    };
  };

  CornerCal = let version = "1.1"; in import(./util.nix) { inherit version; super=self;
    Name = "CornerCal";
    src = fetchurl {
      name = "CornerCal.zip";
      url = "https://github.com/ekreutz/CornerCal/blob/v${version}/builds/CornerCal.zip?raw=true";
      sha256 = "10d7y2dcrsh0420gh3y6900hz2n98p8gnypciyfphfsdswwm07rr";
    };
  };
  
  Kap = let version = "3.5.1"; in import(./util.nix) { inherit version; super=self;
    Name = "Kap";
    src = fetchurl {
      name = "Kap-${version}.dmg";
      url = "https://github.com/wulkano/kap/releases/download/v${version}/Kap-${version}.dmg";
      sha256 = "06xzghig5nal22cin2yax70sajzrx2jwqy00v95jp70fwgxxg4wf";
    };
  };
  
  Flameshot = let version = "0.10.2"; in import(./util.nix) { inherit version; super=self;
    Name = "Flameshot";
    src = fetchurl {
      name = "flameshot.dmg";
      url = "https://github.com/flameshot-org/flameshot/releases/download/v${version}/flameshot.dmg";
      sha256 = "1a9bwh7v7zwv746h684ajrb7h230nkcb9s6xdfcqfzbnarklrrr6";
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

