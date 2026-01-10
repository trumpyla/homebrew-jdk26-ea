class Jdk26valhalla < Formula
  desc "Early-Access JDK 26"
  homepage "https://jdk.java.net/26/"
  version "26-ea+30"
  on_macos do
    if Hardware::CPU.arm?
      url "https://download.java.net/java/early_access/jdk26/30/GPL/openjdk-26-ea+30_macos-aarch64_bin.tar.gz"
      sha256 "a9b191d430e2891b071d8a8f5022a65f52e3a70398392fad45a7330a32bf290c"
    else
      url "https://download.java.net/java/early_access/jdk26/30/GPL/openjdk-26-ea+30_macos-x64_bin.tar.gz"
      sha256 "80ed5291960181fb5d6540b16c60300064016df0f86ea4799b2fdfc1f1a53644"
    end
  end
  on_linux do
    url "https://download.java.net/java/early_access/jdk26/30/GPL/openjdk-26-ea+30_linux-x64_bin.tar.gz"
    sha256 "300f7c67876f470e3ddacfd75be07c3c92812847b43933eb3600e258a9662e2d"
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
