class Chargate < Formula
  include Language::Python::Virtualenv

  desc "Net-new security and lint gate with a global git-hooks installer"
  homepage "https://github.com/MagmaMoose/chargate"
  url "https://github.com/MagmaMoose/chargate/archive/refs/tags/v2.0.1.tar.gz"
  sha256 "06a0f5a2c7ad52629858056fd041f2a0aa076031c31f1e9339c63e94e688e576"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  # chargate's core is stdlib-only (no runtime deps), so the virtualenv needs no
  # `resource` blocks. pre-commit is the framework `chargate install-hooks` drives.
  depends_on "pre-commit"
  depends_on "python@3.12"

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/chargate version")
    assert_match "install-hooks", shell_output("#{bin}/chargate install-hooks --help")
  end
end
