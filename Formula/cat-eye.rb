class CatEye < Formula
  desc "Lightweight macOS menu bar app for GitHub Actions and PR status"
  homepage "https://github.com/clintoncodewell/cat-eye"
  url "https://github.com/clintoncodewell/cat-eye/archive/refs/heads/main.tar.gz"
  version "1.0.1"
  license "MIT"

  head "https://github.com/clintoncodewell/cat-eye.git", branch: "main"

  depends_on "gh"
  depends_on :macos
  depends_on xcode: ["14.0", :build]

  def install
    # Build the Swift binary
    system "swiftc", "-Osize",
           "-o", "CatEye.app/Contents/MacOS/cat-eye",
           "main.swift",
           "-framework", "Cocoa",
           "-framework", "UserNotifications"

    # Strip debug symbols for a smaller binary
    system "strip", "CatEye.app/Contents/MacOS/cat-eye"

    # Install the .app bundle into the Cellar prefix
    prefix.install "CatEye.app"
  end

  def caveats
    <<~EOS
      To launch Cat Eye:
        open #{prefix}/CatEye.app

      To make Cat Eye findable via Spotlight and Launchpad:
        ln -sf #{prefix}/CatEye.app ~/Applications/CatEye.app

      Cat Eye requires the GitHub CLI to be authenticated:
        gh auth login

      Configure repos to watch:
        mkdir -p ~/.config/cat-eye
        echo '{"repos":["owner/repo"]}' > ~/.config/cat-eye/config.json
    EOS
  end

  test do
    assert_predicate prefix/"CatEye.app/Contents/MacOS/cat-eye", :executable?
  end
end
