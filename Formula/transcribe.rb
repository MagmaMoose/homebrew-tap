class Transcribe < Formula
  desc "Video/audio transcription with auto-watch, OpenAI summaries, Slack alerts"
  homepage "https://github.com/calebsargeant/transcribe"
  version "1.0.8"
  license "MIT"

  depends_on "ffmpeg"
  depends_on "whisper-cpp"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/calebsargeant/transcribe/releases/download/v1.0.8/transcribe-macos-arm64"
      sha256 "bfa1183189f7ffcd26892b56004a5acfa0270e4222766a1de40f92854928b1d2"
    else
      url "https://github.com/calebsargeant/transcribe/releases/download/v1.0.8/transcribe-macos-x86_64"
      sha256 "98f4d3564ffc04fe5a9c71c454a68f56312105b3a2d9c73b09dc5c99a7405eb4"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/calebsargeant/transcribe/releases/download/v1.0.8/transcribe-linux-arm64"
      sha256 "25dab7898429fed61a4fd88a57bff04a18b430b2cad515222e7fd7c7d3bc3fe2"
    else
      url "https://github.com/calebsargeant/transcribe/releases/download/v1.0.8/transcribe-linux-x86_64"
      sha256 "0471dceda770cac2bfb6fada084023eca85f3fdff96c38a7ff11481d8db4130a"
    end
  end

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
