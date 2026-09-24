Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE5049CF5C
	for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 14:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790261917; cv=none; b=ZfhIqe5noLxfUHztKiDsrkdBbgBweL8o9mufqra8H7yTioZxgZm0O4e1E/yuu7tVx+Tb9VN655p6r+PY548tKbL6KhHopfm84ivrwDeDmCk1POQpX8GGEfAvMJ/rP31lWKxAZnhKNBGZOYxklWoxxilU0g7MLhobVhPXAS2JCag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790261917; c=relaxed/simple;
	bh=ceyfEUZN+xc+92x1RwOTv9I75LstjiCDhz8o0xhoSSM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GoXh4qjGr11G04Zvm3tg8QDnNngb81uQVVlmK4GEsI2K1bhkZbCjsHwrsb1e3tlTbv6jJuzbuUmhOIIrWorS5XhGEnp/A/jKBDjTdKddShWXAESv/d8E+ezC4eMY9ygrAF/4s8tD7o1TsD4gCSu6+4GjpDYcKOymMbZeq8HFYF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JV6UjNYY; arc=none smtp.client-ip=209.85.128.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JV6UjNYY"
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49e6862e924so16222915e9.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 07:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790261911; x=1790866711; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eUD9nRafPnFAogygy4UT57EJvWHI6R+44Odk5FPBMD8=;
        b=JV6UjNYYXr7EcUMyQuJA5zCl80wXPGrhdInO+yljOzveKWAHen+f0tLDXmbZk/KTDB
         dWUlk/WVkhesmwB2mMh677qK6Kw9raLUdzNDziG6aSX/ZLin7dXi3B0p94VA8QlJFNuw
         kZbAWlq0CMyUlDtcPNxKH34PuP19N8wAzWNL4vBHET6o9LZvj1xsD3z0x+BJ1leoYnGn
         htSOepxd7MeN/x17FdAyMoWmf0ijJx+8VkN3+wjkE2KVwZHipc0vNB8xs/XDnv/IZe4u
         9GTHOchqLS0CckjSrlGE+FJ+gyPPwKWl8JdLL3lAPOGL5M+fLAJGIAb0ST5Eehf+LdDo
         2Wtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790261911; x=1790866711;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eUD9nRafPnFAogygy4UT57EJvWHI6R+44Odk5FPBMD8=;
        b=1lq6mo6AYEikQd/rkF8H5tvws4BN07KrMIZzImCO7h6HcBhG5loLOS22mfuP1TF/Mh
         8fccA7j4bdmnB2Kf5kDa7ExPcbwN1JRMO1k0Lz/LAQgxxJi06CzINMfRzNa847UTiFcd
         InO70Zoh0IU3DsSZ/S0Rr+hv7h0usR1CYoYOPpdpZFdIV+uxB7VYtm9U1yLSur8zrtrQ
         Oy8mmKHAAWdBdYuMac2LFeNZyy8+QuCWgiPhginI4lILLGLZhQrwZHv8CobMeSbV0Z6w
         lXYJPPGB7m+GgcCr3fvT5JoDSL+U84dXEAb7TPmU/8+ZZsMEqPa3d8dy4yhCnxm5agQd
         fsXw==
X-Forwarded-Encrypted: i=1; AKwUvBzbd4UFco/xXLN0r5B5buzOLd0WWHLws1xLa/gpuV7UVxluXjOrh0mUo2/bb+AQnC/FxHEiuh+EhZJz2Gp2Xwqjq+E=@vger.kernel.org
X-Gm-Message-State: AFuF++lhtg7HeLL3PKafXTVhPwGxA7whDJJP8EzpsCYRVJVWVgLEoGer
	twriAoB0kFBi2Zr6BtDhqZisT/PMxWzIiPK3YLpOPrIkX/mbuz+xn15wfcBUIlfGFildPpU/WvE
	5IGEw+aPOfIGJc2LdTuDc2g==
X-Received: from wmcm22.prod.google.com ([2002:a7b:ce16:0:b0:49f:e310:c9e6])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e12:b0:49c:fc6e:a3df with SMTP id 5b1f17b1804b1-49fe66f82d8mr46837345e9.30.1790261910509;
 Thu, 24 Sep 2026 07:58:30 -0700 (PDT)
Date: Thu, 24 Sep 2026 15:57:40 +0100
In-Reply-To: <20260924145754.1285146-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924145754.1285146-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260924145754.1285146-7-vdonnefort@google.com>
Subject: [PATCH v7 06/20] tracing/remotes: Use a single per-remote polling work
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
---
 kernel/trace/trace_remote.c | 51 +++++++++++++++++++++++++------------
 1 file changed, 35 insertions(+), 16 deletions(-)

diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index 517546e8343a..2b5020d2c138 100644
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
@@ -351,17 +352,6 @@ static bool trace_remote_has_cpu(struct trace_remote *remote, int cpu)
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
@@ -405,6 +395,36 @@ static int __alloc_ring_buffer_iter(struct trace_remote_iterator *iter, int cpu)
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
@@ -434,9 +454,7 @@ static struct trace_remote_iterator
 
 		switch (type) {
 		case TRI_CONSUMING:
-			ring_buffer_poll_remote(remote->trace_buffer, cpu);
-			INIT_DELAYED_WORK(&iter->poll_work, __poll_remote);
-			schedule_delayed_work(&iter->poll_work, msecs_to_jiffies(remote->poll_ms));
+			trace_remote_inc_poll(remote);
 			break;
 		case TRI_NONCONSUMING:
 			ret = __alloc_ring_buffer_iter(iter, cpu);
@@ -470,7 +488,7 @@ static void trace_remote_iter_free(struct trace_remote_iterator *iter)
 
 	switch (iter->type) {
 	case TRI_CONSUMING:
-		cancel_delayed_work_sync(&iter->poll_work);
+		trace_remote_dec_poll(remote);
 		break;
 	case TRI_NONCONSUMING:
 		__free_ring_buffer_iter(iter, iter->cpu);
@@ -1003,6 +1021,7 @@ int trace_remote_register(const char *name, struct trace_remote_callbacks *cbs,
 	remote->poll_ms = 100;
 	mutex_init(&remote->lock);
 	init_rwsem(&remote->reader_lock);
+	INIT_DELAYED_WORK(&remote->poll_work, __poll_remote);
 
 	guard(mutex)(&trace_remotes_lock);
 
-- 
2.56.0.rc1.310.g51773c2048-goog

