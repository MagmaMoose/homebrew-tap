class Transcribe < Formula
  desc "Video/audio transcription with auto-watch, OpenAI summaries, Slack alerts"
  homepage "https://github.com/MagmaMoose/grimoire"
  url "https://github.com/MagmaMoose/grimoire/releases/download/v1.3.28/transcribe-macos-arm64"
  sha256 "e28116d230c007ec82fb3ecafaaaaf975f2f1ebc800eacd06a669525b92fa78c" # DevSkim: ignore DS173237
  license "MIT"

  depends_on arch: :arm64
  depends_on "ffmpeg"
  # Homebrew no longer bottles for macOS 14 (Tier 3), and whisper.cpp's dependency
  # tree does not build from source there (z3, pulled in through llvm, fails).
  depends_on macos: :sequoia
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
