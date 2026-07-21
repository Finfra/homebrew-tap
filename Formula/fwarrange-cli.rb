class FwarrangeCli < Formula
  desc "Window layout management daemon for fWarrange"
  homepage "https://github.com/Finfra/fWarrange_public"
  # version is scanned from the URL basename (fWarrangeCli-1.1.1.tar.gz)
  url "https://github.com/Finfra/fWarrange_public/releases/download/cli-v1.1.1/fWarrangeCli-1.1.1.tar.gz"
  sha256 "af8dca788fc7275c45405c159fcd76fb83bcf86f75b5c2d89281536701bb0c3c"
  # Dual license: CC BY-NC 4.0 (non-commercial) or paid commercial license (see repository LICENSE)
  license any_of: ["CC-BY-NC-4.0", :cannot_represent]

  depends_on :macos

  def install
    # Tarball contains pre-built fWarrangeCli.app (Apple Development signed).
    # brew sandbox restricts keychain access, so copy as-is without rebuilding.
    prefix.install "fWarrangeCli.app"
  end

  service do
    run [opt_prefix/"fWarrangeCli.app/Contents/MacOS/fWarrangeCli"]
    keep_alive successful_exit: false
    log_path var/"log/fwarrange-cli.log"
    error_log_path var/"log/fwarrange-cli.err.log"
    process_type :interactive
  end

  def caveats
    <<~EOS
      fWarrangeCli requires Accessibility permission.

      Register auto-start after install:
        brew services start finfra/tap/fwarrange-cli

      Grant permission:
        System Settings > Privacy & Security > Accessibility > enable fWarrangeCli
    EOS
  end

  test do
    assert_path_exists prefix/"fWarrangeCli.app/Contents/MacOS/fWarrangeCli"
  end
end
