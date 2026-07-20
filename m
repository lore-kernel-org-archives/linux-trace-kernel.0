Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BB13DDB06;
	Mon, 20 Jul 2026 10:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784544298; cv=none; b=maKnZoooQtU39ktwEBIx9D2cWruOy7/Igb7ShdhViBxvno/e2oNEU7uJfUYZdQHP7ONcicZumeb/gUda5iOXPV4qcvq6Mc1/k1skP+qxpFdIDUfCMLNOv6X14eYm10Kasq+Dy2/+lSsJx0OXcSmFzBb7u3dCbr6bn3uD+ggshcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784544298; c=relaxed/simple;
	bh=LV9wZknICYkghG3A0yONr15qtMDlN6ma0+U1qsIUhgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=owL7qqqEZfE91L4PlO+mAZK2uWEbFutw5+WiFdZnoGwFURLwl5pxNx1QoGSLYHZ6B4hKDGK308zT2XlVyO168Kqs/EK61Ogd8uvZ9v/R7Ouq8YdVlO7VCIB5HqImNdYcEOkDHDGKglqj8IxXd8RXCFZdJS9Ih4udQAQRjpvKXaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/DUTWTI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/DUTWTI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 394331F000E9;
	Mon, 20 Jul 2026 10:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784544287;
	bh=OJfwycJ/7ClTOzd4xktAKZT6GOwq9Yrwaydn1j9pmP8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m/DUTWTIZ2r7ZmXu9tRnxLTfRlt6NzULQdOJQfZSqxOJNGbyFmM9UM+PejrLdadhA
	 GfJKLU+PjZ47i7pIFtsBALoxlNUSqst5B1Bt5d1blprZlc9TStgHElIQXBDkd/SYt4
	 vGUR3SfsHuGKIwFCVcUuUlf5/ZeStWiORpiacK/xD2bFk17LtT3X1m9mOfX9oL5zUH
	 c0tnr+FTZMORQ4YSm+M2T6d3VdnPvYInAUsPDfa1XwNR9rVxDXz96yMz9BpscgboKd
	 m5LSykT9GbW4AUzKCLhcycpDluacbm8iMbrsQcu3SrbTrB+lcFuQ84WLfCDyvCjkZI
	 HqNIxG6DY6hyw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 08/10] tracing/fprobe: Remove redundant memset in fentry_perf_func()
Date: Mon, 20 Jul 2026 19:44:43 +0900
Message-ID: <178454428366.296567.16465331441301815980.stgit@devnote2>
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

fentry_perf_func() calls memset(&entry[1], 0, dsize) prior to calling
store_trace_args(). store_trace_args() populates the entry buffer and
handles dynamic data fields.

Furthermore, passing dsize (the dynamic data byte length) to memset at
&entry[1] (the start of fixed trace arguments) is inaccurate as it zeroes
from the fixed args area rather than the dynamic data region.

Remove this redundant memset call to align with fexit_perf_func() and other
probe perf functions.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_fprobe.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index 566b64853c61..ec9105fca4a6 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -471,7 +471,6 @@ static int fentry_perf_func(struct trace_fprobe *tf, unsigned long entry_ip,
 	regs = ftrace_fill_perf_regs(fregs, regs);
 
 	entry->ip = entry_ip;
-	memset(&entry[1], 0, dsize);
 	store_trace_args(&entry[1], &tf->tp, fregs, NULL, sizeof(*entry), dsize);
 	perf_trace_buf_submit(entry, size, rctx, call->event.type, 1, regs,
 			      head, NULL);

