Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DB838A706
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 16:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786551232; cv=none; b=rf6V83mO9MvegZFiB8PAvMlN7pRq1R90njxdAOVmTEUUhze3LZsx9PXDGm2d1AkkzUqO8jJ8tScS0By1OP16fZ/w2K/gvMEmH36lFS/9WsatiTDTDvyXkjRepC2LgoxvQy/e0WSEpdCKSQbnIP5seeb92/X+7O9hzQcexaGU3r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786551232; c=relaxed/simple;
	bh=L+2QAEBkvpfMfvv4BJuh81OLAo05SjYcg1Y1ztPK6nI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bpQzjE5faDH7632QqNDbia+Bt92v4JP+z8BGT8Eb+NAh8l9FmQ/PyfromJJZXzy1QVEbm73KqQUhOKyv4t6VUvcOLQ01ZfJp51dg2FW4eVOAW2UKEsE/3+18H5CwU+C3RLsjkdsaAW/0SJHI6xYCzoxYf75lB8fHsPoQiVPxAEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PZsQgIK4; arc=none smtp.client-ip=209.85.128.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PZsQgIK4"
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4954dcd6131so10827025e9.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 09:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786551229; x=1787156029; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jQSXH8itKYe9e/GgW7Re1BlgNqyiuWl+Ci4z3wFYfrI=;
        b=PZsQgIK43T64sSQK6XC9K8DAeqV22OP0V05rDTLXEcapjqQNXbGYemZ0n2to57S0Ks
         4xXTvX5wRlPotA9akY3AiATU9cZz0PUZl8LKtNib1fEE4oY2gxGm9ipH3kI4MWbM+05q
         Qr7/oAylhudVGRKgTlHKsH0PyDEqW+5dYvrsCWg3e64ItTqh0cE2X+qm17i6JT/XqisZ
         //VG2BhdGDjsS3RwlW36lWEYdkefW88zqCIDyWbXWUJCvbl23O1fEQU4R/BXNqmxXviU
         qZLR4svGbGGLfuOb6WrNN9/ku3TstG50b8346UbXwwW699QUT/86F8sAfQPSUwDqZsp6
         pi0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786551229; x=1787156029;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jQSXH8itKYe9e/GgW7Re1BlgNqyiuWl+Ci4z3wFYfrI=;
        b=cQTJPn4j8ZO3ugJ4Y8Epa/i+t2zCtWYvpMqJYjx/JOz9NcMLJbn4bPPB5MW+sAvsJj
         QkhKLTCZvV6h1AR1oy695uzHpuTMP3+7EtfiXXDTEmhKMH3zLJlDRN9WBEEoIjRTmTK3
         iNy8Xuw5Nw399ls+XeNUOVEgdRdzW1ciI8EIADcLQLBO2MZOEzyeNTfMohlCug/CjxWE
         QAo7NcfgnGjL+SlzvX4C9ncfUu2eFle6RvmwFdqJH65vfNiLE1f/XyxLWlaBnEahYhtV
         sjCZmcXOPJVX4L3zk5STai5eHSJ0Gyhzz7/8dBrodEUdOwoOcztdx+NAtOkTdpYVkI5U
         Dm0A==
X-Forwarded-Encrypted: i=1; AHgh+RqG9iqOBLbQyoSHWUrNP/2PeMns6aFQNQMonZp1aKZPJTpWZvAPs6DsL9JhFV3AkizV0+mbxLbu4BuuEmacRxOdwlY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF3cN/I+H1yPN4wHPQez43a+vXaGUugEqFfw7ZV7OF/Qt0rUNh
	AuhO2g4snmu1e5v0CFSqnWO12Fgr04L6JHaWnF2a8OeFELLk3zib+SiIY6GYlwtmi46b9Dgza/W
	+7DoqbxS6w3TCKA5j/3798w==
X-Received: from wmbc22.prod.google.com ([2002:a7b:c016:0:b0:495:5bab:557])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:620f:b0:499:7aa8:bd09 with SMTP id 5b1f17b1804b1-4997c0fecd5mr93632035e9.4.1786551229050;
 Wed, 12 Aug 2026 09:13:49 -0700 (PDT)
Date: Wed, 12 Aug 2026 17:13:26 +0100
In-Reply-To: <20260812161340.2417322-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260812161340.2417322-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260812161340.2417322-5-vdonnefort@google.com>
Subject: [PATCH v5 04/18] tracing/remotes: Use a single per-remote polling work
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Having a per-iterator polling work is wasteful when logging several
trace_remote per_cpu/trace_pipe files in parallel. This results in one
work running per-CPU, where only one would suffice.

Transition to a single per-remote polling work, scheduled on the first
consumer creation and stopped when the last consuming iterator is freed.

This blanket polls all CPUs, regardless of which ones are actually being
read. This is acceptable because the poll consists of reading the
meta-page, which is a fast operation. Also, it is more common to log all
CPUs in the system than only one, so this use-case should be favoured.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index 0e4d41a93a7c..1fbe2f3f20e9 100644
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
@@ -55,8 +54,10 @@ struct trace_remote {
 	struct rw_semaphore		reader_lock;
 	struct rw_semaphore		*pcpu_reader_locks;
 	unsigned int			nr_readers;
+	unsigned int			poll_cnt;
 	unsigned int			poll_ms;
 	bool				tracing_on;
+	struct delayed_work		poll_work;
 };
 
 static DEFINE_MUTEX(trace_remotes_lock);
@@ -350,17 +351,6 @@ static bool trace_remote_has_cpu(struct trace_remote *remote, int cpu)
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
@@ -404,6 +394,36 @@ static int __alloc_ring_buffer_iter(struct trace_remote_iterator *iter, int cpu)
 	return 0;
 }
 
+static void trace_remote_do_poll(struct trace_remote *remote)
+{
+	ring_buffer_poll_remote(remote->trace_buffer, RING_BUFFER_ALL_CPUS);
+	schedule_delayed_work(&remote->poll_work, msecs_to_jiffies(remote->poll_ms));
+}
+
+static void __poll_remote(struct work_struct *work)
+{
+	struct delayed_work *dwork = to_delayed_work(work);
+
+	trace_remote_do_poll(container_of(dwork, struct trace_remote, poll_work));
+}
+
+static void trace_remote_inc_poll(struct trace_remote *remote)
+{
+	/* poll_cnt <= nr_readers, inherits its overflow protection */
+	if (!remote->poll_cnt++)
+		trace_remote_do_poll(remote);
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
@@ -433,9 +453,7 @@ static struct trace_remote_iterator
 
 		switch (type) {
 		case TRI_CONSUMING:
-			ring_buffer_poll_remote(remote->trace_buffer, cpu);
-			INIT_DELAYED_WORK(&iter->poll_work, __poll_remote);
-			schedule_delayed_work(&iter->poll_work, msecs_to_jiffies(remote->poll_ms));
+			trace_remote_inc_poll(remote);
 			break;
 		case TRI_NONCONSUMING:
 			ret = __alloc_ring_buffer_iter(iter, cpu);
@@ -469,7 +487,7 @@ static void trace_remote_iter_free(struct trace_remote_iterator *iter)
 
 	switch (iter->type) {
 	case TRI_CONSUMING:
-		cancel_delayed_work_sync(&iter->poll_work);
+		trace_remote_dec_poll(remote);
 		break;
 	case TRI_NONCONSUMING:
 		__free_ring_buffer_iter(iter, iter->cpu);
@@ -1002,6 +1020,7 @@ int trace_remote_register(const char *name, struct trace_remote_callbacks *cbs,
 	remote->poll_ms = 100;
 	mutex_init(&remote->lock);
 	init_rwsem(&remote->reader_lock);
+	INIT_DELAYED_WORK(&remote->poll_work, __poll_remote);
 
 	guard(mutex)(&trace_remotes_lock);
 
-- 
2.55.0.691.gc56d675ccc-goog

