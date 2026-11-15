class Clipsync < Formula
  desc "End-to-end encrypted multi-device clipboard sync"
  homepage "https://github.com/Jeon1691/clipsync"
  version "0.1.15"
  license "MIT"

  livecheck do
    url :homepage
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.1.15/clipsync-aarch64-apple-darwin.tar.gz"
      sha256 "c70fc222495571a566da0f5afc794d251c87b23d1834a3820e87bbb67791ec14"
    else
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.1.15/clipsync-x86_64-apple-darwin.tar.gz"
      sha256 "44866a6a02654130cbe2e2f1e67d8fd555402f8956c97f3907dd91230c464d0b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.1.15/clipsync-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "fc60dab7c5cbb0f4e8393a21d00d5abf0c3eb3d286452400e3b1d63ba27f6d2a"
    else
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.1.15/clipsync-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e7a97935059e8b992cf55fabd0117af8120d4a27b6cc21fad4313c609c25beba"
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
