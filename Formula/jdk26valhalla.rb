class Jdk26valhalla < Formula
  desc "Early-Access JDK 26"
  homepage "https://jdk.java.net/26/"
  version "26-ea+20"
  on_macos do
    if Hardware::CPU.arm?
      url "https://download.java.net/java/early_access/jdk26/20/GPL/openjdk-26-ea+20_macos-aarch64_bin.tar.gz"
      sha256 "dc75cdb507e47a66b0edc73d1cfc4a1c011078d5d0785c7660320d2e9c3e04d4"
    else
      url "https://download.java.net/java/early_access/jdk26/20/GPL/openjdk-26-ea+20_macos-x64_bin.tar.gz"
      sha256 "5da4095d77d50eb19d8df7f0d128c16a6ff933d6cadc5cbf6fff1bf0530b6474"
    end
  end
  on_linux do
    url "https://download.java.net/java/early_access/jdk26/20/GPL/openjdk-26-ea+20_linux-x64_bin.tar.gz"
    sha256 "5a59bcbbbee3ef3870abde737d101b8688ff06144c853ff29ef6ac8247c96a87"
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
