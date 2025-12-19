cask "jdk26valhalla" do
  version "26-ea+28"
  name "JDK 26 EA"
  desc "Early-Access JDK 26"
  homepage "https://jdk.java.net/26/"
  on_macos do
    on_arm do
      url "https://download.java.net/java/early_access/jdk26/28/GPL/openjdk-26-ea+28_macos-aarch64_bin.tar.gz"
      sha256 "55daa0aa8a9deca80ccef22f4b477f576c4bac3f5052e1cca4c5823c7fc7de28"
    end
    on_intel do
      url "https://download.java.net/java/early_access/jdk26/28/GPL/openjdk-26-ea+28_macos-x64_bin.tar.gz"
      sha256 "ddbc10368698d8a08e8ac1b9661a647801041c817fb1dd6521ad537d5a8cbb4e"
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
