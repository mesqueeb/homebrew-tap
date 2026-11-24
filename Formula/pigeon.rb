class Pigeon < Formula
  desc "Command-line SMTP mail client for macOS"
  homepage "https://github.com/mesqueeb/Pigeon"
  url "https://github.com/mesqueeb/Pigeon/releases/download/v0.0.4/pigeon-v0.0.4-macos-universal.zip"
  sha256 "708401f595f9fdcaecc250b8ab9e2ec8f4d57c89c877b22226f968aac6c4d35c"
  license "MIT"

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
