Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8163F8EDE
	for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 13:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786974930; cv=none; b=ZyIaULBfNy0yffKUbviL4hLLi79pK6MRgOe7ZUwN1K5/0knTzWFYiSRNUImCswTslSCOnWMgKC724WQFL89pmEFy2cYz8EAAgwrSoSY4GnDhpPLpREFFxiEGa8pzLzoF2ATwtHgNr6ui7OzzRFowhvWSmcPUYih+/vWc9rco11w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786974930; c=relaxed/simple;
	bh=L+2QAEBkvpfMfvv4BJuh81OLAo05SjYcg1Y1ztPK6nI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YUy7BPQjqoTvXoEh/zs5pTGunIG+W8McJuOplgqL/IotHedXBeD7vRULdx/3ZiN72nBkv69LJzN09Qu03nsHzRE7oWLd1OgltK5fdpUEIHuY8dl2xt93uY/sr2cC+vqb/F06aqtenDbmEOBb/SAr+eWCdx3kT6rBWKYAsUvvwcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oeZI6zWW; arc=none smtp.client-ip=209.85.128.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oeZI6zWW"
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-496b6f97676so35547115e9.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 06:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786974924; x=1787579724; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jQSXH8itKYe9e/GgW7Re1BlgNqyiuWl+Ci4z3wFYfrI=;
        b=oeZI6zWWWiCgl0kCvUQw1NoUgHNkYgSUz9UmqKYil79CG2wbjo4NT1eBQ+lCKYiAix
         CzygsR1bCSzX39nN6/soGipfmTHcaxiTipldAWKt+qbLabK0oPt3/PfC4LHoVWlZz5vA
         qEFGxlQpjA8wEbgNjkdTN9tkfKwlppp/PEuOYgZpp78JfRLxYrNh72zuW1adWv1zDRrA
         qaYlSEpc+6zRgrBMEERP1XPK1znayAx9k+zBTUybhWeY73yR7HIkimE03oOUvdzKP4Da
         SydZT7czsEiMBzsURrY6urgUBsZw2jYyTCUcYfwCFTIANDorzs6FcdMbjpBNo/bJG1tY
         U7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786974924; x=1787579724;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jQSXH8itKYe9e/GgW7Re1BlgNqyiuWl+Ci4z3wFYfrI=;
        b=r51Cxv0nvm7GdFzLirlKRpj0jMBDMQEQDEBuspfcX1sicL7vjPjwjsG2nEex9cmpPh
         sHiSHq6QhcLaGHzUQNEjrLItmfL+9gqtrOM1iG+dCHKzlfXTNqhJuslyrjL8j/enLsY2
         1peovEUq8AK8pSRDQpiLnLxfN3rej+sBc3RnxeqKYejXyHFi+JauqMlwDqQ1dskYZQtv
         IPjDUFvpPlXvh4yDqyiqniqAYxf599UrWN2YjYEhTBqufVtu1ADCuUyHeXN8ufdpFrbM
         oV5ObBHH0tvBMNO52pEdtLZSK1dvjNxWJWFnCFQ3l50rT9rX5Q88e03KnmMqkLrh/xs7
         QZeA==
X-Forwarded-Encrypted: i=1; AHgh+RqlkRq7J/snzg6agGSmevixZ7aF69WZ9BrfXhIs+WuGzyoYuGlSWMYDNgXFniX02WDKuF2bnmdaK16l9u3CIXnR6b4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBJe4UqwCtYTtWswTtHS+imrIjfkSGwMDodW5cnZOd3w7ct5FR
	Y5z07OFTi9ym5fSJ5JDemYeoxmbmJ8zCoGm5pt8ViBswflPCyPzDCDvx2xaRJVoGwQPnQmw64UN
	OninBsmHsHk6ZHpDMWDojPw==
X-Received: from wmcm14.prod.google.com ([2002:a7b:ce0e:0:b0:493:ed72:8dad])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3596:b0:499:8ed2:8234 with SMTP id 5b1f17b1804b1-4998ed286c1mr289651585e9.0.1786974923845;
 Mon, 17 Aug 2026 06:55:23 -0700 (PDT)
Date: Mon, 17 Aug 2026 14:55:03 +0100
In-Reply-To: <20260817135517.3919534-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260817135517.3919534-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260817135517.3919534-5-vdonnefort@google.com>
Subject: [PATCH v6 04/18] tracing/remotes: Use a single per-remote polling work
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

