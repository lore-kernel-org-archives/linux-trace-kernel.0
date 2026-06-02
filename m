Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101723F58C3
	for <linux-trace-kernel@vger.kernel.org>; Tue,  2 Jun 2026 17:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780420327; cv=none; b=H3ei0axreOP2Vv4tsrlz4HMwmT3XlL1GWTFtYuSQ0FqTpUjObVzWc3lYCeCDajHs1id3h8g94+M2Dk56Gbc67Oq4O6CUkGaaVqLkJqVppwoaNx7VKmoVlk9OB7U+3SemJTff7bda+8HTiKFfO+dZDH2gSlTOptKDhKNs44iaoIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780420327; c=relaxed/simple;
	bh=mxxcAiiakCX96SmMn13HFjhoQDp1zvQICSo1lP0JxQg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Bngmf1LJoUEULcyFlt5NQp2codQPj/UI6H+UE9dtmYJ5SFQsygOQsuTbV+Sqe2nBhRmnvaZoA/nmOUuvpsAVJFYF6R0Pta+FBjjUoC+CHlDHoaakrihy8aviwh6f5w06kO+RkFho1i3L8OreWrauvuXSdFKXeRrX6Ielq0cSvNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WNc9ygsh; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WNc9ygsh"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-490a060eb84so28642575e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 02 Jun 2026 10:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780420324; x=1781025124; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QiD8IXQeXxy+XxXoOS7MbARKdoSa/8YQRGqVyGhTR0M=;
        b=WNc9ygshd3PJPRXM93/SoBW9QJWhvupxyqDUyDFW6ZGGvBGhmghNnXvXN4z/9NKomz
         9E5mMJhJmaRLOBXcFesuME/pTmXsd3SqfADIHMLKi5pptejgnPPepAyb9Jodq9RsGVV2
         cCIH56IP+xl/m01N4oWFhVYiBkRBcCIG1xGdnb49SENCDj3zOabZ/EAJ42heSA5sr6Zp
         nF3W4zRH2VkdHGV8eyF0J3UXxqLBsuIXn4P+m5g/c/RgYJk5O5dU3cPZk1t4c8Bru8z3
         3K1ehiZFIiuGpq/jCdrRfACgqfrEWdQfnQOSwkijsRD19ppHUhWCRjrlWz0AYVIyKjjY
         +E4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780420324; x=1781025124;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QiD8IXQeXxy+XxXoOS7MbARKdoSa/8YQRGqVyGhTR0M=;
        b=LyK1hSNye2K0XhWNghMEUxV0lEzNSIKDarxFnOoUwV9WTXiddumOFz5bF087xh1kND
         pZkTOmVyXlRRwm32qrk/VJKGi6cnZyZ+ddE06wzT6jW/gMQYvuLrlw2PAjSdY+ciH8PF
         vcJVlj4Xc948G1IHVD+2yxLbg4pShT8C7asIYsLEAop/q4wpV62wJ3qrheDHZGalDSn7
         lx/sAidq9kVGFqBf25eEx5qwx2ajqzFN8uBhkNZSj2ktgwE4dtFnI1smxDSMWCHeB0VW
         MxY1A4qlcKdbABDfizLxSK7v7c3VTEUFE7o4MOCdJ7NrpHMSYtDrOo6HXaY6BRvOwmik
         a+vw==
X-Forwarded-Encrypted: i=1; AFNElJ9bCgW94vHgfB8SW6CuxpWFRXjPV6Dtnx+Po96TuBYICoLOy77m58o05i1yXWMtJkRB7WW2fPti9n1bGKopPPA84vA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3qjTXqrvZ8BS2n2+oyPSNY2Be1RSJqDxuCEt8DaQOpM60o1Ue
	M9ScJwLcdQWrSP4sdx5ge6FmcfjTb68UOE8XsNracElitH7zTi/GW4ULlx3KC1Bo7bu7AHv2oVu
	L7wUxXlqUCwyX40HAMeb5oA==
X-Received: from wmbjp5.prod.google.com ([2002:a05:600c:5585:b0:490:ae3b:b7c9])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6304:b0:490:abd7:fd9 with SMTP id 5b1f17b1804b1-490b50499c0mr9431555e9.10.1780420324430;
 Tue, 02 Jun 2026 10:12:04 -0700 (PDT)
Date: Tue,  2 Jun 2026 18:11:37 +0100
In-Reply-To: <20260602171146.2238998-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602171146.2238998-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260602171146.2238998-6-vdonnefort@google.com>
Subject: [PATCH 05/13] tracing/remotes: Add printk tracefs file
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

When enabled, the printk tracefs file enables the redirection of all
events to dmesg. This is similar to tp_printk.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index 21583fae1bd9..1bf0ba159c92 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -21,6 +21,7 @@
 enum tri_type {
 	TRI_CONSUMING,
 	TRI_NONCONSUMING,
+	TRI_PRINTK,
 };
 
 struct trace_remote_iterator {
@@ -42,6 +43,7 @@ struct trace_remote {
 	void				*priv;
 	struct trace_buffer		*trace_buffer;
 	struct trace_buffer_desc	*trace_buffer_desc;
+	struct trace_remote_iterator	*printk;
 	struct dentry			*dentry;
 	struct eventfs_inode		*eventfs_root;
 	struct eventfs_inode		*eventfs_subdir;
@@ -335,6 +337,8 @@ static int __alloc_ring_buffer_iter(struct trace_remote_iterator *iter, int cpu)
 	return 0;
 }
 
+static void trace_remote_do_printk(struct trace_remote *remote);
+
 static void __poll_remote(struct work_struct *work)
 {
 	struct delayed_work *dwork = to_delayed_work(work);
@@ -342,6 +346,7 @@ static void __poll_remote(struct work_struct *work)
 
 	remote = container_of(dwork, struct trace_remote, poll_work);
 	ring_buffer_poll_remote(remote->trace_buffer, RING_BUFFER_ALL_CPUS);
+	trace_remote_do_printk(remote);
 
 	schedule_delayed_work(dwork, msecs_to_jiffies(remote->poll_ms));
 }
@@ -351,6 +356,8 @@ static void trace_remote_inc_poll(struct trace_remote *remote)
 	/* poll_cnt <= nr_readers, inherits its overflow protection */
 	if (!remote->poll_cnt++) {
 		ring_buffer_poll_remote(remote->trace_buffer, RING_BUFFER_ALL_CPUS);
+		trace_remote_do_printk(remote);
+
 		schedule_delayed_work(&remote->poll_work, msecs_to_jiffies(remote->poll_ms));
 	}
 }
@@ -393,6 +400,14 @@ static struct trace_remote_iterator
 		trace_seq_init(&iter->seq);
 
 		switch (type) {
+		case TRI_PRINTK:
+			/* only one printk iter allowed */
+			if (WARN_ON_ONCE(remote->printk)) {
+				ret = -EBUSY;
+				break;
+			}
+			smp_store_release(&remote->printk, iter);
+			fallthrough;
 		case TRI_CONSUMING:
 			trace_remote_inc_poll(remote);
 			break;
@@ -427,6 +442,11 @@ static void trace_remote_iter_free(struct trace_remote_iterator *iter)
 	lockdep_assert_held(&remote->lock);
 
 	switch (iter->type) {
+	case TRI_PRINTK:
+		WARN_ON_ONCE(remote->printk != iter);
+		smp_store_release(&remote->printk, NULL);
+		flush_delayed_work(&remote->poll_work);
+		fallthrough;
 	case TRI_CONSUMING:
 		trace_remote_dec_poll(remote);
 		break;
@@ -504,6 +524,7 @@ __peek_event(struct trace_remote_iterator *iter, int cpu, u64 *ts, unsigned long
 	struct ring_buffer_iter *rb_iter;
 
 	switch (iter->type) {
+	case TRI_PRINTK:
 	case TRI_CONSUMING:
 		return ring_buffer_peek(iter->remote->trace_buffer, cpu, ts, lost_events);
 	case TRI_NONCONSUMING:
@@ -571,6 +592,7 @@ static void trace_remote_iter_move(struct trace_remote_iterator *iter)
 	struct trace_buffer *trace_buffer = iter->remote->trace_buffer;
 
 	switch (iter->type) {
+	case TRI_PRINTK:
 	case TRI_CONSUMING:
 		ring_buffer_consume(trace_buffer, iter->evt_cpu, NULL, NULL);
 		break;
@@ -814,6 +836,80 @@ static const struct file_operations trace_fops = {
 	.release	= trace_release,
 };
 
+static void trace_remote_do_printk(struct trace_remote *remote)
+{
+	struct trace_remote_iterator *iter = smp_load_acquire(&remote->printk);
+
+	if (!iter)
+		return;
+
+	trace_remote_iter_read_start(iter);
+
+	while (trace_remote_iter_read_event(iter)) {
+		trace_seq_init(&iter->seq);
+
+		trace_remote_iter_print_event(iter);
+		if (!pr_emerg("%s", iter->seq.buffer))
+			break;
+
+		trace_remote_iter_move(iter);
+	}
+
+	trace_remote_iter_read_finished(iter);
+}
+
+static int trace_remote_enable_printk(struct trace_remote *remote, bool enable)
+{
+	struct trace_remote_iterator *iter = remote->printk;
+
+	lockdep_assert_held(&remote->lock);
+
+	if (enable == !!iter)
+		return 0;
+
+	if (enable) {
+		iter = trace_remote_iter(remote, RING_BUFFER_ALL_CPUS, TRI_PRINTK);
+		if (IS_ERR(iter))
+			return PTR_ERR(iter);
+	} else {
+		trace_remote_iter_free(remote->printk);
+		/* trace_remote_iter_free has reset remote->printk */
+	}
+
+	return 0;
+}
+
+static ssize_t
+printk_write(struct file *filp, const char __user *ubuf, size_t cnt, loff_t *ppos)
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
+	ret = trace_remote_enable_printk(remote, val);
+	if (ret)
+		return ret;
+
+	return cnt;
+}
+
+static int printk_show(struct seq_file *s, void *unused)
+{
+	struct trace_remote *remote = s->private;
+
+	seq_printf(s, "%d\n", !!remote->printk);
+
+	return 0;
+}
+DEFINE_SHOW_STORE_ATTRIBUTE(printk);
+
 static struct dentry *tracefs_root;
 static DEFINE_MUTEX(tracefs_lock);
 static u64 tracefs_root_count;
@@ -858,6 +954,10 @@ static int trace_remote_init_tracefs(const char *name, struct trace_remote *remo
 	if (!d)
 		goto err;
 
+	d = trace_create_file("printk", TRACEFS_MODE_WRITE, remote_d, remote, &printk_fops);
+	if (!d)
+		goto err;
+
 	percpu_d = tracefs_create_dir("per_cpu", remote_d);
 	if (!percpu_d) {
 		pr_err("Failed to create tracefs dir "TRACEFS_DIR"%s/per_cpu/\n", name);
-- 
2.54.0.1032.g2f8565e1d1-goog

