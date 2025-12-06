cask "jdk26valhalla" do
  version "26-ea+27"
  name "JDK 26 EA"
  desc "Early-Access JDK 26"
  homepage "https://jdk.java.net/26/"
  on_macos do
    on_arm do
      url "https://download.java.net/java/early_access/jdk26/27/GPL/openjdk-26-ea+27_macos-aarch64_bin.tar.gz"
      sha256 "528b8db57ab11de1215c5a84814f408ce7c8a1636e12aad210b5207b7ffa9ef7"
    end
    on_intel do
      url "https://download.java.net/java/early_access/jdk26/27/GPL/openjdk-26-ea+27_macos-x64_bin.tar.gz"
      sha256 "66384388ec83fe775b6419f8e9067e3b9c15844abd009048304f7f724a6aed5b"
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
