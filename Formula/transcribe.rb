class Transcribe < Formula
  desc "Video/audio transcription with auto-watch, OpenAI summaries, Slack alerts"
  homepage "https://github.com/MagmaMoose/grimoire"
  url "https://github.com/MagmaMoose/grimoire/releases/download/v1.3.12/transcribe-macos-arm64"
  sha256 "a7811a160f5a3f59b9972da0369b0e0bd68e39b30c83f1e1922e2531d2d59815" # DevSkim: ignore DS173237
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
