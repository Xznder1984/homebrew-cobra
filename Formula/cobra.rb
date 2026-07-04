class Cobra < Formula
  desc "Indentation-based programming language compiled to native code"
  homepage "https://github.com/Xznder1984/Cobra"
  license "MIT"

  head "https://github.com/Xznder1984/Cobra.git", branch: "main"

  stable do
    on_macos do
      if Hardware::CPU.arm?
        url "https://github.com/Xznder1984/Cobra/releases/download/v0.2.0/cobra-0.2.0-macos-arm64.tar.gz"
        sha256 "a571f33bb85d7dba41e031eb219c2b9130e8b78307d110c17af041707de3e80d"
      else
        url "https://github.com/Xznder1984/Cobra/releases/download/v0.2.0/cobra-0.2.0-macos-x86_64.tar.gz"
        sha256 "686b5a7233cdddc85a9a54d96b1108324f3b3454b111b4cd0842ba5cb20d9f58"
      end
    end

    on_linux do
      url "https://github.com/Xznder1984/Cobra/releases/download/v0.2.0/cobra-0.2.0-linux-x86_64.tar.gz"
      sha256 "016e614beaa52ff02443dfd929a20cb82180b87c5113b6d0c85de63739d6bffd"
    end
  end

  depends_on "make" => :build

  def install
    if build.head?
      system "make", "build"
      bin.install "cli/bin/cobra"
      bin.install "compiler/bin/cobrac"
      lib.install "runtime/libcobra_runtime.a"
    else
      bin.install "cobra"
      bin.install "cobrac"
      lib.install "libcobra_runtime.a"
    end
  end

  test do
    system "#{bin}/cobra", "--version"
  end
end
