Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6002246AA7D
	for <linux-trace-kernel@vger.kernel.org>; Tue,  4 Aug 2026 14:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785852242; cv=none; b=Z0JE79uJFqQ+CH5h7aJ7GCT6QD/UstJb78Xdjytuc8nefnXo+gRfX5maCcjDSG7jLCmamSjsxUnA7d8PKVPv1osxtER0LvoFmV90bFOqufz00HmuPCRN+gojdY2+atWeJ2n3C1wzf7im6ZRpKm006BQUEWxR0ktg6lG+FhPgByY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785852242; c=relaxed/simple;
	bh=ky3P/A4huW1quwqOmzuIG/MQIMci8B7UzhtDgU0ZhS0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a+YK1rTq5SujJQg9oW6aqmYQdF6anymvnf20krjhUt2RGYDNTNYi8stvYdkQ5WPGimrTafFqkqWI4N3Nm4EDHcWV3CPfO3t4oswrlJChN9HYitKX7cgW6PjXRsj/BJuigE9fXm8VwIeGAC2oAAcZiilhqJAwQDk6By5JKUbnlY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k2QnZPsP; arc=none smtp.client-ip=209.85.221.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k2QnZPsP"
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47fd4ee0ac0so3525048f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 04 Aug 2026 07:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785852239; x=1786457039; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jomIh7GLWvVMMLBLYlyh1ATxygV+XtNa4S7P8CadwNc=;
        b=k2QnZPsPD11WaEm8pS4k119joFBBwxsvFiNVvT/oLKtoho7dqAlbuAyjq8dqXdZpr8
         R/mJe6aSE6l6Hv88knHlnmAAJ0idK9LpAJtG1/1JaCVSAaJV1QGModjZTE5gaXCbThLY
         96GgdrjnNTdwcskrC3ds8J5qZet1HH8jTKD92ZpR2QZe70KvUA96O9J734gspYRn+d0o
         GV4NqwFlwPMJ4BSi93do+sbK3zLwncdo/tFOqB5mzK/apAXwBCP8gMF+CH89mi5Dvem+
         7Cw9tB8sjasRnw+EaMTeL9h2fQjTBZwVBjjgkfxXV7uqL10lU6EGr4tdm12mOs0U6ClC
         f+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785852239; x=1786457039;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jomIh7GLWvVMMLBLYlyh1ATxygV+XtNa4S7P8CadwNc=;
        b=LLs8NaNZl9CvU3pNyCtMGz+nfNiXMBlgFsvrqeGVEO8nUElHME4HDlzvfIwCscL6s7
         NdicHx1eFwXMDOhQ+93vlNgub+N0Yg5XOgd4qNdT4NX+E6xFh881KknV4af0Sa/1ZU8U
         xJZgBdWkEh267KUn8jCtS9NmAjI53/YZ6FT1GrUwqzDjP/e7D9rqB0r+xMUUPwYcGG/6
         9OK5gdvPvW3IeCR9ugE1i12TCqLEbUcI3hZnjQcZXXYcpdNhEJYTqDuHzX2xzJGb+Jjr
         4dHrkOG7wqsfHMiOd82dWMrUzfx6MVgQgYXSImPjQBrb4w7P2cCQRKNm7qmZ7D6ea9nL
         2HCw==
X-Forwarded-Encrypted: i=1; AHgh+RqGeRfYInywHkhWyDDn9G5kqGPE7hI+FPfhnCalvKY9tApXK42FwBp9DBjFCZtzyuJRlrFMkKlKScNsAS7VWHcyyaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfVRhuZUTGYJcx5fkoWV/f7M2T1Vfi+5xAKRlCwO26ItuT9f/p
	B6i9sv+OKWVqr5stxULOo8zsfxdHLzBUOQrVORetj5NmcLd5+UMiZIDE8IZgCpsaJqu6yqTlMw0
	7QB7np5j98/zB4iErXdWlzA==
X-Received: from wmaq1.prod.google.com ([2002:a05:600c:6c81:b0:493:ed72:8dad])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b03:b0:493:f262:b8 with SMTP id 5b1f17b1804b1-4980c66d884mr313051065e9.1.1785852238262;
 Tue, 04 Aug 2026 07:03:58 -0700 (PDT)
Date: Tue,  4 Aug 2026 15:03:21 +0100
In-Reply-To: <20260804140333.797210-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260804140333.797210-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260804140333.797210-7-vdonnefort@google.com>
Subject: [PATCH v4 06/18] tracing/remotes: Add dmesg tracefs file
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
index 1fbe2f3f20e9..58a38f3d4902 100644
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
+			/* only one dmesg iter allowed */
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
2.55.0.571.g244d577d93-goog

