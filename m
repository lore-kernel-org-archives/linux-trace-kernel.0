Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F82323182B;
	Wed, 30 Jul 2025 14:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753884569; cv=none; b=E4fMUV6LHec5ZjMXnmEGNQ/m0cCEG8uEJYoonYHy7Ur5L8kYWmJ+WGk/jahknv4FuhQa6jtdJc0NGZF20UUf9zOGUecx4VUCHTAyQ7TDhyz9Hrw1VWDq6JNBiAqLQQuZUZvYmYTZ7/aei5Q7sJBtaNDsnPUmlCdpmIubiqb8cKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753884569; c=relaxed/simple;
	bh=N+Tnv/N66YEv6ggngRxCmBrDSXR95wkV4husqFi2QEQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=gjyULP/DsC8BLyuJrZCWB+8d0dv6gZgpK7qDr3tAaMz/Vuy0UWxmrg2CGNURvup5pxiHgxOfVyLMHvv6gi64sq2V3kvUUAievkqq33twOA4FkpO/GQmSBv2tVz8oD+R5b1KaQafpmehivRoCWaEUYvwIG6MCgvy47fz8qbJgmmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFoR68tw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFoR68tw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD4FC4CEE7;
	Wed, 30 Jul 2025 14:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753884568;
	bh=N+Tnv/N66YEv6ggngRxCmBrDSXR95wkV4husqFi2QEQ=;
	h=Date:From:To:Cc:Subject:References:From;
	b=HFoR68twhmQPZkS9WABXNg5w8G1zfjejBNaF8EBTM5DZi5B6KID02keIaTLLQD8/N
	 4oOnzrrFvOukUFOBQMXByshOU0cwsBmAUFkBrwSWL5Ju6H5KgWyva5YcasaI5Yk8qa
	 6UOHzRbNb7zhjpGPgcCn9jidU+/pHgmJoYxjNo41EZjxRwCd4kNIkN4WXjbX5M/yRh
	 QRZQyWGdL+w/3KSBUY9FcHQU0zLqIGieJnmXCUouO04+szqFFmlLKyliLLsSE59X3y
	 bZxaWP6LDOXVT7JQhRH5yJQNAeL6OL+zCx6wmGU/h4oRJOf3Ov3QFVuyUZSbNYr8bP
	 hgQjfzAmw0YOg==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uh7V3-00000005yeN-285N;
	Wed, 30 Jul 2025 10:09:45 -0400
Message-ID: <20250730140945.360286733@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 30 Jul 2025 10:07:54 -0400
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
Subject: [PATCH v3 1/2] tracing: Have eprobes have their own config option
References: <20250730140753.168615576@kernel.org>
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
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v2: https://lore.kernel.org/20250729161912.056641407@kernel.org

- Added Kconfig dependency on HAVE_REGS_AND_STACK_ACCESS_API (Masami Hiramatsu)

 kernel/trace/Kconfig  | 14 ++++++++++++++
 kernel/trace/Makefile |  2 +-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 93e8e7fc11c0..f80298e6aa16 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -792,6 +792,20 @@ config UPROBE_EVENTS
 	  This option is required if you plan to use perf-probe subcommand
 	  of perf tools on user space applications.
 
+config EPROBE_EVENTS
+	bool "Enable event-based dynamic events"
+	depends on TRACING
+	depends on HAVE_REGS_AND_STACK_ACCESS_API
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


