class Clipsync < Formula
  desc "End-to-end encrypted multi-device clipboard sync"
  homepage "https://github.com/Jeon1691/clipsync"
  version "0.1.18"
  license "MIT"

  livecheck do
    url :homepage
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.1.18/clipsync-aarch64-apple-darwin.tar.gz"
      sha256 "c752ee2f55ef3cdd42c5c54be4d67df7ac240574b37604f7c6d70bb1fd988ee4"
    else
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.1.18/clipsync-x86_64-apple-darwin.tar.gz"
      sha256 "241b3b8db4b61a922bd93c350c71f5abcea0c214b03031de85100e439c2ae964"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.1.18/clipsync-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "25bb248e67b5221d6601ccd0110b01193860e8ad56f77e1ad430519d74038c6f"
    else
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.1.18/clipsync-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "55c569191b283474dd2d7de7f4f6ebd8d306f98d9ff6c1bcfcaa45c15b006490"
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
