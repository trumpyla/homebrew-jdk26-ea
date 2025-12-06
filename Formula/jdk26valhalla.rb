class Jdk26valhalla < Formula
  desc "Early-Access JDK 26"
  homepage "https://jdk.java.net/26/"
  version "26-ea+27"
  on_macos do
    if Hardware::CPU.arm?
      url "https://download.java.net/java/early_access/jdk26/27/GPL/openjdk-26-ea+27_macos-aarch64_bin.tar.gz"
      sha256 "528b8db57ab11de1215c5a84814f408ce7c8a1636e12aad210b5207b7ffa9ef7"
    else
      url "https://download.java.net/java/early_access/jdk26/27/GPL/openjdk-26-ea+27_macos-x64_bin.tar.gz"
      sha256 "66384388ec83fe775b6419f8e9067e3b9c15844abd009048304f7f724a6aed5b"
    end
  end
  on_linux do
    url "https://download.java.net/java/early_access/jdk26/27/GPL/openjdk-26-ea+27_linux-x64_bin.tar.gz"
    sha256 "c219dd04012af56a87523d69c6dd07a66adce846ff11981335a361ae9e0b4472"
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
