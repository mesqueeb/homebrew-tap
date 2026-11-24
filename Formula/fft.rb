class Fft < Formula
  desc "Command-line tool for FFT analysis"
  homepage "https://github.com/mesqueeb/SwiftSound"
  url "https://github.com/mesqueeb/SwiftSound/releases/download/v1.0.3/fft.zip"
  sha256 "042fdea750e43082ef515c7a9e986a7e994c1851375239315bf9f1aac342c74d"
  license "MIT"

  depends_on arch: :arm64
  depends_on macos: :sequoia
  depends_on "sox"

  def install
    bin.install "fft"
  end

  test do
    output = shell_output("#{bin}/fft --help")
    assert_match(/usage:/i, output)
  end
end
