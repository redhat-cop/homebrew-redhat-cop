class Jcliff < Formula
  desc "Manage JBossAS 7/EAP6/EAP7/Wildfly with modular configuration files"
  homepage "https://github.com/bserdar/jcliff"
  url "https://github.com/bserdar/jcliff/releases/download/v2.12.7/jcliff-2.12.7-dist.tar.gz"
  sha256 "827ccf28653ecea9e97b6f208685a29ce24912087b8c2b52a15b4e4b3837fbef"

  bottle :unneeded

  depends_on :java => :optional

  def install
    libexec.install Dir["rules", "*.jar"]

    (libexec).install "jcliff"
    (bin/"jcliff").write_env_script("#{libexec}/jcliff", :JCLIFF_HOME => libexec.to_s)
    chmod 0755, libexec/"jcliff"
  end

  def caveats
    <<~EOS
      Jcliff installed! Before use, the JBOSS_HOME environment variable must be set, similar to the following:
        export JBOSS_HOME=<Location of JBoss Server>
    EOS
  end

  test do
    ENV["JBOSS_HOME"] = opt_libexec
    assert_match "Jcliff version #{version}", shell_output("#{bin}/jcliff -v", 3).chomp
  end
end
