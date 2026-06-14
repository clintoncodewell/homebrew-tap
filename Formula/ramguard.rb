class Ramguard < Formula
  desc "Lightweight macOS menu bar monitor for RAM, CPU, disk, and network"
  homepage "https://github.com/clintoncodewell/ramguard"
  url "https://github.com/clintoncodewell/ramguard/archive/refs/tags/v1.3.0.tar.gz"
  sha256 "084069f4fcf2957de8335e81d5f12452d589bdabe360373ddf561ff5ea10e703"
  version "1.3.0"
  license "MIT"

  head "https://github.com/clintoncodewell/ramguard.git", branch: "main"

  depends_on :macos
  depends_on xcode: ["14.0", :build]

  def install
    # The compiled binary is gitignored, so the MacOS dir is absent in the tarball.
    mkdir_p "RamGuard.app/Contents/MacOS"

    system "swiftc", "-Osize",
           "-o", "RamGuard.app/Contents/MacOS/ramguard",
           "main.swift",
           "-framework", "Cocoa",
           "-framework", "UserNotifications"

    system "strip", "RamGuard.app/Contents/MacOS/ramguard"

    prefix.install "RamGuard.app"
  end

  def caveats
    <<~EOS
      To launch RamGuard:
        open #{prefix}/RamGuard.app

      To make RamGuard findable via Spotlight and Launchpad:
        ln -sf #{prefix}/RamGuard.app ~/Applications/RamGuard.app

      RamGuard lives in the menu bar (no Dock icon).
        Left-click  — open the process list / kill panel
        Right-click — toggle Memory / CPU / SSD / Network in the menu bar
    EOS
  end

  test do
    assert_predicate prefix/"RamGuard.app/Contents/MacOS/ramguard", :executable?
  end
end
