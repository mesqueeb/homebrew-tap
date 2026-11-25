class Pigeon < Formula
  desc "Command-line SMTP mail client for macOS"
  homepage "https://github.com/mesqueeb/Pigeon"
  url "https://github.com/mesqueeb/Pigeon/releases/download/v0.0.10/pigeon-v0.0.10-macos-arm64.zip"
  sha256 "c6073974499aa9e052a0e9a6edbc1bd519a24466e15ed880c939dc468f0aa2f3"
  license "MIT"

  depends_on arch: :arm64
  depends_on macos: :ventura

  def install
    bin.install "pigeon"
    pkgshare.install "config.example.json", ".env.example"
  end

  test do
    (testpath/"message.txt").write("Pigeon Homebrew test\n")
    assert_path_exists pkgshare/".env.example"
    output = shell_output(
      "#{bin}/pigeon send --config #{pkgshare}/config.example.json " \
      "--to to@example.com --cc cc@example.com --bcc bcc@example.com " \
      "--in-reply-to '<parent@example.com>' --subject 'Re: Homebrew test' " \
      "--body-file message.txt --dry-run",
    )
    assert_match "To: to@example.com", output
    assert_match "Cc: cc@example.com", output
    assert_match "Bcc (SMTP only): bcc@example.com", output
    assert_match "In-Reply-To: <parent@example.com>", output
    assert_match "Dry run:", output
  end
end
