class Clipsync < Formula
  desc "End-to-end encrypted multi-device clipboard sync"
  homepage "https://github.com/Jeon1691/clipsync"
  version "0.1.6"
  license any_of: ["MIT", "Apache-2.0"]

  livecheck do
    url :homepage
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.1.6/clipsync-aarch64-apple-darwin.tar.gz"
      sha256 "3c020f3403c9d79ccfada224b01f857f4991b1aa5cf221631fb8e92cc9b96424"
    else
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.1.6/clipsync-x86_64-apple-darwin.tar.gz"
      sha256 "1ef88c446c9154324986945e6e40105a4ff9368ae86cf403e9986f31427a32cf"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.1.6/clipsync-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b97b695a5b2eabc1a2cfbe69d26781c78b9c4a10892b615d96949e816e5987e1"
    else
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.1.6/clipsync-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "751baa010ee8c2b12d1e90a3e00c5051f2cfa2e0cbb95ba04a62cff89f9f1548"
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
