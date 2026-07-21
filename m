Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DF94D98EC
	for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Jul 2026 10:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784630199; cv=none; b=K1sGQmF/ozdq1sUeA89vjLlKEVy9NfYYGwX8P8cj7PdAmxURylp6ypzwEY64g24niyC75Lxwn+cqdF1NE/urxoJYLAjX6cvU/EIH21Z0Ad+gcAHJyjmucNvwwXXpreDghJgM+S6j7ntek5jTdgnU464J3MfEcFdYmkJUa7kj2js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784630199; c=relaxed/simple;
	bh=Fan5FTU4jYdoLRWMesIGBSEQp/zGnPMUSQq1Ge39Ozc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Fc37IPxKb6Q40wVh9z7sIP6T2iguNjNY1mu0rY6PQwOvgVKE5XR2UwdM26yAFJkQgba2OUFWjonSgQrPd08nAiXNCtcnpEmhNCXBbNjdl2RZqVje1gzJgQPsN64v/rAfR4zQ1GrX8BvO7ZXO1eP5mpDH9Y/XY1/GuSV/ObYYj+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rb+vfZ5y; arc=none smtp.client-ip=209.85.208.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rb+vfZ5y"
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-698c15b962cso12858718a12.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Jul 2026 03:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784630195; x=1785234995; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0bopLUrNIsC9pEuzZv5r6f9BYMOaLCmrUeDgdml3/C4=;
        b=rb+vfZ5y5VmPKZ2ITYW9/rz8y1wk6ZbDH/PQa1aBMsnC18WU2xY4WSLdV/2+AnHe3l
         W/HFfGNbL6Ylu+a2EvS7zIjDgd6i6b/qbLoROHVR+feKGH4dYxdF6Z7LUl/yCTypEYZm
         zhCRtRfoJX4Nv1mBiSh1Tnx7nGWwXU49SJ98UG/1EtVfCE5GXQOMrg0zEZIb1r5fILG9
         aVgOHZyS4UB9FuRNs3AkvgkCH3dBZdMFO/lJMiBBVIkUCsTj2yDW4YbFkvWRKcTkkxOi
         +Du01+0zseaUygEx55jVeyFP4EPWQG6N3N0n+AZBOMg5MMbgm+Sk3ueM7rVZYN7Qvs6X
         KYYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784630195; x=1785234995;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0bopLUrNIsC9pEuzZv5r6f9BYMOaLCmrUeDgdml3/C4=;
        b=bsViHayLRYBXzT7rRE8rVfZp2FZ/u/52uZCJ+GgWwq2EY5BOexfZZD+fOrhxeolCW/
         p11XSgz4SS/aecJYv3/z83uj4VY4G5pgGGJJ00TQbPbnlojPQZYjOhAnI4rf9MxO7z8S
         NBgoKRPGh3rbYOl3LOMl5qJ9+20MOsefG2nbSFk69Jmog2J6r5mwgnBlC3t7qT1IQFvH
         R+yS6zc23FWpsYBru0y98a52F+f9EZEsCwCumZphl2LRYW8FW75zj//0Bt77AYv80JPD
         hU4PL1lMqQYgMobiZMw+kKuBh4fNLv9dTF+53cuVXHuXniShgkEHhnBskv4np2KR8nc4
         y5MQ==
X-Forwarded-Encrypted: i=1; AHgh+RoQGY5nrlo+4KRmkBsNWessAOq+zYTUEp/t1hyN8xLrcZhkr0cTohB4oXpEgSr4IFvqP4Ut6k3K+pxvoZ4omFc8OPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrabDmYanIlpZIljUN+7K8qubKWEn47+JHGSmLil9OZ71xT6S+
	8HCLsyD7y+aCfbiG5x/xLPI8r5olnj5C9pU46kdcih7hs9Z9AzjkgwaDywk4fYShuXS0F3CK77X
	UzndmnjBw1UKCbdUcLupaXQ==
X-Received: from ejba2.prod.google.com ([2002:a17:906:2442:b0:c15:b9c2:7e58])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:ea7:b0:c16:7c0:21f6 with SMTP id a640c23a62f3a-c16b47c7148mr801416766b.38.1784630195080;
 Tue, 21 Jul 2026 03:36:35 -0700 (PDT)
Date: Tue, 21 Jul 2026 11:35:58 +0100
In-Reply-To: <20260721103603.342266-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260721103603.342266-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260721103603.342266-14-vdonnefort@google.com>
Subject: [PATCH v3 13/18] tracing/remotes: Add dump_on_panic tracefs file
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

When enabled, dump_on_panic will dump the content of the trace remote
buffer if the system panics.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index fcd2dd754f6e..d109b2503db9 100644
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
 	TRI_DMESG,
+	TRI_PANIC,
 };
 
 struct trace_remote_iterator {
@@ -59,6 +61,9 @@ struct trace_remote {
 	unsigned int			poll_cnt;
 	unsigned int			poll_ms;
 	bool				tracing_on;
+	bool				panic_on;
+	struct notifier_block		panic_notifier;
+	struct trace_remote_iterator	*panic_iter;
 	struct delayed_work		poll_work;
 };
 
@@ -71,10 +76,15 @@ static bool trace_remote_loaded(struct trace_remote *remote)
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
 
@@ -89,15 +99,28 @@ static int trace_remote_load(struct trace_remote *remote)
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
@@ -115,9 +138,7 @@ static void trace_remote_try_unload(struct trace_remote *remote)
 	if (!ring_buffer_empty(remote->trace_buffer))
 		return;
 
-	ring_buffer_free(remote->trace_buffer);
-	remote->trace_buffer = NULL;
-	remote->cbs->unload_trace_buffer(remote->trace_buffer_desc, remote->priv);
+	trace_remote_unload(remote);
 }
 
 static int trace_remote_enable_tracing(struct trace_remote *remote)
@@ -434,58 +455,68 @@ static void trace_remote_dec_poll(struct trace_remote *remote)
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
-			/* only one printk iter allowed */
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
 
@@ -508,14 +539,18 @@ static void trace_remote_iter_free(struct trace_remote_iterator *iter)
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
 
 static bool trace_remote_iter_is_consuming(struct trace_remote_iterator *iter)
@@ -989,6 +1024,117 @@ static int dmesg_show(struct seq_file *s, void *unused)
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
+	remote->panic_on = enable;
+
+	return cnt;
+}
+
+static int dump_on_panic_show(struct seq_file *s, void *unused)
+{
+	struct trace_remote *remote = s->private;
+
+	seq_printf(s, "%d\n", remote->panic_on);
+
+	return 0;
+}
+DEFINE_TRACE_REMOTE_ATTRIBUTE(dump_on_panic);
+
 static int trace_remote_init_tracefs(const char *name, struct trace_remote *remote)
 {
 	struct dentry *remote_d, *percpu_d, *d;
@@ -1016,6 +1162,11 @@ static int trace_remote_init_tracefs(const char *name, struct trace_remote *remo
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
2.55.0.229.g6434b31f56-goog

