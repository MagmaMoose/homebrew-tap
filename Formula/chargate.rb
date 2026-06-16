class Chargate < Formula
  include Language::Python::Virtualenv

  desc "Net-new security and lint gate with a global git-hooks installer"
  homepage "https://github.com/MagmaMoose/chargate"
  url "https://github.com/MagmaMoose/chargate/archive/refs/tags/v2.0.0.tar.gz"
  # Placeholder until the v2.0.0 release exists. Fill with:
  #   curl -sSL <url> | shasum -a 256
  # or let .github/workflows/update-sha256.yml compute it.
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"
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
