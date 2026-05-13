Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E4A7083C;
	Wed, 13 May 2026 20:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778703573; cv=none; b=UZjYHKPCub5cpKmRNsChQYQQcheiLIJY2rG1w5cDlPDYthA+t9WKA+8P9sSVyXM1pjTb85roz9Qk7rPzXbKVEA5uBURJG39Nu3R725Q5ZW4Vtm3TEsGTH7z4LPV3zvW+QQC1pxFS2p6et5yM6RWAIZGN5+hORGC5C229Z2C9dko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778703573; c=relaxed/simple;
	bh=6VaH+fK2qB0XeLTvDaf4HmUJ3Qgpz9mXonIs89MXfdk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=QbYBZxTqv+ys1oPOlenSqfcyKcqRLhxMOPK403GNeu7Of2GRZFEkvPzc2KDOmXpfMc2dm28OaSd4T/TCkMX6bpJTa4f3fOwXk4fBEgTKqia3IpWDIp/7mPaajuZ7xS/ByFz9qBgLsj/a3I6+Iqzm62QTXPej7Zbr8qrCa6MbE7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=c8BrMglR; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="c8BrMglR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=otkCwAQY62CWYRQpL0+PhUPsJLYyxts3qIbizB5ZBmg=; b=c8BrMglRjqfS7CoOG6QhRkR/dD
	Vd1JPC7GIplqe5zWDFWIGSuewKOYxEdmAIgp1fILt8kUXzbCXM5OhuQ/f0EprHpPC6LDgxOOVdfqB
	/LwUK3kg7i7Pbi5brUbNx/+BCIamMnsTNB3MkPOQ29I7qCahlGALXHgSVWupfE/tQW2EuemhTWbTy
	W1ne/Ygz3MHXD9uo2ftZWn7IT2lOj29bNMMjGqlKAvAwCAW5CfvxwKJa4bvD1MUgNnNn31MXai3zg
	TP7JV8wPQdjHvxzzc3MF5q8ns/1m8LB7iR9Mqq9odZwtkn1HKDHYbGQJyj2PkSQ3WHtojnjq5je4s
	WiA9xMbw==;
Received: from [2601:18c:8180:83cc:5a47:caff:fe78:8708] (helo=fangorn)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@surriel.com>)
	id 1wNG32-0000000012H-2Hjg;
	Wed, 13 May 2026 16:19:16 -0400
Date: Wed, 13 May 2026 16:19:16 -0400
From: Rik van Riel <riel@surriel.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, kernel-team@meta.com
Subject: [PATCH v2] perf/ftrace: Fix WARNING in __unregister_ftrace_function
Message-ID: <20260513161916.04151502@fangorn>
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
 kernel/trace/trace_event_perf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
index a6bb7577e8c5..58e1b427b576 100644
--- a/kernel/trace/trace_event_perf.c
+++ b/kernel/trace/trace_event_perf.c
@@ -497,7 +497,11 @@ static int perf_ftrace_function_register(struct perf_event *event)
 static int perf_ftrace_function_unregister(struct perf_event *event)
 {
 	struct ftrace_ops *ops = &event->ftrace_ops;
-	int ret = unregister_ftrace_function(ops);
+	int ret = 0;
+
+	if (ops->flags & FTRACE_OPS_FL_ENABLED)
+		ret = unregister_ftrace_function(ops);
+
 	ftrace_free_filter(ops);
 	return ret;
 }
-- 
2.52.0


