class IssueAi < Formula
  desc "Offline-first, AI-powered Personal Copilot for Open Source Triage"
  homepage "https://github.com/ramanathan1504/issue-ai"
  url "https://github.com/ramanathan1504/issue-ai/releases/download/v1.0.1/issue-ai-1.0.1.jar"
  sha256 "90fa285720daa472d16326a620e0cffb8387c549f259bc5c3e69a93ac69134ee"
  license "Apache-2.0"

  # FIX: Make sure this says 21!
  depends_on "openjdk@17"

  def install
    # Dynamically grabs the filename from the URL above
    jar_filename = File.basename(stable.url)

    # Installs it and renames it to a clean 'issue-ai.jar'
    libexec.install jar_filename => "issue-ai.jar"

    # Create the terminal wrapper script
    (bin/"issue-ai").write <<~EOS
      #!/bin/bash
      export JAVA_HOME="${Formula["openjdk@17"].opt_prefix}"
      exec "${JAVA_HOME}/bin/java" -jar "#{libexec}/issue-ai.jar" "$@"
    EOS
  end

  test do
    system "#{bin}/issue-ai", "--help"
  end
end