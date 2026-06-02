Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398203F65FF
	for <linux-trace-kernel@vger.kernel.org>; Tue,  2 Jun 2026 17:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780420325; cv=none; b=metyww8UyObYOeKO2obb6oRc8qShuPX5nD3PzHFexdRD+K3PWYeIkbYIE7+wXpNWS/Ylmt9C1XQ3Tcx2/6TK/QBk0kmKHIeJ2rUABiI+AZ0o7zbCswI7bOqI5hUt9NWmfEQrnAwZAw1D0g8hVQSXZS2XIvndfd5CqhDJLG5gjyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780420325; c=relaxed/simple;
	bh=sokXI5igoUZq0/GG1AoM5WKsPPMzCVLcQxr8SwcHT2k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RMiPsFUlILqYNiWgu7lDBq/haOYsH8eCgsIZrvRy4kyys1/K9zWr1P+0XJ/wMNNAWZLluwB4kovu7Lyamu2hcNNbzRkW817raDWp9ny/zQGJuU2KgSQqo8Z7ezlOJ3W9ZDkgtDhIzSrBQkxs5NjBnbm7w08sbcBg0u1AKoe7+M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HLfTKr7j; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HLfTKr7j"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-bee29ce0889so143010266b.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 02 Jun 2026 10:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780420322; x=1781025122; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vOYklYF8+bLVV5ny0x1fefVdr0u62wJP9Va7BR9mPR4=;
        b=HLfTKr7jTVgPM2wWIzmPv+SmQnVta2JZPf3oAwf2oW098pOdJ1/EO+4RUcl+b016rt
         nH8Wmmlgw3R+JhkkEoGEsWdOAzOMpjQh5HYmhYIPGNtawJpru3khrFz9AQWpBDCGeiop
         dJ4pIUSfXptM3LLtlzCYBJdKAOpjouyXdoko/FsbG6dk/de5k3Xmfgyve0y6dxsvYdMO
         dspBBkdaJ9B1p4H0lP3Xj/k/15JSfnGsnkh9j2/wg66/XgjPTOuOKNL0zpzbyNbaqrwX
         sK3k3+Lj+vL40uDvE5EdnFsKCCVjselccllHpX6I1hQQd4wU7oW76u9xGg1ARPvyltDu
         0CRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780420322; x=1781025122;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vOYklYF8+bLVV5ny0x1fefVdr0u62wJP9Va7BR9mPR4=;
        b=bjhsGKpjTQyAiQ4uhoYvfJpuCUdQVMhXPnkaaNDxhaFsMLutcWUQZWnKBjwcQx9TEe
         vGufK4vEwkkxv2h6bBUPZ17ehVmPcYrtRS227rXKpQz3RQmCCaKAG3SfcLzArIZkyh0v
         BcJv1lKrM7gN5/r3y6iEXIBSiBiDymJOB//ABm3BPUrj875KElFzeb1AENyZKXTPk6Xy
         nJJ1mwRaDHcivIcFLIPXygq4h7k9hfHEXeIywKcm6qHG87ml0CoJKqm39Cst8Yf5qtiV
         CZkdJAO3iJCkYIq2lsxg2Wm2yqf1i0WQrWKafnDAPQLrIYaSIRnSFETrMwp/5jE5SE67
         tJ3Q==
X-Forwarded-Encrypted: i=1; AFNElJ9hL8Mueg0ofByOHtbF04waMGiQ/v2hA1jrYVG0SFh+DTHMSHdV2w3xGybrV+yI6uM1ostTNNv2PT4YUCEYW/puYcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWvxxW6C29O47EyT58ZoU9zQDSDkzSeAo1LqYkbeoCWMP8Rz1Y
	gtgmi0xPSiIyCPw4MsqGswLIV8Hk4fOOQ8yJbOIfoLkkbkn1fM4Qu74Kf/ZVMSq7g1OoIfbypju
	v/SBhYtdlyFR6VK61zHMR2w==
X-Received: from ejcqk6.prod.google.com ([2002:a17:907:7f86:b0:beb:8218:89b1])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:c0c:b0:beb:cc42:eaad with SMTP id a640c23a62f3a-bf05d6d92famr30178366b.5.1780420322367;
 Tue, 02 Jun 2026 10:12:02 -0700 (PDT)
Date: Tue,  2 Jun 2026 18:11:35 +0100
In-Reply-To: <20260602171146.2238998-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602171146.2238998-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260602171146.2238998-4-vdonnefort@google.com>
Subject: [PATCH 03/13] tracing/remotes: Use a single per-remote polling work
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Having a per-iterator polling work is wasteful when logging several
trace_remote per_cpu/trace_pipe files in parallel. This result in one
work running per-CPU, where only one would suffice.

Transition to a single per-remote polling work, scheduled on the first
consumer creation and stopped when the last consuming iterator is freed.

This blanket polls all CPUs, regardless of which ones are actually being
read. This is acceptable because the poll consists of reading the
meta-page, which is a fast operation. Also, it is more common to log all
CPUs in the system than only one, so this use-case should be favoured.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index 7fed18f28fa7..21583fae1bd9 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -26,7 +26,6 @@ enum tri_type {
 struct trace_remote_iterator {
 	struct trace_remote		*remote;
 	struct trace_seq		seq;
-	struct delayed_work		poll_work;
 	unsigned long			lost_events;
 	u64				ts;
 	struct ring_buffer_iter		*rb_iter;
@@ -55,6 +54,8 @@ struct trace_remote {
 	struct rw_semaphore		*pcpu_reader_locks;
 	unsigned int			nr_readers;
 	unsigned int			poll_ms;
+	struct delayed_work		poll_work;
+	unsigned int			poll_cnt;
 	bool				tracing_on;
 };
 
@@ -291,17 +292,6 @@ static bool trace_remote_has_cpu(struct trace_remote *remote, int cpu)
 	return ring_buffer_poll_remote(remote->trace_buffer, cpu) == 0;
 }
 
-static void __poll_remote(struct work_struct *work)
-{
-	struct delayed_work *dwork = to_delayed_work(work);
-	struct trace_remote_iterator *iter;
-
-	iter = container_of(dwork, struct trace_remote_iterator, poll_work);
-	ring_buffer_poll_remote(iter->remote->trace_buffer, iter->cpu);
-	schedule_delayed_work((struct delayed_work *)work,
-			      msecs_to_jiffies(iter->remote->poll_ms));
-}
-
 static void __free_ring_buffer_iter(struct trace_remote_iterator *iter, int cpu)
 {
 	if (cpu != RING_BUFFER_ALL_CPUS) {
@@ -345,6 +335,36 @@ static int __alloc_ring_buffer_iter(struct trace_remote_iterator *iter, int cpu)
 	return 0;
 }
 
+static void __poll_remote(struct work_struct *work)
+{
+	struct delayed_work *dwork = to_delayed_work(work);
+	struct trace_remote *remote;
+
+	remote = container_of(dwork, struct trace_remote, poll_work);
+	ring_buffer_poll_remote(remote->trace_buffer, RING_BUFFER_ALL_CPUS);
+
+	schedule_delayed_work(dwork, msecs_to_jiffies(remote->poll_ms));
+}
+
+static void trace_remote_inc_poll(struct trace_remote *remote)
+{
+	/* poll_cnt <= nr_readers, inherits its overflow protection */
+	if (!remote->poll_cnt++) {
+		ring_buffer_poll_remote(remote->trace_buffer, RING_BUFFER_ALL_CPUS);
+		schedule_delayed_work(&remote->poll_work, msecs_to_jiffies(remote->poll_ms));
+	}
+}
+
+static void trace_remote_dec_poll(struct trace_remote *remote)
+{
+	if (WARN_ON_ONCE(!remote->poll_cnt))
+		return;
+
+	remote->poll_cnt--;
+	if (!remote->poll_cnt)
+		cancel_delayed_work_sync(&remote->poll_work);
+}
+
 static struct trace_remote_iterator
 *trace_remote_iter(struct trace_remote *remote, int cpu, enum tri_type type)
 {
@@ -374,9 +394,7 @@ static struct trace_remote_iterator
 
 		switch (type) {
 		case TRI_CONSUMING:
-			ring_buffer_poll_remote(remote->trace_buffer, cpu);
-			INIT_DELAYED_WORK(&iter->poll_work, __poll_remote);
-			schedule_delayed_work(&iter->poll_work, msecs_to_jiffies(remote->poll_ms));
+			trace_remote_inc_poll(remote);
 			break;
 		case TRI_NONCONSUMING:
 			ret = __alloc_ring_buffer_iter(iter, cpu);
@@ -410,7 +428,7 @@ static void trace_remote_iter_free(struct trace_remote_iterator *iter)
 
 	switch (iter->type) {
 	case TRI_CONSUMING:
-		cancel_delayed_work_sync(&iter->poll_work);
+		trace_remote_dec_poll(remote);
 		break;
 	case TRI_NONCONSUMING:
 		__free_ring_buffer_iter(iter, iter->cpu);
@@ -939,6 +957,7 @@ int trace_remote_register(const char *name, struct trace_remote_callbacks *cbs,
 	remote->poll_ms = 100;
 	mutex_init(&remote->lock);
 	init_rwsem(&remote->reader_lock);
+	INIT_DELAYED_WORK(&remote->poll_work, __poll_remote);
 
 	ret = trace_remote_init_tracefs(name, remote);
 	if (ret)
-- 
2.54.0.1032.g2f8565e1d1-goog

