class Ramguard < Formula
  desc "Lightweight macOS menu bar monitor for RAM, CPU, disk, and network"
  homepage "https://github.com/clintoncodewell/ramguard"
  url "https://github.com/clintoncodewell/ramguard/archive/refs/tags/v1.2.1.tar.gz"
  sha256 "2982741b1a54c9944e5437ffcf4dc894c8885b13e34c49d403fb4c098e041831"
  version "1.2.1"
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
