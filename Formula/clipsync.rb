class Clipsync < Formula
  desc "End-to-end encrypted multi-device clipboard sync"
  homepage "https://github.com/Jeon1691/clipsync"
  version "0.1.14"
  license "MIT"

  livecheck do
    url :homepage
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.1.14/clipsync-aarch64-apple-darwin.tar.gz"
      sha256 "5024995245f3dbb850dd7dfc92aa19433109123a50eed84ceecb5a34bb18fca9"
    else
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.1.14/clipsync-x86_64-apple-darwin.tar.gz"
      sha256 "8ff6ee744c2e4b8058a9b17a0681abae3f2962865126e93a372ed13d3407e5cb"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.1.14/clipsync-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "bb0b4d9f9365f8e276d65d30e53ed62915ad773c085871d6f8400d92b6cddccf"
    else
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.1.14/clipsync-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f7a572a5344047cc80617203c48e669dcb0ddd6cb26af76b955d3f278a89fc21"
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
