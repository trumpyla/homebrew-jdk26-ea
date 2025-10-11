class Jdk26valhalla < Formula
  desc "Early-Access JDK 26"
  homepage "https://jdk.java.net/26/"
  version "26-ea+19"
  on_macos do
    if Hardware::CPU.arm?
      url "https://download.java.net/java/early_access/jdk26/19/GPL/openjdk-26-ea+19_macos-aarch64_bin.tar.gz"
      sha256 "b723001f467ffeb6421795aff8edc46e40ebdc57cd135ebc13df9eab6d79cf1c"
    else
      url "https://download.java.net/java/early_access/jdk26/19/GPL/openjdk-26-ea+19_macos-x64_bin.tar.gz"
      sha256 "5bc24e939d37ca11e56c58448e167a97ad00b3c6258f33a8d038a80931a89950"
    end
  end
  on_linux do
    url "https://download.java.net/java/early_access/jdk26/19/GPL/openjdk-26-ea+19_linux-x64_bin.tar.gz"
    sha256 "9a89dcca644d59f40b82f6712c854e416d5b5fe80808c40868e1ba2d6d8e1e9e"
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
