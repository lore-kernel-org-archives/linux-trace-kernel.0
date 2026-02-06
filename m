Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707312848B2;
	Fri,  6 Feb 2026 19:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770407936; cv=none; b=N3zf0DcU1drFcnOamNoSKc/YRaRdfaifyRkivB6Cp7HtVF3NGLwa6Z2JsjLao1VH/bEEPqEzSfg1kIlKefbj6Pyrm9orKdX9Seugp2+bjhtok9Kkq3MXWEtvdkTe284KmJ+3PDqWmS/xLj7kL1LvwA4MBbEU87YnZx2/8z97b9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770407936; c=relaxed/simple;
	bh=gc3vlVl9zWzfzqzsNtyK2LNgYikkI/ztgXn4fvwCRAk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=hDwh6vsEDrinfET+EyjmIDK3io2y3GFXtL6mambAxcChqVubdKTgqUdB7oNAMWeJ8g+lj1p2q5INVf6mRNnv2PW0iRTrRQ6i4oYqAsgf6EoM9P1ff5QP3n49GtwekfzZ0k7mIoSFkyYIuR6EywkMFHcWJHag9CcwmcxDn/yuUCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLb4LkZf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLb4LkZf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25BB7C19422;
	Fri,  6 Feb 2026 19:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770407936;
	bh=gc3vlVl9zWzfzqzsNtyK2LNgYikkI/ztgXn4fvwCRAk=;
	h=Date:From:To:Cc:Subject:References:From;
	b=ZLb4LkZfqAbjrVD5poj0HirUZUWTMgB+yrccRj6buOIzZl5C5cOk462UUI1E/O76q
	 CyTn+ETa36kC3e8/rxklCeC/DOzkTm4FQPbftgl+J2J6s66se3ddmkEGBKvsqzTVE+
	 ftRlOreH+GJ4YMnv2XifhhXISm/0utz4ppLZKsNcnrZ3meNMPNUtCgysGvu1GQC5N8
	 i16F6ksnqIJokNsRIE9M3cwqwRvRNDsOu3WprEb9anw4HQd55vIob6g+MPys77QzKx
	 3CuhW8dyUKGjBKNDltpe6E01oyRFhDDsIwzTqUW7Rd/TkELS6Ac5p1hmpjlMiXMT3J
	 q+HSwj1kw1kZA==
Received: from rostedt by gandalf with local (Exim 4.99.1)
	(envelope-from <rostedt@kernel.org>)
	id 1voRzL-0000000A6mm-18IP;
	Fri, 06 Feb 2026 14:59:35 -0500
Message-ID: <20260206195935.127453448@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 06 Feb 2026 14:37:43 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 02/12] tracing: Make tracing_selftest_running global to the tracing
 subsystem
References: <20260206193741.767171392@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The file trace.c has become a catchall for most things tracing. Start
making it smaller by breaking out various aspects into their own files.

Make the variable tracing_selftest_running global so that it can be used
by other files in the tracing subsystem and trace.c can be split up.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 3 +--
 kernel/trace/trace.h | 2 ++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 45972d089061..dafcdd31570b 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -67,7 +67,7 @@
  * insertions into the ring-buffer such as trace_printk could occurred
  * at the same time, giving false positive or negative results.
  */
-static bool __read_mostly tracing_selftest_running;
+bool __read_mostly tracing_selftest_running;
 
 /*
  * If boot-time tracing including tracers/events via kernel cmdline
@@ -83,7 +83,6 @@ void __init disable_tracing_selftest(const char *reason)
 	}
 }
 #else
-#define tracing_selftest_running	0
 #define tracing_selftest_disabled	0
 #endif
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index fda87c9f84bc..ccfaa9b4d2bf 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -867,6 +867,7 @@ extern int trace_selftest_startup_nop(struct tracer *trace,
 					 struct trace_array *tr);
 extern int trace_selftest_startup_branch(struct tracer *trace,
 					 struct trace_array *tr);
+extern bool __read_mostly tracing_selftest_running;
 /*
  * Tracer data references selftest functions that only occur
  * on boot up. These can be __init functions. Thus, when selftests
@@ -879,6 +880,7 @@ static inline void __init disable_tracing_selftest(const char *reason)
 }
 /* Tracers are seldom changed. Optimize when selftests are disabled. */
 #define __tracer_data		__read_mostly
+#define tracing_selftest_running	0
 #endif /* CONFIG_FTRACE_STARTUP_TEST */
 
 extern void *head_page(struct trace_array_cpu *data);
-- 
2.51.0


