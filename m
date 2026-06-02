Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BF63F8ED3
	for <linux-trace-kernel@vger.kernel.org>; Tue,  2 Jun 2026 17:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780420333; cv=none; b=V84XSHneZKulsSlFI6CLsvkALEWGpG0XPBqstIK3Wuev9Lfll2l96975viyoyHr+TwWjaSwMCR0VuBw+P9RUT7GPT87RUMkcfS2sVe6QJDmEZMoxRKdkoQ9ysKthX6t+kR6heyRpp0nQ6Q8h4PDq5ozX+yZN2Z1EHKHTR/qxMgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780420333; c=relaxed/simple;
	bh=w0O/BwBfd+zhz85hhRDljMxV1p7FQanVKSdbKK5qsIc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e0S3hJ7nFiMQsvd9DlFd1afmJa1h7jwhVwR6YS8oxuTmD0xD3dhricM0fUsGDze1efH4dHCuNGKdMcX9qYUfOHZwMQaRntH4WEsq686SORJo6H0LAJt+wd5eOLvJfeNTBpdbQ/Zv61TNM2EBhV5tvv6JcEN0hb3qejO9TvS1OUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=irPJoM4s; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="irPJoM4s"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-4601c9b630fso370052f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 02 Jun 2026 10:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780420329; x=1781025129; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qjcrT227Q9kxjOBfGvPfF0RY7SXJa/LEft0YgWJOiI0=;
        b=irPJoM4slbtyL1XIKR2bLQOgw+osVJmMVbxULdsc7GEoqOrgKKj5K6rNjYTSSXihxg
         aa6NbfIju3evhFsT8TEGa0abh+hwMzmDkpnBlqR2tRHu/VvoqFt3tF9MWavoQaYK2vcW
         HT04qvzOX3KlFEpGc10gWrJkwPNEwHUNXDuNmcWfo8qXGFH3SPmW958J5H90b+XEL+bk
         KrcVz7GdYuRQfKGPVfVFE7YbyAndyF0/pr2ihhsOxWjx8eOAs72nuiDiLtn5SJW5W7cC
         7+wmnIgsWTV7Bmfoh0Dy/cIOYwqYYlFvovmIVE33TqOUDxwEeDufE+7MwHhO5+zTYZy4
         nZ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780420329; x=1781025129;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qjcrT227Q9kxjOBfGvPfF0RY7SXJa/LEft0YgWJOiI0=;
        b=CP2GOYt1bL59SB4/NBISDoDvXqN2yn2aujJXrQbLHh1j6By6ulWPGqeLOik4ovCPly
         Aj255EHKS0R3qgt+Oddtpa5W3w5Cy7lM4TXM3gK1jS2QUYM+ubrv5ppf7Q39XN6Tfphp
         Xm2EHrqIPQ0ZlojEy3IQ0/Za6k4UNwL4fhLMdx1LpFref2H158/c3mEuzNcX9tBA1CMa
         JVzoco0fTzx/3IlYZj2lZok6w7ZcWs8mNPjIeG2ZJb1abgAz3bbK93zy8aeYWki8s64h
         jzHJEUliWou9PRmc2A0QKJJTH/uHE5T3OQYrTIo1lUNtPPzHh5Aep0mHoFFBjwf18ixN
         q+dg==
X-Forwarded-Encrypted: i=1; AFNElJ/YV9HKghHE+YTs+R4Ym+InZltyvTwEgFvpp29JS2AhUd+2+B7Amd1McGS6qishLsyy5/e+AskWRyRnocRHlpGaqW8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6ToHvdXlAf+VLysNM5O7dEOS6O6kAxzFBiUnXTJ2lj5t7X7MS
	rlGBFhxKxrv84Qnxmyw2xemQSv3RMl/4QyjBDlLGjG1XPrXvLrYqZDcZxhStmo8uxHJaD6bTzsQ
	iuDdCWeZrhz4KIFKbSvb61A==
X-Received: from wmsl28.prod.google.com ([2002:a05:600c:1d1c:b0:490:3c15:7144])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4586:b0:490:b26f:a512 with SMTP id 5b1f17b1804b1-490b4ef259dmr12421015e9.0.1780420329229;
 Tue, 02 Jun 2026 10:12:09 -0700 (PDT)
Date: Tue,  2 Jun 2026 18:11:41 +0100
In-Reply-To: <20260602171146.2238998-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602171146.2238998-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260602171146.2238998-10-vdonnefort@google.com>
Subject: [PATCH 09/13] tracing/remotes: Add dump_on_oops tracefs file
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

When enabled, dump_on_oops will dump the content of the trace remote
buffer if the system panics.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index e708dcd7d258..3164f327d4d8 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -7,6 +7,7 @@
 #include <linux/kstrtox.h>
 #include <linux/lockdep.h>
 #include <linux/mutex.h>
+#include <linux/panic_notifier.h>
 #include <linux/tracefs.h>
 #include <linux/trace_remote.h>
 #include <linux/trace_seq.h>
@@ -22,6 +23,7 @@ enum tri_type {
 	TRI_CONSUMING,
 	TRI_NONCONSUMING,
 	TRI_PRINTK,
+	TRI_PANIC,
 };
 
 struct trace_remote_iterator {
@@ -58,6 +60,9 @@ struct trace_remote {
 	unsigned int			poll_ms;
 	struct delayed_work		poll_work;
 	unsigned int			poll_cnt;
+	struct notifier_block		panic_notifier;
+	struct trace_remote_iterator	*panic_iter;
+	bool				panic_on;
 	bool				tracing_on;
 };
 
@@ -66,10 +71,15 @@ static bool trace_remote_loaded(struct trace_remote *remote)
 	return !!remote->trace_buffer;
 }
 
+static void trace_remote_unload(struct trace_remote *remote);
+static int trace_remote_panic_load(struct trace_remote *remote);
+static void trace_remote_panic_unload(struct trace_remote *remote);
+
 static int trace_remote_load(struct trace_remote *remote)
 {
 	struct ring_buffer_remote *rb_remote = &remote->rb_remote;
 	struct trace_buffer_desc *desc;
+	int ret = 0;
 
 	lockdep_assert_held(&remote->lock);
 
@@ -84,15 +94,28 @@ static int trace_remote_load(struct trace_remote *remote)
 	rb_remote->swap_reader_page = remote->cbs->swap_reader_page;
 	rb_remote->priv = remote->priv;
 	rb_remote->reset = remote->cbs->reset;
+	remote->trace_buffer_desc = desc;
 	remote->trace_buffer = ring_buffer_alloc_remote(rb_remote);
 	if (!remote->trace_buffer) {
 		remote->cbs->unload_trace_buffer(desc, remote->priv);
 		return -ENOMEM;
 	}
 
-	remote->trace_buffer_desc = desc;
+	if (remote->panic_on) {
+		ret = trace_remote_panic_load(remote);
+		if (ret)
+			trace_remote_unload(remote);
+	}
 
-	return 0;
+	return ret;
+}
+
+static void trace_remote_unload(struct trace_remote *remote)
+{
+	trace_remote_panic_unload(remote);
+	ring_buffer_free(remote->trace_buffer);
+	remote->trace_buffer = NULL;
+	remote->cbs->unload_trace_buffer(remote->trace_buffer_desc, remote->priv);
 }
 
 static void trace_remote_try_unload(struct trace_remote *remote)
@@ -110,9 +133,7 @@ static void trace_remote_try_unload(struct trace_remote *remote)
 	if (!ring_buffer_empty(remote->trace_buffer))
 		return;
 
-	ring_buffer_free(remote->trace_buffer);
-	remote->trace_buffer = NULL;
-	remote->cbs->unload_trace_buffer(remote->trace_buffer_desc, remote->priv);
+	trace_remote_unload(remote);
 }
 
 static int trace_remote_enable_tracing(struct trace_remote *remote)
@@ -375,58 +396,68 @@ static void trace_remote_dec_poll(struct trace_remote *remote)
 static struct trace_remote_iterator
 *trace_remote_iter(struct trace_remote *remote, int cpu, enum tri_type type)
 {
-	struct trace_remote_iterator *iter = NULL;
+	struct trace_remote_iterator *iter __free(kfree) = kzalloc_obj(*iter);
 	int ret;
 
 	lockdep_assert_held(&remote->lock);
 
-	if (type == TRI_NONCONSUMING && !trace_remote_loaded(remote))
-		return NULL;
+	if (!iter)
+		return ERR_PTR(-ENOMEM);
 
-	ret = trace_remote_get(remote, cpu);
-	if (ret)
-		return ERR_PTR(ret);
+	switch (type) {
+	case TRI_NONCONSUMING:
+		if (!trace_remote_loaded(remote))
+			return NULL;
+		fallthrough;
+	case TRI_CONSUMING:
+	case TRI_PRINTK:
+		ret = trace_remote_get(remote, cpu);
+		if (ret)
+			return ERR_PTR(ret);
+		break;
+	case TRI_PANIC:
+		break;
+	}
 
 	if (!trace_remote_has_cpu(remote, cpu)) {
 		ret = -ENODEV;
 		goto err;
 	}
 
-	iter = kzalloc_obj(*iter);
-	if (iter) {
-		iter->remote = remote;
-		iter->cpu = cpu;
-		iter->type = type;
-		trace_seq_init(&iter->seq);
+	iter->remote = remote;
+	iter->cpu = cpu;
+	iter->type = type;
+	trace_seq_init(&iter->seq);
 
-		switch (type) {
-		case TRI_PRINTK:
-			/* only one printk iter allowed */
-			if (WARN_ON_ONCE(remote->printk)) {
-				ret = -EBUSY;
-				break;
-			}
-			smp_store_release(&remote->printk, iter);
-			fallthrough;
-		case TRI_CONSUMING:
-			trace_remote_inc_poll(remote);
-			break;
-		case TRI_NONCONSUMING:
-			ret = __alloc_ring_buffer_iter(iter, cpu);
-			break;
+	switch (type) {
+	case TRI_PRINTK:
+		/* only one printk iter allowed */
+		if (WARN_ON_ONCE(remote->printk)) {
+			ret = -EBUSY;
+			goto err;
 		}
-
+		smp_store_release(&remote->printk, iter);
+		fallthrough;
+	case TRI_CONSUMING:
+		trace_remote_inc_poll(remote);
+		break;
+	case TRI_PANIC:
+	case TRI_NONCONSUMING:
+		ret = __alloc_ring_buffer_iter(iter, cpu);
 		if (ret)
 			goto err;
-
-		return iter;
+		break;
 	}
-	ret = -ENOMEM;
 
-err:
-	kfree(iter);
-	trace_remote_put(remote);
+	return no_free_ptr(iter);
 
+err:
+	switch (type) {
+	case TRI_PANIC:
+		break;
+	default:
+		trace_remote_put(remote);
+	}
 	return ERR_PTR(ret);
 }
 
@@ -449,14 +480,18 @@ static void trace_remote_iter_free(struct trace_remote_iterator *iter)
 		fallthrough;
 	case TRI_CONSUMING:
 		trace_remote_dec_poll(remote);
+		trace_remote_put(remote);
 		break;
 	case TRI_NONCONSUMING:
+		trace_remote_put(remote);
+		__free_ring_buffer_iter(iter, iter->cpu);
+		break;
+	case TRI_PANIC:
 		__free_ring_buffer_iter(iter, iter->cpu);
 		break;
 	}
 
 	kfree(iter);
-	trace_remote_put(remote);
 }
 
 static void trace_remote_iter_read_start(struct trace_remote_iterator *iter)
@@ -527,6 +562,7 @@ __peek_event(struct trace_remote_iterator *iter, int cpu, u64 *ts, unsigned long
 	case TRI_PRINTK:
 	case TRI_CONSUMING:
 		return ring_buffer_peek(iter->remote->trace_buffer, cpu, ts, lost_events);
+	case TRI_PANIC:
 	case TRI_NONCONSUMING:
 		rb_iter = __get_rb_iter(iter, cpu);
 		if (!rb_iter)
@@ -596,6 +632,7 @@ static void trace_remote_iter_move(struct trace_remote_iterator *iter)
 	case TRI_CONSUMING:
 		ring_buffer_consume(trace_buffer, iter->evt_cpu, NULL, NULL);
 		break;
+	case TRI_PANIC:
 	case TRI_NONCONSUMING:
 		ring_buffer_iter_advance(__get_rb_iter(iter, iter->evt_cpu));
 		break;
@@ -910,6 +947,116 @@ static int printk_show(struct seq_file *s, void *unused)
 }
 DEFINE_SHOW_STORE_ATTRIBUTE(printk);
 
+static int trace_remote_panic_handler(struct notifier_block *self, unsigned long ev, void *v)
+{
+	struct trace_remote *remote = container_of(self, struct trace_remote, panic_notifier);
+	struct trace_remote_iterator *iter = smp_load_acquire(&remote->panic_iter);
+	int cpu;
+
+	if (!iter) {
+		pr_warn("Unexpected error: no panic iterator for the trace remote\n");
+		return NOTIFY_DONE;
+	}
+
+	for_each_possible_cpu(cpu) {
+		if (iter->rb_iters[cpu]) {
+			/* No RING_BUFFER_ALL_CPUS to avoid taking cpu_read_lock() */
+			ring_buffer_read_remote_meta_page(remote->trace_buffer, cpu);
+			ring_buffer_iter_reset(iter->rb_iters[cpu]);
+		}
+	}
+
+	while (trace_remote_iter_read_event(iter)) {
+		trace_seq_init(&iter->seq);
+
+		trace_remote_iter_print_event(iter);
+		pr_emerg("%s", iter->seq.buffer);
+
+		trace_remote_iter_move(iter);
+	}
+
+	return NOTIFY_DONE;
+}
+
+static int trace_remote_panic_load(struct trace_remote *remote)
+{
+	struct notifier_block *notifier = &remote->panic_notifier;
+	struct trace_remote_iterator *iter;
+
+	lockdep_assert_held(&remote->lock);
+
+	if (remote->panic_iter)
+		return 0;
+
+	iter = trace_remote_iter(remote, RING_BUFFER_ALL_CPUS, TRI_PANIC);
+	if (IS_ERR(iter))
+		return PTR_ERR(iter);
+
+	smp_store_release(&remote->panic_iter, iter);
+
+	notifier->notifier_call = trace_remote_panic_handler;
+	notifier->priority = INT_MAX - 1;
+	atomic_notifier_chain_register(&panic_notifier_list, notifier);
+
+	return 0;
+}
+
+static void trace_remote_panic_unload(struct trace_remote *remote)
+{
+	struct trace_remote_iterator *iter = remote->panic_iter;
+
+	lockdep_assert_held(&remote->lock);
+
+	if (!iter)
+		return;
+
+	atomic_notifier_chain_unregister(&panic_notifier_list, &remote->panic_notifier);
+	smp_store_release(&remote->panic_iter, NULL);
+	trace_remote_iter_free(iter);
+}
+
+static ssize_t dump_on_oops_write(struct file *filp, const char __user *ubuf,
+				  size_t cnt, loff_t *ppos)
+{
+	struct seq_file *seq = filp->private_data;
+	struct trace_remote *remote = seq->private;
+	bool enable;
+	int ret;
+
+	ret = kstrtobool_from_user(ubuf, cnt, &enable);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&remote->lock);
+
+	if (enable == remote->panic_on)
+		return cnt;
+
+	if (trace_remote_loaded(remote)) {
+		if (enable) {
+			ret = trace_remote_panic_load(remote);
+			if (ret)
+				return ret;
+		} else {
+			trace_remote_panic_unload(remote);
+		}
+	}
+
+	remote->panic_on = enable;
+
+	return cnt;
+}
+
+static int dump_on_oops_show(struct seq_file *s, void *unused)
+{
+	struct trace_remote *remote = s->private;
+
+	seq_printf(s, "%d\n", remote->panic_on);
+
+	return 0;
+}
+DEFINE_SHOW_STORE_ATTRIBUTE(dump_on_oops);
+
 static struct dentry *tracefs_root;
 static DEFINE_MUTEX(tracefs_lock);
 static u64 tracefs_root_count;
@@ -941,6 +1088,11 @@ static int trace_remote_init_tracefs(const char *name, struct trace_remote *remo
 	if (!d)
 		goto err;
 
+	d = trace_create_file("dump_on_oops", TRACEFS_MODE_WRITE, remote_d, remote,
+			      &dump_on_oops_fops);
+	if (!d)
+		goto err;
+
 	d = trace_create_file("buffer_size_kb", TRACEFS_MODE_WRITE, remote_d, remote,
 			      &buffer_size_kb_fops);
 	if (!d)
-- 
2.54.0.1032.g2f8565e1d1-goog

