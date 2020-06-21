class Jcliff < Formula
  desc "Manage JBossAS 7/EAP6/EAP7/Wildfly with modular configuration files"
  homepage "https://github.com/bserdar/jcliff"
  url "https://github.com/bserdar/jcliff/releases/download/v2.12.5/jcliff-2.12.5-dist.tar.gz"
  sha256 "1738fe4cb8a863e6c609538aad85c1ccbe73ba6326ba7cc1cc186fbb9cd13fd7"

  bottle :unneeded

  depends_on :java

  def install
    libexec.install Dir["rules", "*.jar"]

    (libexec/"bin").install "jcliff"
    chmod 0755, libexec/"bin/jcliff"
    (bin/"jcliff").write_env_script("#{libexec}/bin/jcliff", :JCLIFF_HOME => libexec.to_s)
  end

  def caveats
    <<~EOS
      Jcliff installed! Before use, the JBOSS_HOME environment variable must be set, similar to the following:
        export JBOSS_HOME=<Location of JBoss Server>
    EOS
  end

  test do
    ENV["JBOSS_HOME"] = opt_libexec
    assert_match "Jcliff version #{version}", shell_output("#{bin}/jcliff -v").chomp
  end
end
