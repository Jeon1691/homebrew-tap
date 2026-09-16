class Clipsync < Formula
  desc "End-to-end encrypted multi-device clipboard sync"
  homepage "https://github.com/Jeon1691/clipsync"
  version "0.1.1"
  license any_of: ["MIT", "Apache-2.0"]

  livecheck do
    url :homepage
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.1.1/clipsync-aarch64-apple-darwin.tar.gz"
      sha256 "819b6e718dae39f47e3a3e293710da6f7fe890c5b79bc6fcc34ff227e7bb9f66"
    else
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.1.1/clipsync-x86_64-apple-darwin.tar.gz"
      sha256 "57e5de876602f4c9804f5d8339ad5d342ef434792bed0a8e5a644e2c2a55c6be"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.1.1/clipsync-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "25f23d77884f089d8214198d01dcf16124043ed75fa4144af6cb997af2175024"
    else
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.1.1/clipsync-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c8d112805d2ef82186c54a6670e89bad7d71c377f134ea72673f7e6926768f10"
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
