class Jdk26valhalla < Formula
  desc "Early-Access JDK 26"
  homepage "https://jdk.java.net/26/"
  version "26-ea+25"
  on_macos do
    if Hardware::CPU.arm?
      url "https://download.java.net/java/early_access/jdk26/25/GPL/openjdk-26-ea+25_macos-aarch64_bin.tar.gz"
      sha256 "460426301375a6bc82834b00186e2ec800f682312d64850fe128562fac7edb58"
    else
      url "https://download.java.net/java/early_access/jdk26/25/GPL/openjdk-26-ea+25_macos-x64_bin.tar.gz"
      sha256 "b9fdaa326764be2e36f86b87d42b9751f4b260fe13b4b6a048297002a48f1869"
    end
  end
  on_linux do
    url "https://download.java.net/java/early_access/jdk26/25/GPL/openjdk-26-ea+25_linux-x64_bin.tar.gz"
    sha256 "34a09a42f38d04f223c2c3c3665e4638bcda263c69c38e8e363760be8ceeaffd"
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
