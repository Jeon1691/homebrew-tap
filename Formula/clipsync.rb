class Clipsync < Formula
  desc "End-to-end encrypted multi-device clipboard sync"
  homepage "https://github.com/Jeon1691/clipsync"
  version "0.1.17"
  license "MIT"

  livecheck do
    url :homepage
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.1.17/clipsync-aarch64-apple-darwin.tar.gz"
      sha256 "7138b71c6dc44454436a4513d101ba95ae0c096f64b1676ce80b26f1307a6103"
    else
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.1.17/clipsync-x86_64-apple-darwin.tar.gz"
      sha256 "96c05fd049b052e6ff1221035752e3672a2600edfadc4094a7732cf1bfa49fe7"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.1.17/clipsync-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "52511768f93f1badcb21c4c8caa55d9807f0b442fbbb0530dd715c39eb9017fa"
    else
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.1.17/clipsync-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "55dc72e9a88045aa47e42fabca8180e4f5e9c44ca29f579c7690e0f4f0d6b626"
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
