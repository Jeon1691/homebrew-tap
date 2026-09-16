class Clipsync < Formula
  desc "End-to-end encrypted multi-device clipboard sync"
  homepage "https://github.com/Jeon1691/clipsync"
  version "0.1.3"
  license any_of: ["MIT", "Apache-2.0"]

  livecheck do
    url :homepage
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.1.3/clipsync-aarch64-apple-darwin.tar.gz"
      sha256 "677dbc51892e755041ab5b5f81157330cf35b037269a4ecc4cbd8009810c0099"
    else
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.1.3/clipsync-x86_64-apple-darwin.tar.gz"
      sha256 "32e098fc2fcb0bb1bdd11473d66119232085ce00aafc868d3adeea6a030a3575"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.1.3/clipsync-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "92db734a5cec657e4f59d86de723b23162f2209f622e60d296577d04c0912e09"
    else
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.1.3/clipsync-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ef674a9079bf99c832de739c317565cabf701d1e34db2138054b2d83a637b5cd"
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
