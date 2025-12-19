class Jdk26valhalla < Formula
  desc "Early-Access JDK 26"
  homepage "https://jdk.java.net/26/"
  version "26-ea+28"
  on_macos do
    if Hardware::CPU.arm?
      url "https://download.java.net/java/early_access/jdk26/28/GPL/openjdk-26-ea+28_macos-aarch64_bin.tar.gz"
      sha256 "55daa0aa8a9deca80ccef22f4b477f576c4bac3f5052e1cca4c5823c7fc7de28"
    else
      url "https://download.java.net/java/early_access/jdk26/28/GPL/openjdk-26-ea+28_macos-x64_bin.tar.gz"
      sha256 "ddbc10368698d8a08e8ac1b9661a647801041c817fb1dd6521ad537d5a8cbb4e"
    end
  end
  on_linux do
    url "https://download.java.net/java/early_access/jdk26/28/GPL/openjdk-26-ea+28_linux-x64_bin.tar.gz"
    sha256 "a18910b0bdceb12a4f78147a1feebee50cc621ad8114c07a1ab071e58c17b09d"
  end
  def install
    libexec.install Dir["*"]
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end
  test do
    (testpath/"Hello.java").write "class Hello{public static void main(String[]a){System.out.println("hi");}}"
    system "#{bin}/javac","--enable-preview","--release","26","Hello.java"
    assert_match(/26|26-ea/, shell_output("#{bin}/java --enable-preview Hello"))
  end
end
