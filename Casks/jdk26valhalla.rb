cask "jdk26valhalla" do
  version "26-ea+33"
  name "JDK 26 EA"
  desc "Early-Access JDK 26"
  homepage "https://jdk.java.net/26/"
  on_macos do
    on_arm do
      url "https://download.java.net/java/early_access/jdk26/33/GPL/openjdk-26-ea+33_macos-aarch64_bin.tar.gz"
      sha256 "a382052deb1f5ff0907f38344f4b5244b97532d4344af54380459a6f48bfaa4e"
    end
    on_intel do
      url "https://download.java.net/java/early_access/jdk26/33/GPL/openjdk-26-ea+33_macos-x64_bin.tar.gz"
      sha256 "e05721370e15808593e6fc86ce889dbfd8e0ce8160b24c62fe153446882aa779"
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
