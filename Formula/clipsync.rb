class Clipsync < Formula
  desc "End-to-end encrypted multi-device clipboard sync"
  homepage "https://github.com/Jeon1691/clipsync"
  version "0.1.12"
  license "MIT"

  livecheck do
    url :homepage
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.1.12/clipsync-aarch64-apple-darwin.tar.gz"
      sha256 "2486f89f79006d1dda3fec4799f845109762dcbc242fd77d30ef22734d7a518e"
    else
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.1.12/clipsync-x86_64-apple-darwin.tar.gz"
      sha256 "4d3ecf000b141aaef18605768e6d4180042252187969d91749e6bf71c08ea950"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.1.12/clipsync-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "fd20be3a76795e9d65303ddd61730de6bed626377b45d2750c6c06ad2880545f"
    else
      url "https://github.com/Jeon1691/clipsync/releases/download/v0.1.12/clipsync-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "89afd76b4c6c907aedfb2e8df84adab1ec9bd783f8a4a2fbfbba9df88d8d4500"
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
