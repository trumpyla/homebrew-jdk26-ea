class Jdk26valhalla < Formula
  desc "Early-Access JDK 26"
  homepage "https://jdk.java.net/26/"
  version "26-ea+33"
  on_macos do
    if Hardware::CPU.arm?
      url "https://download.java.net/java/early_access/jdk26/33/GPL/openjdk-26-ea+33_macos-aarch64_bin.tar.gz"
      sha256 "a382052deb1f5ff0907f38344f4b5244b97532d4344af54380459a6f48bfaa4e"
    else
      url "https://download.java.net/java/early_access/jdk26/33/GPL/openjdk-26-ea+33_macos-x64_bin.tar.gz"
      sha256 "e05721370e15808593e6fc86ce889dbfd8e0ce8160b24c62fe153446882aa779"
    end
  end
  on_linux do
    url "https://download.java.net/java/early_access/jdk26/33/GPL/openjdk-26-ea+33_linux-x64_bin.tar.gz"
    sha256 "9491eba6266080ac690d5e31b7776f5c94188c3f8092874d9fd250660d51050e"
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
