cask "jdk26valhalla" do
  version "26-ea+29"
  name "JDK 26 EA"
  desc "Early-Access JDK 26"
  homepage "https://jdk.java.net/26/"
  on_macos do
    on_arm do
      url "https://download.java.net/java/early_access/jdk26/29/GPL/openjdk-26-ea+29_macos-aarch64_bin.tar.gz"
      sha256 "5b11a923a24db0c1ea0ae37a51eda107f3b7462f6bd699a1d9d8d48c4b1d4a47"
    end
    on_intel do
      url "https://download.java.net/java/early_access/jdk26/29/GPL/openjdk-26-ea+29_macos-x64_bin.tar.gz"
      sha256 "b61d92279dccd78fb5e835cebad9a124bd6cee89cc26d18b314a1a90fdb944a5"
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
