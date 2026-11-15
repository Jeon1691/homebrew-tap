class Clipsync < Formula
  desc "End-to-end encrypted multi-device clipboard sync"
  homepage "https://github.com/Jeon1691/clipsync"
  version "0.2.0"
  license "MIT"

  livecheck do
    url :homepage
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.2.0/clipsync-aarch64-apple-darwin.tar.gz"
      sha256 "4692f3adbd3434241981235a4a0f98f67d425aa0f257304ea3bb5362b13d9f8e"
    else
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.2.0/clipsync-x86_64-apple-darwin.tar.gz"
      sha256 "8ab317c21b034831b3c35de650bad116638c88154930fb1e72d41844457340ee"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.2.0/clipsync-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "588ed15396e26f60520e5aa10aef288968bea3f739e46e9c5d488b8942e62f01"
    else
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.2.0/clipsync-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f4c30e6bb54ec49faf1f8891e6fd05397fd17c39763527758a0b4a4e110afc8f"
    end
  end

  def install
    binary = File.exist?("clipsync") ? "clipsync" : Dir["clipsync-*/clipsync"].first
    odie "clipsync binary missing from archive" if binary.nil?
    bin.install binary
  end

  def post_install
    return if ENV["HOME"].to_s.empty?
    quiet_system bin/"clipsync", "init"
  end

  def caveats
    <<~EOS
      Default relay is https://clipsync.develicit.dev
      Device identity is created on install (or on first use).
      After pairing, the daemon starts at login and reconnects after reboot.

        clipsync room create
    EOS
  end

  test do
    assert_match "Usage: clipsync", shell_output("#{bin}/clipsync --help")
  end
end
