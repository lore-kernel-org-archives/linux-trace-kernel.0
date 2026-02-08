Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E9F1DFFD;
	Sun,  8 Feb 2026 03:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770521046; cv=none; b=gHvc2MWNHGtotCJ71sp5YK6HwrlBZl+l3jqx63aHMws/fU6DYwzyq7JKz9ER0ahDe2BCGcnFBVrfB53qo2+JSlzP8Iry/F+bdlf2vBYcc0xv8sbhIDuK6Shg3HSwaooXX3etX8OzMe/HbuSDtkku+mPSWDtemOzPVi2EOoCPsDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770521046; c=relaxed/simple;
	bh=WjgPtrJ5wSDCRofEA70oMGklis624z6PXHvh0XLUpVk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=NtI334XHhg3AHqnQOy1BewCCIrcstdJV7n6u+M/lpd6th6/hM/oqck6YTsbcWlRRJXfAyNZ7krLgj1YMV9HAzscoaqyJSxgO3O+46v1CRBs5QQMQuKXb6HlgJAAZjGUzrQwIvWCg0SCW60h0SfxfZgkMAcMf/sXjiaMLyoCLdXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBBeaq0r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBBeaq0r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74ABAC19425;
	Sun,  8 Feb 2026 03:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770521046;
	bh=WjgPtrJ5wSDCRofEA70oMGklis624z6PXHvh0XLUpVk=;
	h=Date:From:To:Cc:Subject:References:From;
	b=hBBeaq0rDH15psyqB+6u5rVw4R+Wa4+uxeLgTPZ02sqRZbyDOQBjQ65g8Hhfx8A/o
	 OZqUQWbxvxRThcuE8snK+NaryxLXmYdqXmcc9yhzmSNDtMweg4PWD6PxFozc1LuzfG
	 4zXNN8FGwFDGwWQ2olg0icISFhquhnPErwLoNg/DzNRfBSsFAMYOFDW1bAXMn0cMtP
	 MERruYh8SBWJA1W+cUvf6U2eVOaLqN2eXrdYbsoP95QLnHjcYczak5wIBzufBsgpZw
	 xu4N3lQ2frpsSIUpf3Lxk4rXcAoOYYwtQH4vPjbx2Jy1/9CPWrlQsnrWEuJglk8opK
	 rr6xell56GW5Q==
Received: from rostedt by gandalf with local (Exim 4.99.1)
	(envelope-from <rostedt@kernel.org>)
	id 1vovPl-0000000AObk-3KPP;
	Sat, 07 Feb 2026 22:24:49 -0500
Message-ID: <20260208032449.648932796@kernel.org>
User-Agent: quilt/0.68
Date: Sat, 07 Feb 2026 22:24:19 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 02/10] tracing: Make tracing_selftest_running global to the tracing
 subsystem
References: <20260208032417.262341179@kernel.org>
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
index 1ff40c88e75c..f040ee4fe101 100644
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
index 433705bef480..19cffc7b5852 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -863,6 +863,7 @@ extern int trace_selftest_startup_nop(struct tracer *trace,
 					 struct trace_array *tr);
 extern int trace_selftest_startup_branch(struct tracer *trace,
 					 struct trace_array *tr);
+extern bool __read_mostly tracing_selftest_running;
 /*
  * Tracer data references selftest functions that only occur
  * on boot up. These can be __init functions. Thus, when selftests
@@ -875,6 +876,7 @@ static inline void __init disable_tracing_selftest(const char *reason)
 }
 /* Tracers are seldom changed. Optimize when selftests are disabled. */
 #define __tracer_data		__read_mostly
+#define tracing_selftest_running	0
 #endif /* CONFIG_FTRACE_STARTUP_TEST */
 
 extern void *head_page(struct trace_array_cpu *data);
-- 
2.51.0


