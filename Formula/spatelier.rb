class Spatelier < Formula
  include Language::Python::Virtualenv

  desc "Personal tool library for video and music file handling"
  homepage "https://github.com/galenspikes/spatelier"
  url "https://github.com/galenspikes/spatelier/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "391604a4a627ed88cfc85bef8929bf666a4627f2586a761511777d0eb805beb9"
  license "MIT"
  head "https://github.com/galenspikes/spatelier.git", branch: "main"

  depends_on "python@3.12"
  depends_on "ffmpeg"

  # Force installation from PyPI using wheels only (no source builds)
  # The URL above is only for Homebrew's versioning - we ignore it and install from PyPI

  def install
    python3 = "python3.12"
    venv = virtualenv_create(libexec, python3)
    # venv.pip_install installs pip properly in the venv
    # Then we use system pip with our flags to install from PyPI
    venv.pip_install "pip"  # Ensure pip is in venv
    # Install directly from PyPI, prefer wheels but allow source if needed
    system "#{libexec}/bin/pip", "install", "--prefer-binary", "--no-cache-dir", "spatelier==#{version}"
    bin.install libexec/"bin/spatelier"
  end

  test do
    system "#{bin}/spatelier", "--version"
  end
end
