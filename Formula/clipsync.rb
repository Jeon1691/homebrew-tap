class Clipsync < Formula
  desc "End-to-end encrypted multi-device clipboard sync"
  homepage "https://github.com/Jeon1691/clipsync"
  version "0.1.8"
  license any_of: ["MIT", "Apache-2.0"]

  livecheck do
    url :homepage
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.1.8/clipsync-aarch64-apple-darwin.tar.gz"
      sha256 "64b0d127a2c81325fca42e3e3d30f0a08ed948bcd56bda98a6786a34c2eb44bb"
    else
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.1.8/clipsync-x86_64-apple-darwin.tar.gz"
      sha256 "3872256797f31f976bafc200d1d590da16c695a8c8a821060310e74b4569f03e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.1.8/clipsync-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d16cde6d73f09cc603caefec6ee60eba63546ded735484368faf63e50bfaf7a7"
    else
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.1.8/clipsync-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "307b57a7812def07a064713a7bf0238692ccce3409e42ba40c7dffbd71d76422"
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

        clipsync room create
    EOS
  end

  test do
    assert_match "Usage: clipsync", shell_output("#{bin}/clipsync --help")
  end
end
