class Pigeon < Formula
  desc "Command-line SMTP mail client for macOS"
  homepage "https://github.com/mesqueeb/Pigeon"
  url "https://github.com/mesqueeb/Pigeon/releases/download/v0.0.5/pigeon-v0.0.5-macos-universal.zip"
  sha256 "9e56357a4dba76b6dad6ecb48132046b655bcdcab265e3541e1bce3e3485d1cd"
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
