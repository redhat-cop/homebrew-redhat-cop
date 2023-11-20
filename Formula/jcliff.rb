class Jcliff < Formula
  desc "Manage JBossAS 7/EAP6/EAP7/Wildfly with modular configuration files"
  homepage "https://github.com/bserdar/jcliff"
  url "https://github.com/bserdar/jcliff/archive/v2.12.8.tar.gz"
  sha256 "dbc7f1bdbb72d3f27ac7d64bf988244130cd84c21891d578801e93766f965155"


  depends_on "openjdk" => :optional

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
