class Clipsync < Formula
  desc "End-to-end encrypted multi-device clipboard sync"
  homepage "https://github.com/Jeon1691/clipsync"
  version "0.1.16"
  license "MIT"

  livecheck do
    url :homepage
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.1.16/clipsync-aarch64-apple-darwin.tar.gz"
      sha256 "2097431b0b05e3e4d33e36c0991ccb53a62d483f58cb66ad060244096b634f13"
    else
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.1.16/clipsync-x86_64-apple-darwin.tar.gz"
      sha256 "77ddc768a4ba6121a58f6d93f9f20f9149e495091167d89bde1dc82ef2565720"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.1.16/clipsync-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "112a0c84006a5b1d1bbf226e9898d95f07e3544390c27844edfca9e492ba7106"
    else
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.1.16/clipsync-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1f33657567fb9f00b0abbcccc23077788e1bee27ab5dcbfa83f58632a5128742"
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
