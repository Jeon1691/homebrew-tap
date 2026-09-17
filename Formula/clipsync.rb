class Clipsync < Formula
  desc "End-to-end encrypted multi-device clipboard sync"
  homepage "https://github.com/Jeon1691/clipsync"
  version "0.1.10"
  license any_of: ["MIT", "Apache-2.0"]

  livecheck do
    url :homepage
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.1.10/clipsync-aarch64-apple-darwin.tar.gz"
      sha256 "f435a2c04c12a670a77054b0d69ef60694ff5e1f6e62a27f19ea4c828f81603a"
    else
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.1.10/clipsync-x86_64-apple-darwin.tar.gz"
      sha256 "8d935d9aadef178656f98ba588ec0199583bedc1f8665981f3aef28f34380200"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.1.10/clipsync-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "eb2165babc878d3d336487305af8faf492595027638cdd064db7f0d7a5834e7d"
    else
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.1.10/clipsync-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e850fd24e83537412bfdf5e869cc38c0c4abb400a3c5df6d72c88adb01468817"
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
