Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F384D3DD875;
	Mon, 20 Jul 2026 10:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784544307; cv=none; b=bfHNfO0RDl27Er2LXOSnAR11Hs+Z7wMRuHn6pfFy2AKjcMEz8q1hHXrCZTVvPIveoEvcRuPXSZR3ObH5fG65YwqiSywT6tv3OSmmkO8dx1IvNP9ZyvcAYkS/S7xgabuot1nms2a8HdT3NZAQyVsHG2D+GaDdgUH1IC+0Rvi4Gdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784544307; c=relaxed/simple;
	bh=Scya5jTzoMHfqY9tcNDtgk5ta4MhElG464vtFe/Wp/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IxXg4OG38seKBV1Tg25Lgga58785XMKDeYG4UnQ+QbnXZSgxl/dWAIeXS0f9np8AzbDT2vZ/rc/prvpspxxFQG9x+aCl3CuVJ0ycaqCXK1Zy6KFYw8gLlnBqw3CWIJCUuOZWJ20mrLgEdBksMGgPg5PADnR9o3I5h2zCX+ZGsg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dpb0YfI3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dpb0YfI3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D351F00A3A;
	Mon, 20 Jul 2026 10:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784544297;
	bh=aT6chHk/hvlofAsrR1SryBN8/uGxNuXdVvRWxO6TYBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dpb0YfI3Oj9SuDk0PAH59c0mGHB43yj51WD7ZpDFbkksSLxjCgZiZHcR9NQZpJjjD
	 yagfukj9xs/U/7Tgj6DjzGCck8cjMKT6A+QuDnqUIPHrMXuK4D5tAmNaqK/4mXc6Im
	 sSB2SnrSKJli48GqF3CcMu12HKunJP3t/wczkqbNDPHOj5lJP0kR58yLqiAYI+e0FC
	 6J87EUM9bsuKCElfC7TAXZ9bv23DMI5oyarWZNiSlA0bIgqg02uSA3rkZIY/REbV0S
	 8m4LYei1xbI5enM4Ml/gWZYiAHykJRrQsz3gNnzy8Sfkoe4OTEdS5rJXPrMQ9gpn0I
	 ljwTOg64CTTuA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 09/10] tracing/kprobe: Remove redundant memset in kprobe_perf_func()
Date: Mon, 20 Jul 2026 19:44:53 +0900
Message-ID: <178454429309.296567.17379087988750549247.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178454420994.296567.10239174745865301350.stgit@devnote2>
References: <178454420994.296567.10239174745865301350.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

kprobe_perf_func() calls memset(&entry[1], 0, dsize) prior to calling
store_trace_args(). store_trace_args() populates the entry buffer and
handles dynamic data fields.

Remove this redundant memset call to align with kretprobe_perf_func() and
other probe perf functions.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_kprobe.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index cc24e992732c..c25f902aa1a6 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1721,7 +1721,6 @@ kprobe_perf_func(struct trace_kprobe *tk, struct pt_regs *regs)
 		return 0;
 
 	entry->ip = (unsigned long)tk->rp.kp.addr;
-	memset(&entry[1], 0, dsize);
 	store_trace_args(&entry[1], &tk->tp, regs, NULL, sizeof(*entry), dsize);
 	perf_trace_buf_submit(entry, size, rctx, call->event.type, 1, regs,
 			      head, NULL);

