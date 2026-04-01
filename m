Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C47223DFF
	for <linux-trace-kernel@vger.kernel.org>; Wed,  1 Apr 2026 02:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775011922; cv=none; b=h5ZoAyqMH6jTuL+N37vAK84JAEowANkS3+DMmNBH/XLA+vwHOCADy1wHPdYQvkVd5yLbE9FvSCwFNQIl3dPMmgyautGuvuPtCCoK4jWYlaKDz46EjznVDje/e33y4vLPzACGZbyCRhzjnUCYg9/xaytS6RQnJDEfHbZdSno5M+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775011922; c=relaxed/simple;
	bh=Xrq4aUL1JXkGE55doELayakGSYFvldPCKQqMYlmSfgE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cgzaQgEV/KvKUrwFn2NAu4rEUJWurAZATv9sNNIr8G/HkyU0n3lqRLlLBfEUc5klwoNHhyKy8+G8sh3nITm9liU/7GddEDDSzIrc/IAP7dzedcwfyJMytcKqo5Ywo/ZjBR3SckhE9M6ZpH2O3qLywQEimsLC2AgQw+4LFtdWdnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X3vzetFv; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X3vzetFv"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4837b6f6b93so60843045e9.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 31 Mar 2026 19:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775011914; x=1775616714; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Eca4DbOW8XwXrqOV4vR/pp7c+WdGwg7Dl0/8lIXWnzc=;
        b=X3vzetFvus37+1WAhyXaIuY8EtRRAdKlqHXIltzJ/mdCWiNHSds9zEI5Sz0MIAqU6J
         UvlTO3ugl1/jPOUC18oNtKYzpf7ep0V8r9g20EmT7bgPK2IOmDHPkI1DEe+ijeBtbdEP
         o+FafTT3nAdSN95u+m0lIl0zj95t81RQ48ZCxzNSJJ1r3H+waNWskLaSyfPRzhDQvMR9
         BN99zrGrGCR2Lh/qwjeeDoAd8DFgRA4RqmNui+PdXkAkw1MJp7hQnLUvB5/ChtSBAiHq
         pk6tQK9JnFq163ORvTClEX6bhabC82SxNl/p3E18PaC4YhMO9VlhvWVwrmp5I08Y/N3/
         welg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775011914; x=1775616714;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Eca4DbOW8XwXrqOV4vR/pp7c+WdGwg7Dl0/8lIXWnzc=;
        b=aEaa3WtIUMt9foyroWK725Vt6ue8u7MyLliq+zevDkMbwolq5/D+Ja8ZzcGJJ6yHcz
         MSRe3cD72ie76lDlDtGBXcIMv8WMhtfXCMN5G+CsnNTEtYu6MIQ9AyW3mbDqGAX2p1WZ
         qJI0obAjVOB9dJfcW18fsprUKkwovGOgx/NdUqekIM6ls9Q8Nu8/Ykkif6WT0qvt/91L
         mmLhbASYU9FhZJnX3ZTiZS4b6mYJCOABbphEkB8xbSiXyuysm8mp2f6Npf+k7ZKoaYiI
         Oh0R12S9dXd0jp9I1c26jX4/rCOeQg51JZX/fy2h3B5rBrENfcad5Q1IUlqtNlgkNGHg
         9xwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKwafNrqFtd04y8zqADHh11+/rieCFxnxIEZ9cMiPvP9HxSuzBnlGE94zheV4t1yEDksqYYIiKqMC5NCqbEA3vKBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgommN+eIXhF5MeZMSx6qccVksi06e+aQl/MMoxK4v+ouHq5hJ
	BqR2XMDRPb5vk1uWOK/PKs00jSJre8UiF2exP9P6AkEbiD0FJSnRs0n34PfNHoyRspwfyWYmUny
	xuIwmPFkKj9quRCLU1eD7YQ==
X-Received: from wmow3.prod.google.com ([2002:a05:600c:4743:b0:485:2ef1:a59b])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600d:8:b0:486:ffa3:594 with SMTP id 5b1f17b1804b1-488835b760amr22907075e9.23.1775011914540;
 Tue, 31 Mar 2026 19:51:54 -0700 (PDT)
Date: Wed,  1 Apr 2026 03:50:02 +0100
In-Reply-To: <20260401025003.3258729-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260401025003.3258729-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260401025003.3258729-2-vdonnefort@google.com>
Subject: [PATCH 1/2] tracing: Non-consuming read for trace remotes with an
 offline CPU
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

When a trace_buffer is created while a CPU is offline, this CPU is
cleared from the trace_buffer CPU mask, preventing the creation of a
non-consuming iterator (ring_buffer_iter). For trace remotes, it means
the iterator fails to be allocated (-ENOMEM) even though there are
available ring buffers in the trace_buffer.

For non-consuming reads of trace remotes, skip missing ring_buffer_iter
to allow reading the available ring buffers.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index 0d78e5f5fe98..39d5414c1723 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -282,6 +282,14 @@ static void trace_remote_put(struct trace_remote *remote)
 	trace_remote_try_unload(remote);
 }
 
+static bool trace_remote_has_cpu(struct trace_remote *remote, int cpu)
+{
+	if (cpu == RING_BUFFER_ALL_CPUS)
+		return true;
+
+	return ring_buffer_poll_remote(remote->trace_buffer, cpu) == 0;
+}
+
 static void __poll_remote(struct work_struct *work)
 {
 	struct delayed_work *dwork = to_delayed_work(work);
@@ -324,6 +332,10 @@ static int __alloc_ring_buffer_iter(struct trace_remote_iterator *iter, int cpu)
 		iter->rb_iters[cpu] = ring_buffer_read_start(iter->remote->trace_buffer, cpu,
 							     GFP_KERNEL);
 		if (!iter->rb_iters[cpu]) {
+			/* This CPU isn't part of trace_buffer. Skip it */
+			if (!trace_remote_has_cpu(iter->remote, cpu))
+				continue;
+
 			__free_ring_buffer_iter(iter, RING_BUFFER_ALL_CPUS);
 			return -ENOMEM;
 		}
@@ -347,10 +359,10 @@ static struct trace_remote_iterator
 	if (ret)
 		return ERR_PTR(ret);
 
-	/* Test the CPU */
-	ret = ring_buffer_poll_remote(remote->trace_buffer, cpu);
-	if (ret)
+	if (!trace_remote_has_cpu(remote, cpu)) {
+		ret = -ENODEV;
 		goto err;
+	}
 
 	iter = kzalloc_obj(*iter);
 	if (iter) {
@@ -476,6 +488,9 @@ __peek_event(struct trace_remote_iterator *iter, int cpu, u64 *ts, unsigned long
 		return ring_buffer_peek(iter->remote->trace_buffer, cpu, ts, lost_events);
 	case TRI_NONCONSUMING:
 		rb_iter = __get_rb_iter(iter, cpu);
+		if (!rb_iter)
+			return NULL;
+
 		rb_evt = ring_buffer_iter_peek(rb_iter, ts);
 		if (!rb_evt)
 			return NULL;
-- 
2.53.0.1118.gaef5881109-goog

