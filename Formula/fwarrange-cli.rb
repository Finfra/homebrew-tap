class FwarrangeCli < Formula
  desc "Window layout management daemon for fWarrange"
  homepage "https://github.com/Finfra/fWarrange_public"
  # version is scanned from the URL basename (fWarrangeCli-1.1.3.tar.gz)
  url "https://github.com/Finfra/fWarrange_public/releases/download/cli-v1.1.3/fWarrangeCli-1.1.3.tar.gz"
  sha256 "e8f1d5d62981cac52e786cfec2caeca6d7b4062167ab5dfce198dd65d38700e7"
  # Source: Apache-2.0. Official builds are also subject to DISTRIBUTION-TERMS.md (see caveats)
  license "Apache-2.0"

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

      License: source code is Apache-2.0. This official build is free for personal use,
      education, non-profits, open source and other organizations up to 250 concurrent copies.
      Terms: https://github.com/Finfra/fWarrange_public/blob/main/DISTRIBUTION-TERMS.md
    EOS
  end

  test do
    assert_path_exists prefix/"fWarrangeCli.app/Contents/MacOS/fWarrangeCli"
  end
end
