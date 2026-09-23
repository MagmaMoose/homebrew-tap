class Transcribe < Formula
  desc "Video/audio transcription with auto-watch, OpenAI summaries, Slack alerts"
  homepage "https://github.com/MagmaMoose/grimoire"
  url "https://github.com/MagmaMoose/grimoire/releases/download/v1.3.20/transcribe-macos-arm64"
  sha256 "95469c0082e9dc93d779628b19b10bc15eacd103be894c64fb8f9b9bdded7b00" # DevSkim: ignore DS173237
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
