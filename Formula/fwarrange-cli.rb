class FwarrangeCli < Formula
  desc "Window layout management daemon for fWarrange"
  homepage "https://github.com/Finfra/fWarrange_public"
  url "https://github.com/Finfra/fWarrange_public/releases/download/cli-v1.0.1/fWarrangeCli-1.0.1.tar.gz"
  version "1.0.1"
  sha256 "488fc4f7944378621244cbdccf74975123defdaedf54161dd4c131189a4fd044"
  license "MIT"

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
    assert_predicate prefix/"fWarrangeCli.app/Contents/MacOS/fWarrangeCli", :exist?
  end
end
