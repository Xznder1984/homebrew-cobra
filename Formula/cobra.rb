class Cobra < Formula
  desc "Indentation-based programming language compiled to native code"
  homepage "https://github.com/Xznder1984/Cobra"
  license "MIT"

  head "https://github.com/Xznder1984/Cobra.git", branch: "main"

  stable do
    on_macos do
      if Hardware::CPU.arm?
        url "https://github.com/Xznder1984/Cobra/releases/download/v0.1.0/cobra-0.1.0-macos-x86_64.tar.gz"
        sha256 "6d30433f2525b69f74f9dfe5a8614c813eae4fdee1febe1469f822187ae4fc09"
      else
        url "https://github.com/Xznder1984/Cobra/archive/refs/tags/v0.1.0.tar.gz"
        sha256 "7176e63fa39f522651ff50563e3bcf9f25f6251128fa0a10a255b4032459fa35"
      end
    end

    on_linux do
      url "https://github.com/Xznder1984/Cobra/releases/download/v0.1.0/cobra-0.1.0-linux-x86_64.tar.gz"
      sha256 "3454e9636519e7c22a943a4438251940ca6fa664912ef2c055dde5011534f9d8"
    end
  end

  depends_on "make" => :build

  def install
    if build.head?
      system "make", "build"
      bin.install "cli/bin/cobra"
      bin.install "compiler/bin/cobrac"
      lib.install "runtime/libcobra_runtime.a"
    elsif OS.mac? && !Hardware::CPU.arm?
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
