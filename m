Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B702D1911;
	Sun,  8 Feb 2026 03:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770521047; cv=none; b=XaJnlBnxhm1l5DwWytaibyGfhSJhcftRLUlh8DhNE1cP2u1b5GWScw0CEcFHaiSF++M7NKhs16lPTL8GOBFx8EPTkktFkTonghJ/+9tMGqid6BeoHiIHoLqBRXhyuik/HwX7SIOMsfj/m+wuUi5fgI1uEDESETDBcbUfmVr03Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770521047; c=relaxed/simple;
	bh=T6KjllVEpFn6yHv1jikWRDhzSSQ7e2FnENqxX2C8/ts=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=O6y7GhFOSPpeibu/ELf6srNye9XL4ijNkg2N1/pwe3WEyrw0wWt7vJmI17osZoupJtW71p1JW+rUZT5Vm/AchxuOkuOmAWoQi7hxdA0CyUg5+TB2nTPKF9VIKcK1ulv1qzounkPXMXQ4fzjNIXZrIlum9BTqJBym/jqId5Tdn4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SiYMa96V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SiYMa96V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F44AC4CEF7;
	Sun,  8 Feb 2026 03:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770521047;
	bh=T6KjllVEpFn6yHv1jikWRDhzSSQ7e2FnENqxX2C8/ts=;
	h=Date:From:To:Cc:Subject:References:From;
	b=SiYMa96VaI25XuAQZAwjhwfNbHm1Ujt0aWDYQJr1pf9PijnIz+hSYcPrHGPbdJUKz
	 VRGmzKnapQyUxLfEkYtbJKgZSg8TVSNYtEgHE68A5tjDzk1iKPoJtWD+ZXBrrvHFGR
	 rClTpQoX7m2Pf3p34BT7obq50P4Bo/293repwEC13mFc1iGgcH648KISNbtIHEqadv
	 QpNB31cV6ayi7OJab0aq/UjJTi1L81DfbhFYHUfP4VVlmfaKrPCOplN7UeGLl7HXPb
	 ziYr3ByDrI0cGmEQbpJ+Q12MQ5v+Y0GWMiX67FPxTymOk6hO4+v23zF1uZEV8s+2LW
	 SZ0ek5geA7W/g==
Received: from rostedt by gandalf with local (Exim 4.99.1)
	(envelope-from <rostedt@kernel.org>)
	id 1vovPm-0000000AOeg-3O7X;
	Sat, 07 Feb 2026 22:24:50 -0500
Message-ID: <20260208032450.660237094@kernel.org>
User-Agent: quilt/0.68
Date: Sat, 07 Feb 2026 22:24:25 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 08/10] tracing: Use system_state in trace_printk_init_buffers()
References: <20260208032417.262341179@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The function trace_printk_init_buffers() is used to expand tha
trace_printk buffers when trace_printk() is used within the kernel or in
modules. On kernel boot up, it holds off from starting the sched switch
cmdline recorder, but will start it immediately when it is added by a
module.

Currently it uses a trick to see if the global_trace buffer has been
allocated or not to know if it was called by module load or not. But this
is more of a hack, and can not be used when this code is moved out of
trace.c. Instead simply look at the system_state and if it is running then
it is know that it could only be called by module load.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index f4ae80564615..4066c33674e7 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3243,10 +3243,9 @@ void trace_printk_init_buffers(void)
 	/*
 	 * trace_printk_init_buffers() can be called by modules.
 	 * If that happens, then we need to start cmdline recording
-	 * directly here. If the global_trace.buffer is already
-	 * allocated here, then this was called by module code.
+	 * directly here.
 	 */
-	if (global_trace.array_buffer.buffer)
+	if (system_state == SYSTEM_RUNNING)
 		tracing_start_cmdline_record();
 }
 EXPORT_SYMBOL_GPL(trace_printk_init_buffers);
-- 
2.51.0


