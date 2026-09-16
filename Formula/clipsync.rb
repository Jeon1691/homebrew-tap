class Clipsync < Formula
  desc "End-to-end encrypted multi-device clipboard sync"
  homepage "https://github.com/Jeon1691/clipsync"
  version "0.1.2"
  license any_of: ["MIT", "Apache-2.0"]

  livecheck do
    url :homepage
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.1.2/clipsync-aarch64-apple-darwin.tar.gz"
      sha256 "7ffb8e4a5c3524622011fe2bfea20df6e7f5d077e73e4f80edc86ebefd57c0f6"
    else
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.1.2/clipsync-x86_64-apple-darwin.tar.gz"
      sha256 "36cac1b9bd882945b888893aa3ce7971afc5de60f6d23492afcf388dcb9186b7"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.1.2/clipsync-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c3a77d8cd55e9494f9298de6bc5f7e5f9470c494f0a561f7d33a41037b60ea87"
    else
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.1.2/clipsync-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "02c674998efab82bb6710e17d4ddfadc74f188bda83406d57c7622bd0a92a879"
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
