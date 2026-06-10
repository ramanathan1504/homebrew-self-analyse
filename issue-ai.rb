class IssueAi < Formula
  desc "Offline-first, AI-powered Personal Copilot for Open Source Triage"
  homepage "https://github.com/ramanathan1504/issue-ai"
  url "https://github.com/ramanathan1504/issue-ai/releases/download/v1.1.0/issue-ai-1.1.0.jar"
  sha256 "a67fd4e2da67a1af462fac6f0cf1423e9ee62f938801d270a6ea02c1b8606f96"
  license "Apache-2.0"

  depends_on "openjdk@17"

  def install
    # Dynamically grabs the filename from the URL above
    jar_filename = File.basename(stable.url)

    # Installs it and renames it to a clean 'issue-ai.jar'
    libexec.install jar_filename => "issue-ai.jar"

    # Create the terminal wrapper script
    (bin/"issue-ai").write <<~EOS
      #!/bin/bash
      # FIX: Notice the '#' here instead of '$'
      export JAVA_HOME="#{Formula["openjdk@17"].opt_prefix}"
      exec "${JAVA_HOME}/bin/java" -jar "#{libexec}/issue-ai.jar" "$@"
    EOS
  end

  test do
    system "#{bin}/issue-ai", "--help"
  end
end
