class Jdk26valhalla < Formula
  desc "Early-Access JDK 26"
  homepage "https://jdk.java.net/26/"
  version "26-ea+32"
  on_macos do
    if Hardware::CPU.arm?
      url "https://download.java.net/java/early_access/jdk26/32/GPL/openjdk-26-ea+32_macos-aarch64_bin.tar.gz"
      sha256 "f05b5e99b4612525e2739baa1f7879c82fce2b888e4bcd8399329279bb4491a9"
    else
      url "https://download.java.net/java/early_access/jdk26/32/GPL/openjdk-26-ea+32_macos-x64_bin.tar.gz"
      sha256 "5ef464e9723abad9663e704fdf0a62680717d19b3c934bd5dbe05d83fdd4c629"
    end
  end
  on_linux do
    url "https://download.java.net/java/early_access/jdk26/32/GPL/openjdk-26-ea+32_linux-x64_bin.tar.gz"
    sha256 "99e956807a500a396bc799f5b450e79c295bccece78ae9ca67f3e75646d3a099"
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
