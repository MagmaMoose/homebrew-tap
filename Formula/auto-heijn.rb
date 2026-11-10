class AutoHeijn < Formula
  desc "Turn an Apple Reminders shopping list into an Albert Heijn add-to-list link"
  homepage "https://github.com/CalebSargeant/auto-heijn"
  url "https://github.com/CalebSargeant/auto-heijn/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "d156f3ae765bd090b69f75134e257eb9222d0ea0e59ea6105e632fba56d5092a"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on :macos
  depends_on "steipete/tap/remindctl"

  def install
    # Runs on /usr/bin/python3 so the macOS Reminders grant survives Homebrew Python upgrades.
    bin.install "auto_heijn.py" => "auto-heijn"
  end

  def caveats
    <<~EOS
      Start it (every 5 minutes while you are logged in):
        brew services start auto-heijn
      The first run asks macOS to let python3 use Reminders. Click Allow.

      Settings (list name, AH product ids):
        ~/.config/auto-heijn/config.json
    EOS
  end

  service do
    run opt_bin/"auto-heijn"
    run_type :interval
    interval 300
    environment_variables PYTHONUTF8: "1", REMINDCTL: "#{HOMEBREW_PREFIX}/bin/remindctl"
    process_type :background
    log_path var/"log/auto-heijn.log"
    error_log_path var/"log/auto-heijn.log"
  end

  test do
    assert_match "Albert Heijn", shell_output("#{bin}/auto-heijn --help")
  end
end
