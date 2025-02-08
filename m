Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5F413EFE3;
	Sat,  8 Feb 2025 15:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739028620; cv=none; b=NysHEf0AxaUGVr2ClwK5vQc90LarB1/gKxGw0TWjjfMWpmq4aG9LtqMoMFJ0sEPxTMlzRdzDaHbCPQx84cKRVf4a8zM24n7qLQVobN48amtvBa9cX3ftW92QuN+auQ6mxovJEJLw4lRZmfTBu7rcFTuTS5gkRlZtyqQnArubCT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739028620; c=relaxed/simple;
	bh=8HJ2lM2SOnHYyQoVMiqtqy+Vyu6PArUz60SZ2F8HSXo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=kPNTOVwQf4L/iWGHivbRgAVmXsFn+8KIRGFOnLF6vvA5eLTmLsSTXh9Gqb9+cQjBIg+rZPhj4UgvNEZLmmIQ0qJA383cg+RCaTw2cGDtposeGKYOQd3bBHQZyJdd9pFeivLhQydpagGPV+lHb9qU2dgnxd+Txi7u5ZQy2skVyUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87EDDC4CED6;
	Sat,  8 Feb 2025 15:30:18 +0000 (UTC)
Date: Sat, 8 Feb 2025 10:30:17 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Borislav Petkov <bp@alien8.de>
Subject: [PATCH] tracing: Add traceoff_after_boot option
Message-ID: <20250208103017.48a7ec83@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

Sometimes tracing is used to debug issues during the boot process. Since
the trace buffer has a limited amount of storage, it may be prudent to
disable tracing after the boot is finished, otherwise the critical
information may be overwritten.  With this option, the main tracing buffer
will be turned off at the end of the boot process.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  9 +++++++++
 kernel/trace/trace.c                            | 11 +++++++++++
 2 files changed, 20 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index fb8752b42ec8..e8ca4eabd152 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -7279,6 +7279,15 @@
 			See also "Event triggers" in Documentation/trace/events.rst
 
 
+	traceoff_after_boot
+			[FTRACE] Sometimes tracing is used to debug issues
+			during the boot process. Since the trace buffer has a
+			limited amount of storage, it may be prudent to
+			disable tracing after the boot is finished, otherwise
+			the critical information may be overwritten.  With this
+			option, the main tracing buffer will be turned off at
+			the end of the boot process.
+
 	traceoff_on_warning
 			[FTRACE] enable this option to disable tracing when a
 			warning is hit. This turns off "tracing_on". Tracing can
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 1496a5ac33ae..1af18908ac3d 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -87,6 +87,7 @@ void __init disable_tracing_selftest(const char *reason)
 static struct trace_iterator *tracepoint_print_iter;
 int tracepoint_printk;
 static bool tracepoint_printk_stop_on_boot __initdata;
+static bool traceoff_after_boot __initdata;
 static DEFINE_STATIC_KEY_FALSE(tracepoint_printk_key);
 
 /* For tracers that don't implement custom flags */
@@ -330,6 +331,13 @@ static int __init set_tracepoint_printk_stop(char *str)
 }
 __setup("tp_printk_stop_on_boot", set_tracepoint_printk_stop);
 
+static int __init set_traceoff_after_boot(char *str)
+{
+	traceoff_after_boot = true;
+	return 1;
+}
+__setup("traceoff_after_boot", set_traceoff_after_boot);
+
 unsigned long long ns2usecs(u64 nsec)
 {
 	nsec += 500;
@@ -10706,6 +10714,9 @@ __init static int late_trace_init(void)
 		tracepoint_printk = 0;
 	}
 
+	if (traceoff_after_boot)
+		tracing_off();
+
 	tracing_set_default_clock();
 	clear_boot_tracer();
 	return 0;
-- 
2.45.2

