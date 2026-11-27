class Transcribe < Formula
  desc "Video/audio transcription with auto-watch, OpenAI summarization, and Slack notifications"
  homepage "https://github.com/calebsargeant/transcribe"
  version "1.0.8" # NOTE: bump this when releasing new binaries, wrapper prints this value
  license "MIT"

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

  depends_on "whisper-cpp"
  depends_on "ffmpeg"

  def install
    # Install the bundled binary into libexec and wrap it to provide --version and TLS cert fix
    exe = Dir["transcribe-*"]&.first
    odie "No transcribe binary found in release artifacts" unless exe

    # Keep the original binary under libexec as transcribe-bin
    libexec.install exe => "transcribe-bin"

    # Our wrapper lives in libexec; bin gets a small exec script for correct perms
    wrapper = libexec/"transcribe-wrapper"
    wrapper.write <<~EOS
      #!/bin/bash
      set -euo pipefail

      # Handle version flags at the wrapper level so brew users always get a version
      if [[ "${1-}" == "--version" || "${1-}" == "-v" || "${1-}" == "version" ]]; then
        echo "transcribe #{version} (brew/pyinstaller)"
        exit 0
      fi

      # Clean up broken TLS CA envs that can occur with bundled binaries (_MEI* paths)
      for var in SSL_CERT_FILE REQUESTS_CA_BUNDLE; do
        val="${!var-}"
        if [[ -n "${val}" && ! -f "${val}" ]]; then
          unset "${var}"
        fi
      done

      # Try to discover a valid CA bundle
      CAFILE=""
      if command -v python3 >/dev/null 2>&1; then
        candidate=$(python3 - <<'PY'
import sys
try:
    import certifi
    print(certifi.where())
except Exception:
    sys.exit(1)
PY
)
        if [[ -n "${candidate}" && -f "${candidate}" ]]; then
          CAFILE="${candidate}"
        fi
      fi
      # Fallback to Homebrew OpenSSL certs if available
      if [[ -z "${CAFILE}" && -f "/opt/homebrew/etc/openssl@3/cert.pem" ]]; then
        CAFILE="/opt/homebrew/etc/openssl@3/cert.pem"
      fi
      if [[ -n "${CAFILE}" ]]; then
        export SSL_CERT_FILE="${CAFILE}"
        export REQUESTS_CA_BUNDLE="${CAFILE}"
      fi

      exec "#{libexec}/transcribe-bin" "$@"
    EOS
    wrapper.chmod 0755

    # Create an executable shim in bin with the canonical name
    (bin/"transcribe").write_env_script wrapper, {}
  end

  def caveats
    <<~EOS
      Next steps:
        - Run: transcribe --version   # verify installed version
        - Configure: transcribe config
        - Optional: setup auto-watch daemon
            transcribe setup-daemon
            launchctl load ~/Library/LaunchAgents/com.calebsargeant.transcribe.plist

      Notes:
        - If you upgrade, reload the daemon if it's running: launchctl unload ~/Library/LaunchAgents/com.calebsargeant.transcribe.plist && launchctl load ~/Library/LaunchAgents/com.calebsargeant.transcribe.plist
        - Config lives at: ~/.transcribe/config.yaml
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/transcribe --version")
  end
end
