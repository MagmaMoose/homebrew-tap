class Chargate < Formula
  include Language::Python::Virtualenv

  desc "Net-new security and lint gate with a global git-hooks installer"
  homepage "https://github.com/MagmaMoose/chargate"
  url "https://github.com/MagmaMoose/chargate/archive/refs/tags/v2.1.0.tar.gz"
  sha256 "7f787823c8bd9003228af416b9f97982f90a0794dd5dcdbe91bbebcc75a69f48"
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
    # chargate's embedded __version__ can lag the git tag for ci-only releases cut
    # via version-override (which tags without bumping the version files), so assert
    # it prints *a* semver rather than the exact tag, and that the CLI is wired up.
    assert_match(/\A\d+\.\d+\.\d+\Z/, shell_output("#{bin}/chargate version").strip)
    assert_match "install-hooks", shell_output("#{bin}/chargate install-hooks --help")
  end
end
