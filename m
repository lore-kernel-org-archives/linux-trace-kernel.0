Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC46238551A
	for <linux-trace-kernel@vger.kernel.org>; Fri,  5 Jun 2026 16:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780677587; cv=none; b=qzDr04tAs/cfFi6okxtGnhIIvdkbu4W9ajNMEzQFN/EaUZsS7h/KftUZvarmgGcPQusq6M284S90HpIBoss0x0YE4PHaIPIGRVaDDi1G8mO+DmkwWvW2m/wi23WhmMJeVIGntVO+zie0RYaIylwPQ20Wd8CzleUcdzVGyAB91yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780677587; c=relaxed/simple;
	bh=9+3oe2YnRb91RfZzxa+HjCRlWsWlSHSgCrIKBKQP0KE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BXZAHwvvCbCvQAPxM+PVUluKR1IK8cdlb8vgbEymSXaeQrEkRmWNPOEpTdVgLINxYxHRplQe+2Sh9pW+9NTp6tPrd9MUJ4drKUSjLMmuHY7Y1LeG2uOYVsbsyEyRMtn4PqQrVx6oPkw2CsoYTgdBU5Xt0UfIAJbnrBsLxYKbYfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Uz991HkV; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uz991HkV"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-46010bc0f1eso1296804f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 05 Jun 2026 09:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780677581; x=1781282381; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ACIefOWC08Us2NqlwmOLnKn5CaGFNdU2JkDRV9gbbvM=;
        b=Uz991HkVtjST7I7EU0YG+xgBl201UwclC+zDWrNRNaTKmPaGDHjiML76EJkVfGNEAw
         UCMahIt11+VXi9DF/B+Iqdzrrppi5UFk9PQbMSrlEK9T67O+/FICO4THN2VYZ4iRTGnO
         p6w1fwWMYpQv5Ky6+el9TBon3tztFyf+e9oWmNelYfy+dTLPrPRyEoDJOM9z/7G5mHis
         rVpnh1uFYg2xpqzp7VNCIyQq/FICG5V7rwt53y73CZFoEDjD23NEM+5t37FdW1wRMMmc
         kUFgr0olUC4WA2PIWyDr8AZcAzBAAwphdEkxgtaw3VFsb/df41zb6dV2ZONh/szs0KGL
         pM0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780677581; x=1781282381;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ACIefOWC08Us2NqlwmOLnKn5CaGFNdU2JkDRV9gbbvM=;
        b=BffzRZD2XMFhNRXp2R09sCXg5aXwlLHWZrgG8pifBzWO327bE5KYri1V70gwL7d+ne
         BMg6mT/I4gbNx98f/UmkB0Qk3nkCBTwOFhhE/b0peJP/NoX+zMYXjByRaol88Cc/+TSN
         wQHg2PjevmUYyB5qM1lJp92ySHp0l4IlGr/kXr21XH4mRRJ9wobKwZ6m7fLbLKn0wJEv
         GED5jU5qKwBN8vbrqjksCMMcCKkzA3HAVD0vrLliOKkbrAJw6PWhBeYHoBRsr3E8dpie
         BhmeaW5DYiXQi+6uB7wCMpZpCHwhmRz9xF9zBBAjbUFYPezzUkw3pjQgcwYzK74WWweu
         TqBw==
X-Forwarded-Encrypted: i=1; AFNElJ9FO0//t04nIFzBGYcspfFpfav7wp/AiQC4PI4zy42hkl8adrdMDAQb5kxFWQxqotY0PtyzGaCQKLAz6wBE3/XqKHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCibwgnXt6Z/QZuE43ZxgGIMJbb2aI4SEwEiZCLWF6+VC19mZs
	ICPkV3t7HXiQ9j2vMdXXN1nXAhIKfMKB7DEjs9sCIdxEqq/j0z2pzxgo7YvHw3v+Gi7Iz8RrU8Z
	4S2yhoy8R/OEtaeLXvysPfg==
X-Received: from wmbfp27.prod.google.com ([2002:a05:600c:699b:b0:490:b360:5841])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3e0e:b0:490:a1a6:6f24 with SMTP id 5b1f17b1804b1-490c25d7de7mr69934915e9.15.1780677581172;
 Fri, 05 Jun 2026 09:39:41 -0700 (PDT)
Date: Fri,  5 Jun 2026 17:38:13 +0100
In-Reply-To: <20260605163825.1762953-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260605163825.1762953-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260605163825.1762953-7-vdonnefort@google.com>
Subject: [PATCH v2 06/18] tracing/remotes: Add dmesg tracefs file
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

When enabled, the dmesg tracefs file enables the redirection of all
events to dmesg. This is similar to tp_printk.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index 2271d54eb3dd..19dfa355b7f3 100644
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
@@ -882,6 +908,86 @@ static const struct file_operations trace_fops = {
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
+		if (!pr_emerg("%s", iter->seq.buffer))
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
@@ -922,6 +1028,10 @@ static int trace_remote_init_tracefs(const char *name, struct trace_remote *remo
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
2.54.0.1032.g2f8565e1d1-goog

