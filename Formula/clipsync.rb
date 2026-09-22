class Clipsync < Formula
  desc "End-to-end encrypted multi-device clipboard sync"
  homepage "https://github.com/Jeon1691/clipsync"
  version "0.1.13"
  license "MIT"

  livecheck do
    url :homepage
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.1.13/clipsync-aarch64-apple-darwin.tar.gz"
      sha256 "8447b10ea5c1fe1b90c1fb6a32dba8b9870432991892ef59605d37218e91dc3e"
    else
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.1.13/clipsync-x86_64-apple-darwin.tar.gz"
      sha256 "d1c3bac5bd667f775f66c68345f36b24acd5226520abb854839e93286097340b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.1.13/clipsync-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a41293d0b5f81ee4a918847513c3efa76a41f160fb03b3600086881c8f5d11ad"
    else
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.1.13/clipsync-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "10fba775caec0c5ab0587da555ec3f38770f18ed08511fe74625f8d8e97e8d0d"
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
