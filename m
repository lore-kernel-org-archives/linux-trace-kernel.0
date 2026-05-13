Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C84282F34;
	Wed, 13 May 2026 16:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778688984; cv=none; b=DJl/peKXd0x7SLx3eom+CjbtPnb3jite6cflYUKzml+ocBjXlxU/uUpATU2F1vL+y9MB+HnPrBwT4CD+dUzUs9Fq1rQGSqDk0iExkWoFivTFJuFKJkswlGuC4ncrcmqdV0T/mTRnjvLfF9QGveCzj6FV6QEIWOSAYSwYgIRmupA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778688984; c=relaxed/simple;
	bh=d1S0tc+pboulCw1sblcTRgb8enWG+V9dKWRqmJ2/KRY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Ub81PuvAWXJcmjKFGTtnKKMMvU05UFJhmT8KkI1gPtZ0/T3MsHSlQZxOzFs8yrBoXgsQ1U7cbZp/NNpYM4kXWvFvyK4sH2x90IMgcn5Ev1FGrvuJhVwRgEdtc64cmNmCasXWr5XMvHuJJJBtoBYh43Z0/vUPIasTXsLCh9ZjasU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=m/XtLcex; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="m/XtLcex"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=dRa2nvez8IJQnvtB9YGQJFrPNTJQb7WD1xgO5uUHxNU=; b=m/XtLcexVMrXc5eqOAaIyDHY7z
	E+2rSZ8CNiFpaNSlZNbCAPRPzgMyj2xo6s/V8t18ekfsRghMfsfmzSRI97cXUnvN1m7hnh4uyCc4U
	DPH5n5p/detHyZuHzCpzdjWAQsHMeaMcWMpyNmPVftRkkuGxXe4eeBxHWVgTimvyALmxTI05RPdAr
	zYKrcJIwSOPsYsL4tsVQv1z7+f9RkRD1utKiVhdVYsGzbGOqEzSssT7qkli6HVM1LAzFhiZUChEw+
	EoUPgurW6lcFJUUjtuAJLJJVHdXXlEmXXO5ETwzGesV+PQ4ecFdEW1Rjuu1H8vEiprJNGoqZSElWq
	rc9kDcVw==;
Received: from [2601:18c:8180:83cc:5a47:caff:fe78:8708] (helo=fangorn)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@surriel.com>)
	id 1wNCFk-000000006EO-0noB;
	Wed, 13 May 2026 12:16:08 -0400
Date: Wed, 13 May 2026 12:16:07 -0400
From: Rik van Riel <riel@surriel.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, kernel-team@meta.com
Subject: [PATCH] perf/ftrace: Fix WARNING in __unregister_ftrace_function
Message-ID: <20260513121607.14eab1f6@fangorn>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

perf_ftrace_function_unregister() unconditionally calls
unregister_ftrace_function() without checking whether the ftrace_ops
was ever successfully registered. This triggers a WARN_ON in
__unregister_ftrace_function() when the ops doesn't have
FTRACE_OPS_FL_ENABLED set.

This can happen during perf_event_alloc() error cleanup when
perf_trace_destroy() is called via __free_event() on an event whose
ftrace_ops registration failed or was already torn down by
perf_try_init_event()'s err_destroy path.

The call path is:
  perf_event_alloc() error cleanup
    -> __free_event()
      -> event->destroy() [tp_perf_event_destroy]
        -> perf_trace_destroy()
          -> perf_trace_event_close()
            -> TRACE_REG_PERF_CLOSE
              -> perf_ftrace_function_unregister()
                -> unregister_ftrace_function()
                  -> __unregister_ftrace_function()
                    -> WARN_ON(!(ops->flags & FTRACE_OPS_FL_ENABLED))

Fix this by checking FTRACE_OPS_FL_ENABLED before attempting to
unregister. If the ops is not enabled, just free the filter and
return success.

Assisted-by: Claude:claude-opus-4.7 syzkaller
Signed-off-by: Rik van Riel <riel@surriel.com>
---
 kernel/trace/trace_event_perf.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
index a6bb7577e8c5..b9e33ae24867 100644
--- a/kernel/trace/trace_event_perf.c
+++ b/kernel/trace/trace_event_perf.c
@@ -497,7 +497,14 @@ static int perf_ftrace_function_register(struct perf_event *event)
 static int perf_ftrace_function_unregister(struct perf_event *event)
 {
 	struct ftrace_ops *ops = &event->ftrace_ops;
-	int ret = unregister_ftrace_function(ops);
+	int ret;
+
+	if (!(ops->flags & FTRACE_OPS_FL_ENABLED)) {
+		ftrace_free_filter(ops);
+		return 0;
+	}
+
+	ret = unregister_ftrace_function(ops);
 	ftrace_free_filter(ops);
 	return ret;
 }
-- 
2.53.0-Meta

