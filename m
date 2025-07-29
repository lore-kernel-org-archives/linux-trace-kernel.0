Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F234E1487ED;
	Tue, 29 Jul 2025 16:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753805938; cv=none; b=FoiIcs2SL0DiyMQpIxzkPzdA/kI8P9bu1vgzHwRnpu/zpXKyc+oz9PZFQa9jVIh1XZeO2MsKHQ4pOua6gVDNHNZf4msivV0DPKrSVrQmnLtRs0+bHOpoknffWl1kBMQof17bim0QrKEHGRXWuWxviPhsWdWLpNlChGg5lkFDjiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753805938; c=relaxed/simple;
	bh=sulLDnJywSpEQ5Sh3mCpZMqyiCZCPXULfekwryneRnk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=inunJ2ZOE6CiSr3IKS4buWH3AgMDZJsbal+pUeOjPgqIdDMrbUyHDGeXzt4LLg4oLuDY7yDQWfftnn67+UMqf1ui2E15aimNlrAEq2VCEAt5Vw3eTg/r5q2ImHjyZ3ip53xvXXzv0dr2fUIAVudbCNjbRxaf+K5ajV9d0bwDx3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gAZq7Qh+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gAZq7Qh+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9305EC4CEEF;
	Tue, 29 Jul 2025 16:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753805937;
	bh=sulLDnJywSpEQ5Sh3mCpZMqyiCZCPXULfekwryneRnk=;
	h=Date:From:To:Cc:Subject:References:From;
	b=gAZq7Qh+Jq8JXC9wJYGNuylpm39d5lFGKKeuf0i35Lt+Z87u5qXKZDuhd02jphrDi
	 w2EHERNkD9u5TnPHCjAYCZmYsWDHb1WorRKE+Un/0vKIuTy14HxG3l/qL3yGW3KyWy
	 FOS566/ZswRhoxFTLZOxKDN+sH+KJGXEI9NHn19qdVR3J1+STuAkGmAPnQLEa1H5Y5
	 Frmthic4cGWGtCa0N9Vx84gI09rvcs/5lCOeyMpXrbhnQdIzYNHvK6Rp/IYNQIdsxo
	 Fp7dTtNrArnU9fMkIUCD8WaRn7J3lJG0cSMIq2+iGz7mrd817+z7gFaJj5nMwe27q7
	 xCZek1gEkvRog==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ugn2m-00000004ybQ-0rOH;
	Tue, 29 Jul 2025 12:19:12 -0400
Message-ID: <20250729161912.056641407@kernel.org>
User-Agent: quilt/0.68
Date: Tue, 29 Jul 2025 12:18:17 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 1/2] tracing: Have eprobes have their own config option
References: <20250729161816.678462962@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Eprobes were added in 5.15 and were selected whenever any of the other
probe events were selected. If kprobe events were enabled (which it is by
default if kprobes are enabled) it would enable eprobe events as well. The
same for uprobes and fprobes.

Have eprobes have its own config and it gets enabled by default if tracing
is enabled.

Link: https://lore.kernel.org/all/20250729102636.b7cce553e7cc263722b12365@kernel.org/

Suggested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/Kconfig  | 13 +++++++++++++
 kernel/trace/Makefile |  2 +-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 93e8e7fc11c0..b951c027fffb 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -792,6 +792,19 @@ config UPROBE_EVENTS
 	  This option is required if you plan to use perf-probe subcommand
 	  of perf tools on user space applications.
 
+config EPROBE_EVENTS
+	bool "Enable event-based dynamic events"
+	depends on TRACING
+	select PROBE_EVENTS
+	select DYNAMIC_EVENTS
+	default y
+	help
+	  Eprobes are dynamic events that can be placed on other existing
+	  events. It can be used to limit what fields are recorded in
+	  an event or even dereference a field of an event. It can
+	  convert the type of an event field. For example, turn an
+	  address into a string.
+
 config BPF_EVENTS
 	depends on BPF_SYSCALL
 	depends on (KPROBE_EVENTS || UPROBE_EVENTS) && PERF_EVENTS
diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index 057cd975d014..dcb4e02afc5f 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -82,7 +82,7 @@ obj-$(CONFIG_EVENT_TRACING) += trace_event_perf.o
 endif
 obj-$(CONFIG_EVENT_TRACING) += trace_events_filter.o
 obj-$(CONFIG_EVENT_TRACING) += trace_events_trigger.o
-obj-$(CONFIG_PROBE_EVENTS) += trace_eprobe.o
+obj-$(CONFIG_EPROBE_EVENTS) += trace_eprobe.o
 obj-$(CONFIG_TRACE_EVENT_INJECT) += trace_events_inject.o
 obj-$(CONFIG_SYNTH_EVENTS) += trace_events_synth.o
 obj-$(CONFIG_HIST_TRIGGERS) += trace_events_hist.o
-- 
2.47.2


