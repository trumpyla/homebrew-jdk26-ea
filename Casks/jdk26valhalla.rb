cask "jdk26valhalla" do
  version "26-ea+22"
  name "JDK 26 EA"
  desc "Early-Access JDK 26"
  homepage "https://jdk.java.net/26/"
  on_macos do
    on_arm do
      url "https://download.java.net/java/early_access/jdk26/22/GPL/openjdk-26-ea+22_macos-aarch64_bin.tar.gz"
      sha256 "04cff29748228b4449fb075ae813a361f07b18dfdc559deeb9127e419c7997d0"
    end
    on_intel do
      url "https://download.java.net/java/early_access/jdk26/22/GPL/openjdk-26-ea+22_macos-x64_bin.tar.gz"
      sha256 "20459857954f42c1a04f83f378be18eb2d62a57a52505afd3356f1c6a4f22818"
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
