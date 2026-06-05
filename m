Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B601237B02A
	for <linux-trace-kernel@vger.kernel.org>; Fri,  5 Jun 2026 16:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780677585; cv=none; b=CMbQjAvoxnlGQ2zRP/KeO2/QlM8wq4cmg+n7hgCMZW7pvZuBPsCwTeajDXYWsX13mfp7m7nyo7YYLztn8N55qFnxmcIs+JImh/DS2jrfg46A4oekpgjlyUN81IoTW6tGbWgNExn3ug6lYMYfbcj/bICZ/DF7Z0Fb+x8h3+lNQ1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780677585; c=relaxed/simple;
	bh=Y0llj65hHJ+mYIfcKoo/DoDkWx4c00KuqjHKzYSnZ5w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oGLZ4QreM1gq3i5s80Mwrwwj5k79PZs0bylUZULez8Jzfbx6iGgS3JJUJkCNAqaw9daPBK8aAzEOOltYE0JeuvtInPhPUumbbkTdLlD0GXHyvdI74s7BdIPaQEJXY+Bf3Ucgc72r84B+8NdIwZGJruDi+eAhxFGiOD+q5CA1q+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n3vHnVHo; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n3vHnVHo"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-45ef616db45so1604056f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 05 Jun 2026 09:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780677579; x=1781282379; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tLHcNDksm5rOOYeaSfHeExFcAHml4befCij+4LLGe3M=;
        b=n3vHnVHoFWoFdhBQquZUBhUpGdj7V4JdDG8MVWr2Ni3R1/U8aQle9is2EHZT7wRKaw
         dr4m0F4blgysQfOyo7tyTVYkLokpOumyehgnFo/rTKWQmmA+S3EcwyTGlF0ZjYc+lDSp
         pkpEMuxWfy/sMOvPUUg5NT14kGFSKpUwiKwQrnPlWez8G3NGN4HQ1obirAbsfihRT6kV
         4eyET7jsAtlXIekYPmHtGE0JI3shQXwGqbWYJMgAEB33TPymejVNnl6SJWF0VNGehuvM
         B9dn6DRQVi+6L9/z5g8SYIIktvhs4GFyLd97YVy8RlkbwLWXl/Bb8+iFq/2Lph3C4kh4
         jLSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780677579; x=1781282379;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tLHcNDksm5rOOYeaSfHeExFcAHml4befCij+4LLGe3M=;
        b=sdQRmKoMsA8bnKzWKcCTAaxqDyz9PK/EtkdYAdCBYxyD3/wJ7Nv/6mtGm8GEJDaeql
         SlkFvnJjcDdEjWosY6hXQQGXniUspinaBJ3R9sX9KyNmVsX+RsOacb/59jvWi/qmpcHA
         r0lTP6Yaj3l1L/YbvsbwPZ2VgDTzkNlx2YW2NmaaZIS5NNMw5fmht6/RPVYgldyiv2/G
         XDOCStG1rHQqAJblm8ZtF6XrLTxXDVjHdHK4pjhU6n9aeLJ94Ytwu/F3MDM5DukPVe3z
         WDwyTjR+UMwFIwiTa2ZQ9OvrwzV8EMOk4mGvIcY7PKj5kzNGKY3EpiaItiw4CyJqTHJ6
         QU9Q==
X-Forwarded-Encrypted: i=1; AFNElJ/KzZyP5cknivW+4Rj702gqqdBQdEEThqTqLtPd1zHVz4SGpNGwriuZUBFKlILOkYRNEj4HGr49Ophl5ug0YOBwsV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyryVDergiSbXK4r6FjN8bkdNZqFdYNhRtin+A6eTZ7xonQRjE9
	rjKqEIfvgfOwxGLZGV0Q3jqanO+cM/QAEv2D8UKUnsGhZZu4CNXr4VNKwkGkg9sUjsx2n9Gu2L3
	+kSIHsHY2DJdnkEZjVL01TQ==
X-Received: from wrrm2.prod.google.com ([2002:adf:fa02:0:b0:45e:f818:b5ae])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:11cb:b0:43b:3e40:2223 with SMTP id ffacd0b85a97d-46030609816mr5612571f8f.19.1780677578644;
 Fri, 05 Jun 2026 09:39:38 -0700 (PDT)
Date: Fri,  5 Jun 2026 17:38:11 +0100
In-Reply-To: <20260605163825.1762953-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260605163825.1762953-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260605163825.1762953-5-vdonnefort@google.com>
Subject: [PATCH v2 04/18] tracing/remotes: Use a single per-remote polling work
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
index 71f6cda0fbd4..2271d54eb3dd 100644
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
@@ -56,6 +55,8 @@ struct trace_remote {
 	struct rw_semaphore		*pcpu_reader_locks;
 	unsigned int			nr_readers;
 	unsigned int			poll_ms;
+	struct delayed_work		poll_work;
+	unsigned int			poll_cnt;
 	bool				tracing_on;
 };
 
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
2.54.0.1032.g2f8565e1d1-goog

