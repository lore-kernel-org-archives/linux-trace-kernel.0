Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B996C16D9C2;
	Thu,  6 Nov 2025 00:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762389292; cv=none; b=lEB1akVzS3TtgVvaw2EtnNikS5cSdlQIYdoUFnqt5YW0CWV7G8xxN/Y/t0VEFQ7TNhzjo3x99hEZ3xlRc9iBY5QHnbzfdq6Ef4gpr49oMWgtHCPzPDM1bofGCwt/x52HAA+DxnaoWwstX8IX7om0iTE0Za0EfYSPP9P1KhXcwjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762389292; c=relaxed/simple;
	bh=Ql+H8A5+GMaJkE7Zpv0T+FJ4Id1te48MhyUNdLkw2bg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=aGxySezGCLFrjRdXrKqewujuk5E3W8xMTGX0buQRGCUZekmGHLdSK4fz1B3mzs4EaaRqkqIVQ3xXvUpooD4vsJge+CnZnTHDpiRfWcfznEJwkAKK31+DMx9UA00XLT1nEVid4x5nEcCWFHUD9HWzG/L5T1NEc9p+3iT9O72CmlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJdfXsBf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJdfXsBf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A231C116D0;
	Thu,  6 Nov 2025 00:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762389292;
	bh=Ql+H8A5+GMaJkE7Zpv0T+FJ4Id1te48MhyUNdLkw2bg=;
	h=Date:From:To:Cc:Subject:References:From;
	b=XJdfXsBfMyWba9m8O6tTXKDOt+ytO0b+ClVo6ci4aPOsR402kL9boqh9dZrbQaUNu
	 820+AaZ7WqAc97BCKM8rjOG6NburzUeFZ/NF9oQiAN0Ukfma3jsGERnEk+4eP2JCyF
	 Lj9HEjT4EumBTV+KICYB5lRuAjAYNsVXHLrOfpMjgIcSeZS8AgtI90RqJIbDfg6Z10
	 hFmayU4NLGA6uttJj250xPjwsklTp/S829OnWhlKDWNq6rOBRar8s/rhjpqax7jKMs
	 vMir1Yi8mbLTiJnS9QrM8NTjY1ez1g/OdRuQpPgYj13PejDBf6ns54gxbfY2ciARPv
	 RyTg13yMxw1YQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vGnxu-000000019J6-0744;
	Wed, 05 Nov 2025 19:35:02 -0500
Message-ID: <20251106003501.890298562@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 05 Nov 2025 19:33:26 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 2/2] tracing: Use switch statement instead of ifs in set_tracer_flag()
References: <20251106003324.964761749@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The "mask" passed in to set_trace_flag() has a single bit set. The
function then checks if the mask is equal to one of the option masks and
performs the appropriate function associated to that option.

Instead of having a bunch of "if ()" statement, use a "switch ()"
statement instead to make it cleaner and a bit more optimal.

No function changes.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 07bd10808277..8460bec9f263 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5251,11 +5251,13 @@ int trace_keep_overwrite(struct tracer *tracer, u64 mask, int set)
 
 int set_tracer_flag(struct trace_array *tr, u64 mask, int enabled)
 {
-	if ((mask == TRACE_ITER(RECORD_TGID)) ||
-	    (mask == TRACE_ITER(RECORD_CMD)) ||
-	    (mask == TRACE_ITER(TRACE_PRINTK)) ||
-	    (mask == TRACE_ITER(COPY_MARKER)))
+	switch (mask) {
+	case TRACE_ITER(RECORD_TGID):
+	case TRACE_ITER(RECORD_CMD):
+	case TRACE_ITER(TRACE_PRINTK):
+	case TRACE_ITER(COPY_MARKER):
 		lockdep_assert_held(&event_mutex);
+	}
 
 	/* do nothing if flag is already set */
 	if (!!(tr->trace_flags & mask) == !!enabled)
@@ -5266,7 +5268,8 @@ int set_tracer_flag(struct trace_array *tr, u64 mask, int enabled)
 		if (tr->current_trace->flag_changed(tr, mask, !!enabled))
 			return -EINVAL;
 
-	if (mask == TRACE_ITER(TRACE_PRINTK)) {
+	switch (mask) {
+	case TRACE_ITER(TRACE_PRINTK):
 		if (enabled) {
 			update_printk_trace(tr);
 		} else {
@@ -5283,9 +5286,9 @@ int set_tracer_flag(struct trace_array *tr, u64 mask, int enabled)
 			if (printk_trace == tr)
 				update_printk_trace(&global_trace);
 		}
-	}
+		break;
 
-	if (mask == TRACE_ITER(COPY_MARKER)) {
+	case TRACE_ITER(COPY_MARKER):
 		update_marker_trace(tr, enabled);
 		/* update_marker_trace updates the tr->trace_flags */
 		return 0;
@@ -5296,10 +5299,12 @@ int set_tracer_flag(struct trace_array *tr, u64 mask, int enabled)
 	else
 		tr->trace_flags &= ~mask;
 
-	if (mask == TRACE_ITER(RECORD_CMD))
+	switch (mask) {
+	case TRACE_ITER(RECORD_CMD):
 		trace_event_enable_cmd_record(enabled);
+		break;
 
-	if (mask == TRACE_ITER(RECORD_TGID)) {
+	case TRACE_ITER(RECORD_TGID):
 
 		if (trace_alloc_tgid_map() < 0) {
 			tr->trace_flags &= ~TRACE_ITER(RECORD_TGID);
@@ -5307,24 +5312,27 @@ int set_tracer_flag(struct trace_array *tr, u64 mask, int enabled)
 		}
 
 		trace_event_enable_tgid_record(enabled);
-	}
+		break;
 
-	if (mask == TRACE_ITER(EVENT_FORK))
+	case TRACE_ITER(EVENT_FORK):
 		trace_event_follow_fork(tr, enabled);
+		break;
 
-	if (mask == TRACE_ITER(FUNC_FORK))
+	case TRACE_ITER(FUNC_FORK):
 		ftrace_pid_follow_fork(tr, enabled);
+		break;
 
-	if (mask == TRACE_ITER(OVERWRITE)) {
+	case TRACE_ITER(OVERWRITE):
 		ring_buffer_change_overwrite(tr->array_buffer.buffer, enabled);
 #ifdef CONFIG_TRACER_MAX_TRACE
 		ring_buffer_change_overwrite(tr->max_buffer.buffer, enabled);
 #endif
-	}
+		break;
 
-	if (mask == TRACE_ITER(PRINTK)) {
+	case TRACE_ITER(PRINTK):
 		trace_printk_start_stop_comm(enabled);
 		trace_printk_control(enabled);
+		break;
 	}
 
 	return 0;
-- 
2.51.0


