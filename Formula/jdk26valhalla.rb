class Jdk26valhalla < Formula
  desc "Early-Access JDK 26"
  homepage "https://jdk.java.net/26/"
  version "26-ea+29"
  on_macos do
    if Hardware::CPU.arm?
      url "https://download.java.net/java/early_access/jdk26/29/GPL/openjdk-26-ea+29_macos-aarch64_bin.tar.gz"
      sha256 "5b11a923a24db0c1ea0ae37a51eda107f3b7462f6bd699a1d9d8d48c4b1d4a47"
    else
      url "https://download.java.net/java/early_access/jdk26/29/GPL/openjdk-26-ea+29_macos-x64_bin.tar.gz"
      sha256 "b61d92279dccd78fb5e835cebad9a124bd6cee89cc26d18b314a1a90fdb944a5"
    end
  end
  on_linux do
    url "https://download.java.net/java/early_access/jdk26/29/GPL/openjdk-26-ea+29_linux-x64_bin.tar.gz"
    sha256 "14b38c0378b8fccf20824a10aed0193c3e5c9732c7933f4e14b1409027db9d5a"
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
