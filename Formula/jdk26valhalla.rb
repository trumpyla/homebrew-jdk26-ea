class Jdk26valhalla < Formula
  desc "Early-Access JDK 26"
  homepage "https://jdk.java.net/26/"
  version "26-ea+23"
  on_macos do
    if Hardware::CPU.arm?
      url "https://download.java.net/java/early_access/jdk26/23/GPL/openjdk-26-ea+23_macos-aarch64_bin.tar.gz"
      sha256 "4057c459519bed817ca86c78245c84109baf71ec99e126d16f63a8d9a078ede8"
    else
      url "https://download.java.net/java/early_access/jdk26/23/GPL/openjdk-26-ea+23_macos-x64_bin.tar.gz"
      sha256 "ffd38cc6b78c9c0d4cc3e156c7ccd314307348a131576a48c837c00a3aa2cf28"
    end
  end
  on_linux do
    url "https://download.java.net/java/early_access/jdk26/23/GPL/openjdk-26-ea+23_linux-x64_bin.tar.gz"
    sha256 "c5cb587a920ddf65225352cf2494965786acd1de8d6748a976d7498d0783a396"
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
