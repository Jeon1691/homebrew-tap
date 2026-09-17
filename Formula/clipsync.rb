class Clipsync < Formula
  desc "End-to-end encrypted multi-device clipboard sync"
  homepage "https://github.com/Jeon1691/clipsync"
  version "0.1.7"
  license any_of: ["MIT", "Apache-2.0"]

  livecheck do
    url :homepage
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.1.7/clipsync-aarch64-apple-darwin.tar.gz"
      sha256 "17d37ca3f73d1f3a655d94e3c86ec4c8f8552ad4859ac94242fd16509ac3183f"
    else
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.1.7/clipsync-x86_64-apple-darwin.tar.gz"
      sha256 "1f5596d360d2b41ed89617ca3c93aa69d43063b60f95b4e27c030406a8c6529c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.1.7/clipsync-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "17367322bcaba1d6afce2472e4d2df3e4f683ad9be7145637aa5eb59772bd5fe"
    else
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.1.7/clipsync-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "164964e8bc38a7ea69ac3e944276b32453e8544aff6f43bcbf6c44128e79e1b8"
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
