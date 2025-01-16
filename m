Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236B312E7F;
	Thu, 16 Jan 2025 01:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736990437; cv=none; b=plfGJbyEoi7hr8H3iOej8M1GptEySboV9iISvDuXr5hEKa4pnHsFc4QU5wH7inmt7BMddy3SEGk593NVMdC26/ZpWMhEthGtR9sPrmpSfwU30OD18bsG1ub0qw89F2pcDm+I4LCIBguF/6oP0nUWz5qXGsPQmRVT3aaxHN8iqtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736990437; c=relaxed/simple;
	bh=2caqcW4xcR3kTGIeEDV/7Bz2Kl4mwC5V5/8olQBw7rA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=eKEZGij/jzYcY4Mi+0wiWWV7Ovl6n91gozM42+6mVJSVFjHZxac44jpW2p7bOBJyzsb1SxOVIzD8QnL5gzmZl6C9f0jcPEwV/w2uiIMmt7q3iWJJ86mk6PNqWeD1kSZqVwKy8CK4L+iOasv9Ql7aZCWp5317M/IJAy5T7LTqVP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B525FC4CEE2;
	Thu, 16 Jan 2025 01:20:36 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tYEYr-00000000hc1-2K43;
	Wed, 15 Jan 2025 20:20:41 -0500
Message-ID: <20250116012041.326701057@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 15 Jan 2025 20:20:10 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 1/3] selftests/tracing: Test only toplevel README file not the instances
References: <20250116012009.840870709@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

For the tests that have both a README attribute as well as the instance
flag to run the tests as an instance, the instance version will always
exit with UNSUPPORTED. That's because the instance directory does not
contain a README file. Currently, the tests check for a README file in the
directory that the test runs in and if there's a requirement for something
to be present in the README file, it will not find it, as the instance
directory doesn't have it.

Have the tests check if the current directory is an instance directory,
and if it is, check two directories above the current directory for the
README file:

  /sys/kernel/tracing/README
  /sys/kernel/tracing/instances/foo/../../README

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/testing/selftests/ftrace/test.d/functions | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
index 779f3e62ec90..9f2a67fbaf4d 100644
--- a/tools/testing/selftests/ftrace/test.d/functions
+++ b/tools/testing/selftests/ftrace/test.d/functions
@@ -156,7 +156,13 @@ check_requires() { # Check required files and tracers
                 exit_unsupported
             fi
         elif [ "$r" != "$i" ]; then
-            if ! grep -Fq "$r" README ; then
+	    # If this is an instance, check the top directory
+	    if echo $TRACING_DIR | grep -q "/instances/"; then
+		test="$TRACING_DIR/../.."
+	    else
+		test=$TRACING_DIR
+	    fi
+            if ! grep -Fq "$r" $test/README ; then
                 echo "Required feature pattern \"$r\" is not in README."
                 exit_unsupported
             fi
-- 
2.45.2


