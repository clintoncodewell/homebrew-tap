class Ramguard < Formula
  desc "Lightweight macOS menu bar monitor for RAM, CPU, disk, and network"
  homepage "https://github.com/clintoncodewell/ramguard"
  url "https://github.com/clintoncodewell/ramguard/archive/refs/tags/v1.2.tar.gz"
  sha256 "99d866933422805aedad54fb5619628520df3445e3d5a67e52417ec038257986"
  version "1.2"
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
