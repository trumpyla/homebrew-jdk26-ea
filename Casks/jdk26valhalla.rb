cask "jdk26valhalla" do
  version "26-ea+24"
  name "JDK 26 EA"
  desc "Early-Access JDK 26"
  homepage "https://jdk.java.net/26/"
  on_macos do
    on_arm do
      url "https://download.java.net/java/early_access/jdk26/24/GPL/openjdk-26-ea+24_macos-aarch64_bin.tar.gz"
      sha256 "46e056f86bef25600a6251d453d98f039f410ed6b8de30b0a3a6dd1ea62e4bcf"
    end
    on_intel do
      url "https://download.java.net/java/early_access/jdk26/24/GPL/openjdk-26-ea+24_macos-x64_bin.tar.gz"
      sha256 "81fd92e9830ce17414fd61a272c580a0aced0e90680a222a5ec7b7896a795448"
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
