Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E7E4A0132
	for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 14:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790261926; cv=none; b=VOyFTOpGrybkbz/NfLVRA90B3XikAa2wblLVBt2YPUpseC2kz+0YVXNrmkpe0DM2d9nZ09iJ084bssMhj0YE5znrNjKv4K0fFtQj4Hw5NOeAsOAHaYNitc4amBVt/K0ObPAWb1VjHzB1+AN+HJOyKmUF8YTlUk4mDDjF+ufE/Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790261926; c=relaxed/simple;
	bh=AKWz0iw5jfF2tGwtx6OioIU2neT19g0ybB86g2N45Yg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tq2/8BKQZso9oUcJAL1sY+539XpPVhD6+/51LLXlYIMEfX/pU+u7GlOnN5P7fet8oxrHUYQvqxvPCHfmaGbdLQ9GRTp0k0L2OrHfFsEbttR4YAxEL31eT+ScoTTR0p0BVqDIuNwmkPwfHibM9PDteLsHar40Xq3t3MKH+9wDFy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YMFLRHEB; arc=none smtp.client-ip=209.85.128.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YMFLRHEB"
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49e65f2f1baso20658825e9.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 07:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790261921; x=1790866721; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3tlGds+/Whf8GVsVT0m3lg/Uwm9Llopn7YWRo47lBI0=;
        b=YMFLRHEBxcSUD/5Rp18nnIU0vSXuMfOb2NXMaUXdZoCdVFk/Onn230ZrJpP9yUfsqI
         N3ASvnvtOVnXPfGi+VZtdEneflThUbm3FG8IrhWFLxA2ZXfC6+TSsdLscsGREgVhBrmQ
         8xU08Eh8zIakPdqHLrfBqUNE83tNStAuuNyv+OPIzv8VOhlgb0KEDT7Q4KQ5a761/AX4
         x6CN6+r4EVIgyECLuGK5oVlLc9tI1kQ3XkB2MLgqyYWRvQpZCNmNLjxVIxOdd52iAIbh
         CqqpBOFpLNxrJUHnn75NcdRhgR6ktsocxe4YOlK+Wpey07V4VgJshPUH5HXlyqAdG3bM
         NY6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790261921; x=1790866721;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3tlGds+/Whf8GVsVT0m3lg/Uwm9Llopn7YWRo47lBI0=;
        b=dNp/H6Y7D3uY1ROhC60nGeUvAOTCRYecZ7UVn7U1CdjkuIp4G8h8/XRxq+JCTPKyqH
         3+aHL/DWYSa9lZeBglurLoimhjEpxowpuo+2PpaLRxS+tCEjnabZkKbjOJrGOzKG2b3c
         P647s+sdcUSYXAkt/C1NZVZN3rWEGWzMr1qmW+wi8higr07D3/mw7pQBHp4n8IsJcVTq
         dQs74+JZPTdD9m/t+6sD3cMEFW80j2JVCFXdzv6Xy6drMeZXVB4ASfEMMHICHwc1w8I5
         CBT73ob2nl6q3kzdfh0LkCMJpYZV/9lOzB0bAblY4dXtZsMNMMpBIr2G4culOg4lWOkt
         5ohw==
X-Forwarded-Encrypted: i=1; AKwUvBxZLOAqjDu7L8xRZ04rfoOP2PBr6twcSqoNaTOwh1aCvbmaPpkHIQot/B9rEBeEeDHp9r7CYmrKn/T2bhYwZ9V1sMs=@vger.kernel.org
X-Gm-Message-State: AFuF++kdxs0TVE1m1Z4yksXV7AYdWnCJBZ7KtrCpZ0nP32XRm8nojWsG
	2bA7FPSBjIXNxEJfUlW38RPTGtVlIb4du2fE2BUD4dJfxGJX1yJKYQ817Di7UVfIt5wfiPcyQdo
	qBQCtCS5+1Yd3+ExncMYN9g==
X-Received: from wmpc40.prod.google.com ([2002:a05:600c:4a28:b0:49f:e371:2ada])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:19d3:b0:49e:6777:da79 with SMTP id 5b1f17b1804b1-49fe66fb4a7mr44847125e9.26.1790261920560;
 Thu, 24 Sep 2026 07:58:40 -0700 (PDT)
Date: Thu, 24 Sep 2026 15:57:49 +0100
In-Reply-To: <20260924145754.1285146-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924145754.1285146-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260924145754.1285146-16-vdonnefort@google.com>
Subject: [PATCH v7 15/20] tracing/remotes: Add dump_on_panic tracefs file
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

When enabled, dump_on_panic will dump the content of the trace remote
buffer if the system panics.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 kernel/trace/trace_remote.c | 233 +++++++++++++++++++++++++++++-------
 1 file changed, 193 insertions(+), 40 deletions(-)

diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index ea0fc347dff8..0a360690b174 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -7,6 +7,8 @@
 #include <linux/kstrtox.h>
 #include <linux/lockdep.h>
 #include <linux/mutex.h>
+#include <linux/nmi.h>
+#include <linux/panic_notifier.h>
 #include <linux/tracefs.h>
 #include <linux/trace_remote.h>
 #include <linux/trace_seq.h>
@@ -22,6 +24,7 @@ enum tri_type {
 	TRI_CONSUMING,
 	TRI_NONCONSUMING,
 	TRI_DMESG,
+	TRI_PANIC,
 };
 
 struct trace_remote_iterator {
@@ -59,6 +62,9 @@ struct trace_remote {
 	unsigned int			poll_cnt;
 	unsigned int			poll_ms;
 	bool				tracing_on;
+	bool				panic_on;
+	struct notifier_block		panic_notifier;
+	struct trace_remote_iterator	*panic_iter;
 	struct delayed_work		poll_work;
 };
 
@@ -71,10 +77,15 @@ static bool trace_remote_loaded(struct trace_remote *remote)
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
 
@@ -89,15 +100,28 @@ static int trace_remote_load(struct trace_remote *remote)
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
@@ -115,9 +139,7 @@ static void trace_remote_try_unload(struct trace_remote *remote)
 	if (!ring_buffer_empty(remote->trace_buffer))
 		return;
 
-	ring_buffer_free(remote->trace_buffer);
-	remote->trace_buffer = NULL;
-	remote->cbs->unload_trace_buffer(remote->trace_buffer_desc, remote->priv);
+	trace_remote_unload(remote);
 }
 
 static int trace_remote_enable_tracing(struct trace_remote *remote)
@@ -435,58 +457,68 @@ static void trace_remote_dec_poll(struct trace_remote *remote)
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
+	case TRI_DMESG:
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
-		case TRI_DMESG:
-			/* only one dmesg iter allowed */
-			if (WARN_ON_ONCE(remote->dmesg)) {
-				ret = -EBUSY;
-				break;
-			}
-			smp_store_release(&remote->dmesg, iter);
-			fallthrough;
-		case TRI_CONSUMING:
-			trace_remote_inc_poll(remote);
-			break;
-		case TRI_NONCONSUMING:
-			ret = __alloc_ring_buffer_iter(iter, cpu);
-			break;
+	switch (type) {
+	case TRI_DMESG:
+		/* only one dmesg iter allowed */
+		if (WARN_ON_ONCE(remote->dmesg)) {
+			ret = -EBUSY;
+			goto err;
 		}
-
+		smp_store_release(&remote->dmesg, iter);
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
+
+	return no_free_ptr(iter);
 
 err:
-	kfree(iter);
-	trace_remote_put(remote);
-
+	switch (type) {
+	case TRI_PANIC:
+		break;
+	default:
+		trace_remote_put(remote);
+	}
 	return ERR_PTR(ret);
 }
 
@@ -509,14 +541,18 @@ static void trace_remote_iter_free(struct trace_remote_iterator *iter)
 		fallthrough;
 	case TRI_CONSUMING:
 		trace_remote_dec_poll(remote);
+		trace_remote_put(remote);
 		break;
 	case TRI_NONCONSUMING:
+		__free_ring_buffer_iter(iter, iter->cpu);
+		trace_remote_put(remote);
+		break;
+	case TRI_PANIC:
 		__free_ring_buffer_iter(iter, iter->cpu);
 		break;
 	}
 
 	kfree(iter);
-	trace_remote_put(remote);
 }
 
 static bool trace_remote_iter_is_consuming(struct trace_remote_iterator *iter)
@@ -990,6 +1026,118 @@ static int dmesg_show(struct seq_file *s, void *unused)
 }
 DEFINE_TRACE_REMOTE_ATTRIBUTE(dmesg);
 
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
+		trace_seq_putc(&iter->seq, 0);
+		pr_emerg("%s", seq_buf_str(&iter->seq.seq));
+
+		trace_remote_iter_move(iter);
+		touch_nmi_watchdog();
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
+static ssize_t dump_on_panic_write(struct file *filp, const char __user *ubuf,
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
+	WRITE_ONCE(remote->panic_on, enable);
+
+	return cnt;
+}
+
+static int dump_on_panic_show(struct seq_file *s, void *unused)
+{
+	struct trace_remote *remote = s->private;
+
+	seq_printf(s, "%d\n", READ_ONCE(remote->panic_on));
+
+	return 0;
+}
+DEFINE_TRACE_REMOTE_ATTRIBUTE(dump_on_panic);
+
 static int trace_remote_init_tracefs(const char *name, struct trace_remote *remote)
 {
 	struct dentry *remote_d, *percpu_d, *d;
@@ -1017,6 +1165,11 @@ static int trace_remote_init_tracefs(const char *name, struct trace_remote *remo
 	if (!d)
 		goto err;
 
+	d = trace_create_file("dump_on_panic", TRACEFS_MODE_WRITE, remote_d, remote,
+			      &dump_on_panic_fops);
+	if (!d)
+		goto err;
+
 	d = trace_create_file("buffer_size_kb", TRACEFS_MODE_WRITE, remote_d, remote,
 			      &buffer_size_kb_fops);
 	if (!d)
-- 
2.56.0.rc1.310.g51773c2048-goog

