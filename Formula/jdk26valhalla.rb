class Jdk26valhalla < Formula
  desc "Early-Access JDK 26"
  homepage "https://jdk.java.net/26/"
  version "26-ea+31"
  on_macos do
    if Hardware::CPU.arm?
      url "https://download.java.net/java/early_access/jdk26/31/GPL/openjdk-26-ea+31_macos-aarch64_bin.tar.gz"
      sha256 "47c2cf918391369f2d8bb73ee388596b402ff49cf2f4b17b9a1f26241f700d8f"
    else
      url "https://download.java.net/java/early_access/jdk26/31/GPL/openjdk-26-ea+31_macos-x64_bin.tar.gz"
      sha256 "5de3f12a0160c45df121c38efcdd41774aa8e1ef99cef570bf45e5517dd08511"
    end
  end
  on_linux do
    url "https://download.java.net/java/early_access/jdk26/31/GPL/openjdk-26-ea+31_linux-x64_bin.tar.gz"
    sha256 "bfc006ca65cf590a40d808e5dc5cc973b98e11e309d0efa5dc36340c8b3ffdbb"
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
