class Keploy < Formula
  desc "Testing Toolkit creates test-cases and data mocks from API calls, DB queries"
  homepage "https://keploy.io"
  url "https://github.com/keploy/keploy/archive/refs/tags/v2.6.22.tar.gz"
  sha256 "5d9c1f998eb5ff41b05a3fefe1fe0d2190d762c184f9f793238e36b67fee9440"
  license "Apache-2.0"
  head "https://github.com/keploy/keploy.git", branch: "main"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "5135e9dd47bfd93c12acc805e2e866401eca0f2216f5b5b827a4e59b79c12ce3"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "5135e9dd47bfd93c12acc805e2e866401eca0f2216f5b5b827a4e59b79c12ce3"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "5135e9dd47bfd93c12acc805e2e866401eca0f2216f5b5b827a4e59b79c12ce3"
    sha256 cellar: :any_skip_relocation, sonoma:        "d45ae9e7fd1684d349e3bf9258da5216f315d9094f386b2ab8e913aad190beb6"
    sha256 cellar: :any_skip_relocation, ventura:       "d45ae9e7fd1684d349e3bf9258da5216f315d9094f386b2ab8e913aad190beb6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "02aefed5d18d63e8e59364a633596a57eddb05bf58088a103f4425482bab0871"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X main.version=#{version}")
  end

  test do
    system bin/"keploy", "config", "--generate", "--path", testpath
    assert_match "# Generated by Keploy", (testpath/"keploy.yml").read

    output = shell_output("#{bin}/keploy templatize --path #{testpath}")
    assert_match "No test sets found to templatize", output

    assert_match version.to_s, shell_output("#{bin}/keploy --version")
  end
end
