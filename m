Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A12C48095E
	for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Jul 2026 10:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784630191; cv=none; b=HSGHcYWXprN8t3Oi4y1t3gIxNdPKRUeI8nYJn2EVNijJ9ljgQ7fogsKz1szH3BVD0qI7iuSn9DniIWO6Nmh9n7nbIvdWjyZSCRa0HYSHcwM2TAp3VkA6vnQ9EZ0/VwM35tRXKrQ3jU0HPICaYo8RCPh2FFKDdTeXfVvtd8o2424=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784630191; c=relaxed/simple;
	bh=2/j2q98cJx+AnDVO1Uqe91IIifRuBRjeU0xfGZaOuXw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VPGweStRCtTeJ4AdYTm7/aQzPWmB6Gk1RE/S/NEyl2l1RDqFrQ76YtsudLnUQI8g1Exe9JRatyUnUtvb6izG+onz0gYuD5Y8Yej0hXMhA5dO4ve6HmwKdCbK7cL3N+qFRcdNaldb45Dk4jJ5boSbWwiMJIHwjxtxP8aUJc/R3DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jxFNCF0M; arc=none smtp.client-ip=209.85.221.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jxFNCF0M"
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47f83416551so123793f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Jul 2026 03:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784630188; x=1785234988; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RziKU1z5NHEmw0J6hGfyX3geCnZbRDA1qYNBDhbG4xQ=;
        b=jxFNCF0MOMv5zvMHwhHHOg2rnMghgk84L07yPQ9JbhrB/Dmzl5xLONvdSYS3CEMQBy
         a7xvYAIvEZw7chuaj3CBOWf3IObCLlD7O92vW4lNjH1Hz4e+os/QQFtfZWGPNN3uWah+
         S1bseS8zr1rtRWQPLnLha+6vZDa+G9T8wovscxHilyknZScxN19kijSrtqdDXZ+2f1u5
         XIEIyAWuwx9dylgrKqOV6IP1zzPWcaxynI8HYO/eiHr7NpqJBKbTLOtvmkxAv7ZzgiKr
         Sn/TGqmYE92iNaEHDEkmsazQPWTWRpdBdvNeuDjI7AosWD+9kyCCVkCr5pzO4jHAJS9v
         3SJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784630188; x=1785234988;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RziKU1z5NHEmw0J6hGfyX3geCnZbRDA1qYNBDhbG4xQ=;
        b=ISqGRf1i9Prc/EOoK81IU9TzW+REqeVQu1Groe/zaZ1DRBVK+k7SnR7NW/0Qr1lRh1
         yC91ZsQBy9+Uj5wnvZjYONoOxCpJbUMewu6gLpPFZ48hxZ3xZCu+IctovJiyPrOvjZJm
         QYOU+wrzd15rJWQm2H7JNmiwGdRXdhK0msDwYCAxfIMhd/gG8pjt3QfK4vv4CquDhLKt
         aqiiP6VcWdhG/ZnUvoiSW/ZhTfyMnkH1jJUJA+4gRMPOaqd/13PaWPf7+pMpx/GuBdf+
         +7YX49NjLVZd9ez5Zth5akoR1nCobLx888ldbLuwuZJl0OzvEkzAR4el8NxkU8ytCimw
         1JhQ==
X-Forwarded-Encrypted: i=1; AHgh+RoQfhtXvHO5M9G8Ysw6n4JiGWw4mmaeFSAlLm1FUoq443WLE9M41sPT7hYDna8j8hoCFQdRxzr+So/3r17dqDfVdV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKGZAZfAD9vf7qtrV5vqULNM3IkhLiUKNu2YToX4DSk0XQ+3rR
	uvdIUO2Hh3xk1PO+fLi11b14MM1Cam+TrEztXWWIIta5zCwWbiIp8J5knpG6WQXATALGgRCpqnf
	PqhfFIrrjRUxAuQLJqVKvbg==
X-Received: from wmna5.prod.google.com ([2002:a05:600c:685:b0:495:59b1:8091])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4685:b0:495:4a77:1327 with SMTP id 5b1f17b1804b1-4954a771521mr211762795e9.33.1784630187308;
 Tue, 21 Jul 2026 03:36:27 -0700 (PDT)
Date: Tue, 21 Jul 2026 11:35:51 +0100
In-Reply-To: <20260721103603.342266-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260721103603.342266-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260721103603.342266-7-vdonnefort@google.com>
Subject: [PATCH v3 06/18] tracing/remotes: Add dmesg tracefs file
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

When enabled, the dmesg tracefs file enables the redirection of all
events to dmesg. This is similar to tp_printk.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index 3af622c94784..c54e1c65d163 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -21,6 +21,7 @@
 enum tri_type {
 	TRI_CONSUMING,
 	TRI_NONCONSUMING,
+	TRI_DMESG,
 };
 
 struct trace_remote_iterator {
@@ -43,6 +44,7 @@ struct trace_remote {
 	void				*priv;
 	struct trace_buffer		*trace_buffer;
 	struct trace_buffer_desc	*trace_buffer_desc;
+	struct trace_remote_iterator	*dmesg;
 	struct dentry			*dentry;
 	struct eventfs_inode		*eventfs_root;
 	struct eventfs_inode		*eventfs_subdir;
@@ -394,10 +396,15 @@ static int __alloc_ring_buffer_iter(struct trace_remote_iterator *iter, int cpu)
 	return 0;
 }
 
+static bool trace_remote_do_dmesg(struct trace_remote *remote);
+
 static void trace_remote_do_poll(struct trace_remote *remote)
 {
+	bool yield;
+
 	ring_buffer_poll_remote(remote->trace_buffer, RING_BUFFER_ALL_CPUS);
-	schedule_delayed_work(&remote->poll_work, msecs_to_jiffies(remote->poll_ms));
+	yield = trace_remote_do_dmesg(remote);
+	schedule_delayed_work(&remote->poll_work, yield ? 0 : msecs_to_jiffies(remote->poll_ms));
 }
 
 static void __poll_remote(struct work_struct *work)
@@ -452,6 +459,14 @@ static struct trace_remote_iterator
 		trace_seq_init(&iter->seq);
 
 		switch (type) {
+		case TRI_DMESG:
+			/* only one printk iter allowed */
+			if (WARN_ON_ONCE(remote->dmesg)) {
+				ret = -EBUSY;
+				break;
+			}
+			smp_store_release(&remote->dmesg, iter);
+			fallthrough;
 		case TRI_CONSUMING:
 			trace_remote_inc_poll(remote);
 			break;
@@ -486,6 +501,11 @@ static void trace_remote_iter_free(struct trace_remote_iterator *iter)
 	lockdep_assert_held(&remote->lock);
 
 	switch (iter->type) {
+	case TRI_DMESG:
+		WARN_ON_ONCE(remote->dmesg != iter);
+		smp_store_release(&remote->dmesg, NULL);
+		flush_delayed_work(&remote->poll_work);
+		fallthrough;
 	case TRI_CONSUMING:
 		trace_remote_dec_poll(remote);
 		break;
@@ -498,13 +518,24 @@ static void trace_remote_iter_free(struct trace_remote_iterator *iter)
 	trace_remote_put(remote);
 }
 
+static bool trace_remote_iter_is_consuming(struct trace_remote_iterator *iter)
+{
+	switch (iter->type) {
+	case TRI_CONSUMING:
+	case TRI_DMESG:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static void trace_remote_iter_read_start(struct trace_remote_iterator *iter)
 {
 	struct trace_remote *remote = iter->remote;
 	int cpu = iter->cpu;
 
 	/* Acquire global reader lock */
-	if (cpu == RING_BUFFER_ALL_CPUS && iter->type == TRI_CONSUMING)
+	if (cpu == RING_BUFFER_ALL_CPUS && trace_remote_iter_is_consuming(iter))
 		down_write(&remote->reader_lock);
 	else
 		down_read(&remote->reader_lock);
@@ -521,7 +552,7 @@ static void trace_remote_iter_read_start(struct trace_remote_iterator *iter)
 	if (WARN_ON_ONCE(!remote->pcpu_reader_locks))
 		return;
 
-	if (iter->type == TRI_CONSUMING)
+	if (trace_remote_iter_is_consuming(iter))
 		down_write(&remote->pcpu_reader_locks[cpu]);
 	else
 		down_read(&remote->pcpu_reader_locks[cpu]);
@@ -538,14 +569,14 @@ static void trace_remote_iter_read_finished(struct trace_remote_iterator *iter)
 		 * No need for the remote lock here, iter holds a reference on
 		 * remote->nr_readers
 		 */
-		if (iter->type == TRI_CONSUMING)
+		if (trace_remote_iter_is_consuming(iter))
 			up_write(&remote->pcpu_reader_locks[cpu]);
 		else
 			up_read(&remote->pcpu_reader_locks[cpu]);
 	}
 
 	/* Release global reader lock */
-	if (cpu == RING_BUFFER_ALL_CPUS && iter->type == TRI_CONSUMING)
+	if (cpu == RING_BUFFER_ALL_CPUS && trace_remote_iter_is_consuming(iter))
 		up_write(&remote->reader_lock);
 	else
 		up_read(&remote->reader_lock);
@@ -562,10 +593,9 @@ __peek_event(struct trace_remote_iterator *iter, int cpu, u64 *ts, unsigned long
 	struct ring_buffer_event *rb_evt;
 	struct ring_buffer_iter *rb_iter;
 
-	switch (iter->type) {
-	case TRI_CONSUMING:
+	if (trace_remote_iter_is_consuming(iter)) {
 		return ring_buffer_peek(iter->remote->trace_buffer, cpu, ts, lost_events);
-	case TRI_NONCONSUMING:
+	} else {
 		rb_iter = __get_rb_iter(iter, cpu);
 		if (!rb_iter)
 			return NULL;
@@ -629,14 +659,10 @@ static void trace_remote_iter_move(struct trace_remote_iterator *iter)
 {
 	struct trace_buffer *trace_buffer = iter->remote->trace_buffer;
 
-	switch (iter->type) {
-	case TRI_CONSUMING:
+	if (trace_remote_iter_is_consuming(iter))
 		ring_buffer_consume(trace_buffer, iter->evt_cpu, NULL, NULL);
-		break;
-	case TRI_NONCONSUMING:
+	else
 		ring_buffer_iter_advance(__get_rb_iter(iter, iter->evt_cpu));
-		break;
-	}
 }
 
 static struct remote_event *trace_remote_find_event(struct trace_remote *remote, unsigned short id);
@@ -882,6 +908,87 @@ static const struct file_operations trace_fops = {
 	.release	= trace_release,
 };
 
+static bool trace_remote_do_dmesg(struct trace_remote *remote)
+{
+	struct trace_remote_iterator *iter = smp_load_acquire(&remote->dmesg);
+	unsigned int max_events = 1000;
+
+	if (!iter)
+		return false;
+
+	trace_remote_iter_read_start(iter);
+
+	while (trace_remote_iter_read_event(iter)) {
+		trace_seq_init(&iter->seq);
+
+		trace_remote_iter_print_event(iter);
+		trace_seq_putc(&iter->seq, 0);
+		if (!pr_info("%s", iter->seq.buffer))
+			break;
+
+		trace_remote_iter_move(iter);
+
+		if (!(--max_events))
+			break;
+	}
+
+	trace_remote_iter_read_finished(iter);
+
+	return !max_events;
+}
+
+static int trace_remote_enable_dmesg(struct trace_remote *remote, bool enable)
+{
+	struct trace_remote_iterator *iter = remote->dmesg;
+
+	lockdep_assert_held(&remote->lock);
+
+	if (enable == !!iter)
+		return 0;
+
+	if (enable) {
+		iter = trace_remote_iter(remote, RING_BUFFER_ALL_CPUS, TRI_DMESG);
+		if (IS_ERR(iter))
+			return PTR_ERR(iter);
+	} else {
+		trace_remote_iter_free(remote->dmesg);
+		/* trace_remote_iter_free has reset remote->dmesg */
+	}
+
+	return 0;
+}
+
+static ssize_t
+dmesg_write(struct file *filp, const char __user *ubuf, size_t cnt, loff_t *ppos)
+{
+	struct seq_file *seq = filp->private_data;
+	struct trace_remote *remote = seq->private;
+	bool val;
+	int ret;
+
+	ret = kstrtobool_from_user(ubuf, cnt, &val);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&remote->lock);
+
+	ret = trace_remote_enable_dmesg(remote, val);
+	if (ret)
+		return ret;
+
+	return cnt;
+}
+
+static int dmesg_show(struct seq_file *s, void *unused)
+{
+	struct trace_remote *remote = s->private;
+
+	seq_printf(s, "%d\n", !!remote->dmesg);
+
+	return 0;
+}
+DEFINE_TRACE_REMOTE_ATTRIBUTE(dmesg);
+
 static int trace_remote_init_tracefs(const char *name, struct trace_remote *remote)
 {
 	struct dentry *remote_d, *percpu_d, *d;
@@ -922,6 +1029,10 @@ static int trace_remote_init_tracefs(const char *name, struct trace_remote *remo
 	if (!d)
 		goto err;
 
+	d = trace_create_file("dmesg", TRACEFS_MODE_WRITE, remote_d, remote, &dmesg_fops);
+	if (!d)
+		goto err;
+
 	percpu_d = tracefs_create_dir("per_cpu", remote_d);
 	if (!percpu_d) {
 		pr_err("Failed to create tracefs dir "TRACEFS_DIR"%s/per_cpu/\n", name);
-- 
2.55.0.229.g6434b31f56-goog

