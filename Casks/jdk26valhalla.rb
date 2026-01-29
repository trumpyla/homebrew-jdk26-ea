cask "jdk26valhalla" do
  version "26-ea+32"
  name "JDK 26 EA"
  desc "Early-Access JDK 26"
  homepage "https://jdk.java.net/26/"
  on_macos do
    on_arm do
      url "https://download.java.net/java/early_access/jdk26/32/GPL/openjdk-26-ea+32_macos-aarch64_bin.tar.gz"
      sha256 "f05b5e99b4612525e2739baa1f7879c82fce2b888e4bcd8399329279bb4491a9"
    end
    on_intel do
      url "https://download.java.net/java/early_access/jdk26/32/GPL/openjdk-26-ea+32_macos-x64_bin.tar.gz"
      sha256 "5ef464e9723abad9663e704fdf0a62680717d19b3c934bd5dbe05d83fdd4c629"
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
