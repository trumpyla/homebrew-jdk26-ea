cask "jdk26valhalla" do
  version "26-ea+19"
  name "JDK 26 EA"
  desc "Early-Access JDK 26"
  homepage "https://jdk.java.net/26/"
  on_macos do
    on_arm do
      url "https://download.java.net/java/early_access/jdk26/19/GPL/openjdk-26-ea+19_macos-aarch64_bin.tar.gz"
      sha256 "b723001f467ffeb6421795aff8edc46e40ebdc57cd135ebc13df9eab6d79cf1c"
    end
    on_intel do
      url "https://download.java.net/java/early_access/jdk26/19/GPL/openjdk-26-ea+19_macos-x64_bin.tar.gz"
      sha256 "5bc24e939d37ca11e56c58448e167a97ad00b3c6258f33a8d038a80931a89950"
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
