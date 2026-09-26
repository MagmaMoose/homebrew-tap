class Transcribe < Formula
  desc "Video/audio transcription with auto-watch, OpenAI summaries, Slack alerts"
  homepage "https://github.com/MagmaMoose/grimoire"
  url "https://github.com/MagmaMoose/grimoire/releases/download/v1.3.21/transcribe-macos-arm64"
  sha256 "0c38ca7ace85ef6c74d0d851c858ac3ebfc0e32c993ee47c55e9528de5ac74f5" # DevSkim: ignore DS173237
  license "MIT"

  depends_on arch: :arm64
  depends_on "ffmpeg"
  depends_on :macos
  depends_on "whisper.cpp"

  def install
    bin.install Dir["transcribe-*"].first => "transcribe"
  end

  def caveats
    <<~EOS
      To configure transcribe with your OpenAI API key and Slack webhook:
        transcribe config

      To setup automatic transcription of videos in ~/Movies:
        transcribe setup-daemon
        launchctl load ~/Library/LaunchAgents/com.calebsargeant.transcribe.plist

      Configuration file is located at:
        ~/.transcribe/config.yaml
    EOS
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/transcribe --help")
  end
end
