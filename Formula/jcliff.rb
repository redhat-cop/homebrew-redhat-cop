class Jcliff < Formula
  desc "Manage JBossAS 7/EAP6/EAP7/Wildfly with modular configuration files"
  homepage "https://github.com/bserdar/jcliff"
  url "https://github.com/bserdar/jcliff/releases/download/v2.12.6/jcliff-2.12.6-dist.tar.gz"
  sha256 "a610679a0c3b63fab3d7912c8225751c55e1d22db7ec7fa892d1c1e7ff7937b4"

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
