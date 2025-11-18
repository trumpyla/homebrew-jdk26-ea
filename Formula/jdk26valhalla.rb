class Jdk26valhalla < Formula
  desc "Early-Access JDK 26"
  homepage "https://jdk.java.net/26/"
  version "26-ea+24"
  on_macos do
    if Hardware::CPU.arm?
      url "https://download.java.net/java/early_access/jdk26/24/GPL/openjdk-26-ea+24_macos-aarch64_bin.tar.gz"
      sha256 "46e056f86bef25600a6251d453d98f039f410ed6b8de30b0a3a6dd1ea62e4bcf"
    else
      url "https://download.java.net/java/early_access/jdk26/24/GPL/openjdk-26-ea+24_macos-x64_bin.tar.gz"
      sha256 "81fd92e9830ce17414fd61a272c580a0aced0e90680a222a5ec7b7896a795448"
    end
  end
  on_linux do
    url "https://download.java.net/java/early_access/jdk26/24/GPL/openjdk-26-ea+24_linux-x64_bin.tar.gz"
    sha256 "4ba2cf8ca6a66fbea892ba55048f82d8cd4fabe95d9364ac28a79b282c6207f8"
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
