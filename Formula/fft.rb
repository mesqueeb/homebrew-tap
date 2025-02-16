# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
class Fft < Formula
  desc "🔊 An Experimental Swift CLI for FFT Analysis"
  homepage "https://github.com/mesqueeb/SwiftSound"
  url "https://github.com/mesqueeb/SwiftSound/releases/download/v1.0.3/fft.zip"
  sha256 "042fdea750e43082ef515c7a9e986a7e994c1851375239315bf9f1aac342c74d"
  license "MIT"

  # Add sox as a runtime dependency
  depends_on "sox"

  def install
    # Install the fft binary into Homebrew's bin directory
    bin.install "fft"
  end

  test do
    # Verify that fft displays its help message
    assert_match "Usage: fft <input-file>", shell_output("#{bin}/fft --help", 1)
  end
end
