Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E32037F748
	for <linux-trace-kernel@vger.kernel.org>; Wed,  1 Apr 2026 04:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775019142; cv=none; b=Lf0+wzzP/xpdxdMxO99f6chpDJhNW+7bkcgpKB9K60A9H5cou293eRnQeOIYSxMrA2zYr5Vv3LHc/5xh64jaU2MoOY5goIpp9ILfURP40vDprpQTs/I49YoKT/DkP8JTKirZNge31d6+KT+8zIfFo/IppJEbPKtT62kzASxT+v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775019142; c=relaxed/simple;
	bh=IIW5MGp1erBt6CogygoK15lk/eSdIFNLr1/sdWWPNc4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T89lwceI/oIdR1vYS8FH0Be6qUefzq5JJJ6L61krSO99vK/lL0Mbf9jc6VRuqR5ZZLTjAXh2vTUl6KdztZjdAFVvny/45AfXkNicWVBf2dqis1ggVeufW72X6X2CiSV1tPpKnpNVnsqTpg5m/O3LXorgb86mo2LkgjzBfAt1oHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GfOkbqPR; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GfOkbqPR"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4887e4b338bso4547855e9.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 31 Mar 2026 21:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775019140; x=1775623940; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AK7C9g36qtD1NdTgAM1Qfb35mHUC8CgKZhIzjTXpWYU=;
        b=GfOkbqPR+DXANHT8HDdZfvXPRcaYwKQYrIqODehdl5B2RjhMpWL/AW2EyGeiepjIPd
         KVy5IYiVhA8rsIs1HXcHHvbroWi56GGoHKxEooL7Cmi+yVu3phW4sTa+MYn/MoOsOXcK
         9SkyD5Pi0TGPu4bDecc/MAHaMzc5IdhoMqEghZ13FMBSQU/feDRTrfw4lMObMSANpyFR
         RSrvP0OGPA3DvkxUJyof7oOwJVUBIZLyMXalpL0K0KHOTHVgadgdAN0vQcfZci+lr8HO
         HQcJfncjvI4/z54xvH5c010RjvwklJW9/r5bUfKcM7syMlO8QHoKEJ2p9v7MUtOd1pYO
         h0XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775019140; x=1775623940;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AK7C9g36qtD1NdTgAM1Qfb35mHUC8CgKZhIzjTXpWYU=;
        b=UucJmxLrirDTh3Gx1bEVVV3N1ymOafKsFG3cKLi7UGXDKxg+tP4umFOB2tAeXS/Jo8
         CO096xFCAXaeh46uW6F8pb9nT2gWb4rnePK1AE9pqyetup1fNqKcDn73Uk24DUdk1GGz
         8aV/pMOjgArUuOCLDgVFzLHa0Myifwo8Ew+wh8kgyFFA1eXJCZgIDXHwZ2TSyboP6E2H
         DXLOz3RTG2xDpSVA3g/mS33I0O1fIcrSuXNd37LJvQd8JBevELq+ew9S5UbTtUWyssgg
         OwNc6D6vxRR1W6xdScEYmFJ9FNlyprFNlMAfjhaQkmDAE3C2YYlfzTqjEOrTG3sj2gk2
         zyEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgaFEvr5Mi6EMgFltOHO7cLSS5cZTBA+RABx10TxsP1XntkMH2F24cknbH//jYrto3Rtv8z4KWewNCUDs2KsYjxNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx08baFgeyXaV6bOj+3ElGF0IbooSJENwRGGGmO6QgIPAdMkcOd
	epawreCfYap9ChnQliEbfd8JgmDYFqP4tXD/nWmioEkbsvASYgMvnKR8311OJSxqgKal8uISCz5
	nzFh1gKu9ozEsY2AFDGFXAA==
X-Received: from wmoq6.prod.google.com ([2002:a05:600c:46c6:b0:486:fbd8:2af6])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c04a:b0:485:fbd2:f72 with SMTP id 5b1f17b1804b1-4888356610dmr23580735e9.1.1775019139978;
 Tue, 31 Mar 2026 21:52:19 -0700 (PDT)
Date: Wed,  1 Apr 2026 05:50:59 +0100
In-Reply-To: <20260401045100.3394299-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260401045100.3394299-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260401045100.3394299-2-vdonnefort@google.com>
Subject: [PATCH v2 1/2] tracing: Non-consuming read for trace remotes with an
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
index 0d78e5f5fe98..d6c3f94d67cd 100644
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
@@ -361,6 +373,7 @@ static struct trace_remote_iterator
 
 		switch (type) {
 		case TRI_CONSUMING:
+			ring_buffer_poll_remote(remote->trace_buffer, cpu);
 			INIT_DELAYED_WORK(&iter->poll_work, __poll_remote);
 			schedule_delayed_work(&iter->poll_work, msecs_to_jiffies(remote->poll_ms));
 			break;
@@ -476,6 +489,9 @@ __peek_event(struct trace_remote_iterator *iter, int cpu, u64 *ts, unsigned long
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

