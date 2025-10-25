cask "jdk26valhalla" do
  version "26-ea+21"
  name "JDK 26 EA"
  desc "Early-Access JDK 26"
  homepage "https://jdk.java.net/26/"
  on_macos do
    on_arm do
      url "https://download.java.net/java/early_access/jdk26/21/GPL/openjdk-26-ea+21_macos-aarch64_bin.tar.gz"
      sha256 "8208290643bdba25e7bd88ef14607871c3fa385afd30d4d153ef74666bfc63e5"
    end
    on_intel do
      url "https://download.java.net/java/early_access/jdk26/21/GPL/openjdk-26-ea+21_macos-x64_bin.tar.gz"
      sha256 "ce2a04b51c2c96fe035ed0d93309ac126173730063d099f67950eee514baa42e"
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
