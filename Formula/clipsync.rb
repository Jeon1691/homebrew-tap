class Clipsync < Formula
  desc "End-to-end encrypted multi-device clipboard sync"
  homepage "https://github.com/Jeon1691/clipsync"
  version "0.1.4"
  license any_of: ["MIT", "Apache-2.0"]

  livecheck do
    url :homepage
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.1.4/clipsync-aarch64-apple-darwin.tar.gz"
      sha256 "da12a4b9d2ab9a2b059f01b473d554fa901d422c9caa306e91848fb0b48c9abd"
    else
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.1.4/clipsync-x86_64-apple-darwin.tar.gz"
      sha256 "bc91f056454cc94f1a8f4571e8f91639d8ffc624ff0f9a3e653e21fd95484f12"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.1.4/clipsync-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "fdaa556390d087cddc1066e193870fdfdd130eea7e691d71c6fb74b705e7e42a"
    else
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.1.4/clipsync-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b7e73d8cf79fdd00f24e180c178a25916182d6282eb51a31c8a26cf7eea37a55"
    end
  end

  def install
    binary = File.exist?("clipsync") ? "clipsync" : Dir["clipsync-*/clipsync"].first
    odie "clipsync binary missing from archive" if binary.nil?
    bin.install binary
  end

  def caveats
    <<~EOS
      Default relay is https://clipsync.develicit.dev

        clipsync init
        clipsync room create
    EOS
  end

  test do
    assert_match "Usage: clipsync", shell_output("#{bin}/clipsync --help")
  end
end
