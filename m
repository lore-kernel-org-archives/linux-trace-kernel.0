Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27813DD861;
	Wed, 27 May 2026 15:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779894795; cv=none; b=mDL1c2OFwgm3px/m1aQtSZR7RcxPgzKxUB/ceZWR3b96Xh8Oudiy+xQpojo2uWVP1Xsh6i0FrjUE6HjyVtfzw+4/N3tafmeuw6TmTHy//JLwyQ4v1zcKqZ9qNeyfJRQ6bnxqmRLikNe0X9zeBLHpigTZbnIcA5dFQqQHOmPtQXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779894795; c=relaxed/simple;
	bh=fpW5uU9zp6vtjqXkvzHz1jD1EM3dS4GFKCOOiBldhJo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=u7+r27dyLVaumW6iBVGRo8BbHeLMpDWqKRkYrwOSE67yBIJ011rHlpkadTsrMMxTsa8GLWE+rk2Bam0/GNjCsS26BhetHLlr2XNSrrWRxFrfH1OGvi7m7/vkbRi56SLAbC7Am6tBBk4K14DwWlkWriS4LmSPCjKeszW3/ncCtgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=mLW+JH0F; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="mLW+JH0F"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=04hC3vAubNmZqIfS1cbI1r2wH+/xZ8qPSyCJdizFzDo=; b=mLW+JH0FTXihWGFwUPQddNG0Hk
	31p1I51mYjoRh2hRFPioSk1VZUGDmkmy1S7SFek5OhpPITVcJzbBWFWo2fAY97UsYUfvKnP4m817V
	mwhIcj/QDSrcXqL0FPXq59qhRwo8rxdOm4Wv1p0awEZFKa8jUaiJXQUDx0FygZiS/K1MbCSIfBRP8
	NKuEQ9hYrAagZ+vTwvIiE3wFgOJr9y2KRDRlyVBWARURODdfax4jlqWq4bKQmGVEADsgIJcNg/Tba
	vijOOHycMhKnMeEpPZ9Djh6hWpleOUZU1Qe89jkTiPy0e44eiLiEHsG9LOVGnzFJgn3/LLGRsL+ZJ
	4+0cQjFw==;
Received: from [2601:18c:8180:83cc:5a47:caff:fe78:8708] (helo=fangorn)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@surriel.com>)
	id 1wSFwM-000000005FG-0IVa;
	Wed, 27 May 2026 11:13:02 -0400
Date: Wed, 27 May 2026 11:13:01 -0400
From: Rik van Riel <riel@surriel.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3] perf/ftrace: Fix WARNING in __unregister_ftrace_function
Message-ID: <20260527111301.2d0d8256@fangorn>
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

Signed-off-by: Rik van Riel <riel@surriel.com>
---
 kernel/trace/trace_event_perf.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
index a6bb7577e8c5..5b272856e5ab 100644
--- a/kernel/trace/trace_event_perf.c
+++ b/kernel/trace/trace_event_perf.c
@@ -497,7 +497,17 @@ static int perf_ftrace_function_register(struct perf_event *event)
 static int perf_ftrace_function_unregister(struct perf_event *event)
 {
 	struct ftrace_ops *ops = &event->ftrace_ops;
-	int ret = unregister_ftrace_function(ops);
+	int ret = 0;
+
+	/*
+	 * Perf will call this unconditionally even if the ops is not
+	 * enabled. The unregister_ftrace_function() will warn if called
+	 * when not enabled. Just bypass the unregistering if ops isn't
+	 * enabled here.
+	 */
+	if (ops->flags & FTRACE_OPS_FL_ENABLED)
+		ret = unregister_ftrace_function(ops);
+
 	ftrace_free_filter(ops);
 	return ret;
 }
-- 
2.54.0

