cask "jdk26valhalla" do
  version "26-ea+30"
  name "JDK 26 EA"
  desc "Early-Access JDK 26"
  homepage "https://jdk.java.net/26/"
  on_macos do
    on_arm do
      url "https://download.java.net/java/early_access/jdk26/30/GPL/openjdk-26-ea+30_macos-aarch64_bin.tar.gz"
      sha256 "a9b191d430e2891b071d8a8f5022a65f52e3a70398392fad45a7330a32bf290c"
    end
    on_intel do
      url "https://download.java.net/java/early_access/jdk26/30/GPL/openjdk-26-ea+30_macos-x64_bin.tar.gz"
      sha256 "80ed5291960181fb5d6540b16c60300064016df0f86ea4799b2fdfc1f1a53644"
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
