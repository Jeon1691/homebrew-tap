class Clipsync < Formula
  desc "End-to-end encrypted multi-device clipboard sync"
  homepage "https://github.com/Jeon1691/clipsync"
  version "0.1.9"
  license any_of: ["MIT", "Apache-2.0"]

  livecheck do
    url :homepage
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.1.9/clipsync-aarch64-apple-darwin.tar.gz"
      sha256 "54de0dba130ea2955805a11176659b294d8537d1a359e9c8ff459b61ddaec471"
    else
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.1.9/clipsync-x86_64-apple-darwin.tar.gz"
      sha256 "1db19b629a2b78500af70c9491e2e2c7fb7dc8fe1aaf0f7500749cdfd9e256a1"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.1.9/clipsync-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "782fd8aad6ca202e980e7df62f92f8f751228f6c6cff0368880fc5e19854def8"
    else
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.1.9/clipsync-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2cee011ed10dab77633d28afe4f7436f9c35205ba5334456d2718e1b37235f1f"
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
