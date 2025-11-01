class Jdk26valhalla < Formula
  desc "Early-Access JDK 26"
  homepage "https://jdk.java.net/26/"
  version "26-ea+22"
  on_macos do
    if Hardware::CPU.arm?
      url "https://download.java.net/java/early_access/jdk26/22/GPL/openjdk-26-ea+22_macos-aarch64_bin.tar.gz"
      sha256 "04cff29748228b4449fb075ae813a361f07b18dfdc559deeb9127e419c7997d0"
    else
      url "https://download.java.net/java/early_access/jdk26/22/GPL/openjdk-26-ea+22_macos-x64_bin.tar.gz"
      sha256 "20459857954f42c1a04f83f378be18eb2d62a57a52505afd3356f1c6a4f22818"
    end
  end
  on_linux do
    url "https://download.java.net/java/early_access/jdk26/22/GPL/openjdk-26-ea+22_linux-x64_bin.tar.gz"
    sha256 "b87eeeb2167b024e3e62fb5ab860c0e2ad004d2e04f716b9f885d1180ac97a03"
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
