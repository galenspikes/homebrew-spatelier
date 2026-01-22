class Spatelier < Formula
  include Language::Python::Virtualenv

  desc "Personal tool library for video and music file handling"
  homepage "https://github.com/galenspikes/spatelier"
  # No source URL - install directly from PyPI to use wheels (faster)
  license "MIT"
  head "https://github.com/galenspikes/spatelier.git", branch: "main"

  depends_on "python@3.12"
  depends_on "ffmpeg"

  # Force installation from PyPI using wheels only (no source builds)
  # This bypasses Homebrew's auto-detection of dependencies and uses PyPI wheels

  def version
    "0.2.0"
  end

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
