class Spatelier < Formula
  include Language::Python::Virtualenv

  desc "Personal tool library for video and music file handling"
  homepage "https://github.com/galenspikes/spatelier"
  url "https://github.com/galenspikes/spatelier/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "bfe48124cbb08616cefab217b3e2e7d84852f22d32a758643109035b7bdda6a1"
  license "MIT"
  head "https://github.com/galenspikes/spatelier.git", branch: "main"

  depends_on "python@3.12"
  depends_on "ffmpeg"

  # Force installation from PyPI using wheels only (no source builds)
  # The URL above is only for Homebrew's versioning - we ignore it and install from PyPI

  def install
    python3 = "python3.12"
    venv = virtualenv_create(libexec, python3)
    # Install directly from PyPI with --only-binary to force wheels
    # This bypasses Homebrew's auto-detection of dependencies
    system "#{libexec}/bin/pip", "install", "--only-binary=:all", "--no-cache-dir", "spatelier==#{version}"
    bin.install libexec/"bin/spatelier"
  end

  test do
    system "#{bin}/spatelier", "--version"
  end
end
