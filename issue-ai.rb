class IssueAi < Formula
  desc "Offline-first, AI-powered Personal Copilot for Open Source Triage"
  homepage "https://github.com/ramanathan1504/issue-ai"
  url "https://github.com/ramanathan1504/issue-ai/releases/download/v1.0.0/issue-ai-1.0.0-jar-with-dependencies.jar"
  sha256 "PUT_THE_SHA256_HASH_OF_YOUR_JAR_HERE"
  license "Apache-2.0"

  depends_on "openjdk@17"

  def install
    # Install the JAR file into the Homebrew prefix
    libexec.install "issue-ai-1.0.0-jar-with-dependencies.jar"

    # Create the bash wrapper script so users can just type 'issue-ai'
    (bin/"issue-ai").write <<~EOS
      #!/bin/bash
      export JAVA_HOME="${Formula["openjdk@21"].opt_prefix}"
      exec "${JAVA_HOME}/bin/java" -jar "#{libexec}/issue-ai-1.0.0-jar-with-dependencies.jar" "$@"
    EOS
  end

  test do
    system "#{bin}/issue-ai", "--help"
  end
end