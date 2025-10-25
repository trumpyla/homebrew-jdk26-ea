class Jdk26valhalla < Formula
  desc "Early-Access JDK 26"
  homepage "https://jdk.java.net/26/"
  version "26-ea+21"
  on_macos do
    if Hardware::CPU.arm?
      url "https://download.java.net/java/early_access/jdk26/21/GPL/openjdk-26-ea+21_macos-aarch64_bin.tar.gz"
      sha256 "8208290643bdba25e7bd88ef14607871c3fa385afd30d4d153ef74666bfc63e5"
    else
      url "https://download.java.net/java/early_access/jdk26/21/GPL/openjdk-26-ea+21_macos-x64_bin.tar.gz"
      sha256 "ce2a04b51c2c96fe035ed0d93309ac126173730063d099f67950eee514baa42e"
    end
  end
  on_linux do
    url "https://download.java.net/java/early_access/jdk26/21/GPL/openjdk-26-ea+21_linux-x64_bin.tar.gz"
    sha256 "3189ce7f96b6fb0b69ce1e8ca7bc626aa30009023f9e2ddf7faeaa5ddf9e8626"
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
