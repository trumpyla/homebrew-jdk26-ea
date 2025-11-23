cask "jdk26valhalla" do
  version "26-ea+25"
  name "JDK 26 EA"
  desc "Early-Access JDK 26"
  homepage "https://jdk.java.net/26/"
  on_macos do
    on_arm do
      url "https://download.java.net/java/early_access/jdk26/25/GPL/openjdk-26-ea+25_macos-aarch64_bin.tar.gz"
      sha256 "460426301375a6bc82834b00186e2ec800f682312d64850fe128562fac7edb58"
    end
    on_intel do
      url "https://download.java.net/java/early_access/jdk26/25/GPL/openjdk-26-ea+25_macos-x64_bin.tar.gz"
      sha256 "b9fdaa326764be2e36f86b87d42b9751f4b260fe13b4b6a048297002a48f1869"
    end
  end
  postflight do
    jdk_target = "/Library/Java/JavaVirtualMachines/jdk-26-ea.jdk"
    jdk_src = Dir["#{staged_path}/jdk-*"].first

    # Detect rsync path based on OS
    rsync_path = if MacOS.version
                   "/usr/bin/rsync"
                 else
                   # Linux typically has rsync in /usr/bin
                   system("command -v rsync > /dev/null 2>&1") ? `which rsync`.strip : "/usr/bin/rsync"
                 end

    if jdk_src
      system_command "/bin/mkdir", args: ["-p", jdk_target], sudo: true
      system_command rsync_path, args: ["-a", jdk_src + "/", jdk_target + "/"], sudo: true
    end
  end
  uninstall_postflight do
    system_command "/bin/rm", args: ["-rf", "/Library/Java/JavaVirtualMachines/jdk-26-ea.jdk"], sudo: true
  end
end
