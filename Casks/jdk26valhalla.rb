cask "jdk26valhalla" do
  version "26-ea+20"
  name "JDK 26 EA"
  desc "Early-Access JDK 26"
  homepage "https://jdk.java.net/26/"
  on_macos do
    on_arm do
      url "https://download.java.net/java/early_access/jdk26/20/GPL/openjdk-26-ea+20_macos-aarch64_bin.tar.gz"
      sha256 "dc75cdb507e47a66b0edc73d1cfc4a1c011078d5d0785c7660320d2e9c3e04d4"
    end
    on_intel do
      url "https://download.java.net/java/early_access/jdk26/20/GPL/openjdk-26-ea+20_macos-x64_bin.tar.gz"
      sha256 "5da4095d77d50eb19d8df7f0d128c16a6ff933d6cadc5cbf6fff1bf0530b6474"
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
