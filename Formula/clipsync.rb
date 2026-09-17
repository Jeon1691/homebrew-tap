class Clipsync < Formula
  desc "End-to-end encrypted multi-device clipboard sync"
  homepage "https://github.com/Jeon1691/clipsync"
  version "0.1.5"
  license any_of: ["MIT", "Apache-2.0"]

  livecheck do
    url :homepage
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.1.5/clipsync-aarch64-apple-darwin.tar.gz"
      sha256 "51b633e078c28050a440d7d86ca0b43e0eb01efe33f94314e027eba54a5975c5"
    else
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.1.5/clipsync-x86_64-apple-darwin.tar.gz"
      sha256 "78784536d45bfb35318c7ca798cb603a7514f7bcbec3f24bfe131ff28551d136"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.1.5/clipsync-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7bb485a740d354050dfc5715ed0fb30aac913d66e070e8048ab421609ae823bc"
    else
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.1.5/clipsync-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d065478e64d5f2fdbc03b2322ea0f50766e14ac3d8b760cef5aecc78b7317a16"
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
