class AutoHeijn < Formula
  desc "Sync an Apple Reminders shopping list to an Albert Heijn basket server"
  homepage "https://github.com/CalebSargeant/auto-heijn"
  url "https://github.com/CalebSargeant/auto-heijn/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "2cdef4184b2eb66541468916d3edb0def0aee6f6c344f697f209d3d880145821" # DevSkim: ignore DS173237
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on macos: :sonoma

  # Bundled rather than a dependency: Homebrew no longer taps a dependency's tap by itself.
  resource "remindctl" do
    url "https://github.com/openclaw/remindctl/releases/download/v0.3.9/remindctl-macos.zip"
    sha256 "6db69578bef36c83d5c40560103a10026b1fd2ecfc45c4ef695eee0ade5527ad" # DevSkim: ignore DS173237
  end

  def install
    resource("remindctl").stage { libexec.install "remindctl" }
    # Runs on /usr/bin/python3 so the macOS Reminders grant survives Homebrew Python upgrades.
    bin.install "auto_heijn.py" => "auto-heijn"
    inreplace bin/"auto-heijn", "/opt/homebrew/bin/remindctl", opt_libexec/"remindctl"
  end

  def caveats
    <<~EOS
      Point it at your auto-heijn server in ~/.config/auto-heijn/config.json:
        {"list": "Shopping List", "server": "https://ah.example.com"}
      and keep the server's token in the Keychain:
        security add-generic-password -U -s auto-heijn -a bridge-token -w

      Start it (every 5 minutes while you are logged in):
        brew services start auto-heijn
      The first run asks macOS to let remindctl use Reminders. Click Allow.
    EOS
  end

  service do
    run opt_bin/"auto-heijn"
    run_type :interval
    interval 300
    environment_variables PYTHONUTF8: "1"
    process_type :background
    log_path var/"log/auto-heijn.log"
    error_log_path var/"log/auto-heijn.log"
  end

  test do
    assert_match "Reminders", shell_output("#{bin}/auto-heijn --help")
    assert_match "0.3.9", shell_output("#{libexec}/remindctl --version")
  end
end
