class Jdk26valhalla < Formula
  desc "Early-Access JDK 26"
  homepage "https://jdk.java.net/26/"
  version "26-ea+26"
  on_macos do
    if Hardware::CPU.arm?
      url "https://download.java.net/java/early_access/jdk26/26/GPL/openjdk-26-ea+26_macos-aarch64_bin.tar.gz"
      sha256 "f640864a6498d21b372b558ef255c035f7d284a958d660b4bc03183e0c6a2bee"
    else
      url "https://download.java.net/java/early_access/jdk26/26/GPL/openjdk-26-ea+26_macos-x64_bin.tar.gz"
      sha256 "ae72094faf226f9406c7120647e2a442cfa7e3876e6b00f0b32f1565d6fdbf9e"
    end
  end
  on_linux do
    url "https://download.java.net/java/early_access/jdk26/26/GPL/openjdk-26-ea+26_linux-x64_bin.tar.gz"
    sha256 "b44fa2d67d24735bbcd2378df77b3afd2c5313bd275072e7d328718e2ce3fb11"
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
