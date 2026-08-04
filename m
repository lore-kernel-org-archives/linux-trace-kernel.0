Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C5646AA68
	for <linux-trace-kernel@vger.kernel.org>; Tue,  4 Aug 2026 14:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785852239; cv=none; b=KUJ1LB45RbnQDwK6aMcbqB4YwytYeYSRZKVj8eV8Sb3M19Nvbd1wjuUhbyaOpl3m3t9jg6cog5Eo894NrDar6buVSfkxeZoDwiCqdUBqhuUW9m6OGBt0Fz3vyiG1ibN27H8np0BZxfI4AvtZ2DQi4I/KqKxRltjX/28tviyObBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785852239; c=relaxed/simple;
	bh=L5JRax/Ua82X6j63LO+lvW8VhcERufC2scn5SQbBwZA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BS5ug34Kw5zRJ+U2Lx538j/BLbu19ztQX6jKlt9tC4y+CcyxOiBcJYKo0hv+3QwLDJp3R4NtG/yQVvogz4/CjTF7rKMKdEkw+IFFl15N3pRhbEZmDg2ewLBVXdagt5TsDYGnyi1JGOQYY1KDSJIFTBotryMWpSn5U6nwPIEc1Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A+9w1D0S; arc=none smtp.client-ip=209.85.218.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A+9w1D0S"
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c160e8957d3so356013666b.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 04 Aug 2026 07:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785852236; x=1786457036; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M/eUXOr4xwu+PVo8V0TxylW9p2T6YW4ZMsAfFTF1o3E=;
        b=A+9w1D0Sdg/EPds7ppMKZIBI8SIwNONbYXyqWqTAdwXLSXu25cO0atCdNj7kKBgcbU
         I+ZwueGUNrvukR4D8I4ddyWU8ieEC3QwzD69zEd+bi9+3kljmM1cS1UehXb6eCGwv8cg
         LjdjL2oOsiTF5qwjXPi0zTaoYt3tCvrgtjdP9Tmqr4+6BQtBe7BsEqhQLmqpD/0uvBjb
         T6xuROUnbym7l42omG5wpd4r/tDDGyXD5irCjm/R3Uv/KFHyv0ZwCee54VHu41rxqqCq
         eMrTehON62+TfmZ3kBtIHsDyBtF3eqMnB35PI0iwOPp9aCo5xVRolTztF3DrcAB5D5jx
         5P4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785852236; x=1786457036;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M/eUXOr4xwu+PVo8V0TxylW9p2T6YW4ZMsAfFTF1o3E=;
        b=XKh7yl+/RhtDWFPv9oWs7lV0u5pGH/oNYRYP3znayHpoeVoNUObTHHG+6zkz9jB2Pj
         nOnzw+z5cmjqjdbl7w0DK76t8TIAOOtTzXrBNfymXiFzRaoqPXu+dMyT5xoo0iLtyn+U
         S/giTI0IaIm+hQ/Wu/uI3GxCTSe1kirpqSsw+5ivd+/6KGuAr9GTRQLc4w1MCGuSkvQS
         MEKTXhAkZFPWxXcal+859oCoT6NrjSFMHbsoTtciZaU/y2DD3fKEq5eMYVjPDBoBb4uh
         ADdez5QcZgaWbxQHY+zZxGZ1bvepJxn818w617INLO7JSmMScTrVa1UrsTc/BoX/fxIo
         li9w==
X-Forwarded-Encrypted: i=1; AHgh+Ro2y4U9uy5W0B71LL1AcBWaaSok2a2a6lTOuVljKrd+dbSDYIIdJ1LmkJaO0mhi57pDmPwZ+cyED+/9PvDm3uDH1NU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6ppmnkzzlnT/FiKt5omsp4huYv++HSLlm+lmNszk5+w7usXSy
	E3mjRvdkDPtizV2pASBd3VV5UlSLlgDNFS45JR7l19RKH/lMFkUVnHFoVsqvFsCjmCh8ZC8VVyq
	wCxutOnk6u3dE9v0D1tf0Ug==
X-Received: from ejai9.prod.google.com ([2002:a17:906:1149:b0:c12:acb9:8d47])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:6b0d:b0:c16:14d1:b529 with SMTP id a640c23a62f3a-c1fe7ef4e2cmr1067353066b.18.1785852235934;
 Tue, 04 Aug 2026 07:03:55 -0700 (PDT)
Date: Tue,  4 Aug 2026 15:03:19 +0100
In-Reply-To: <20260804140333.797210-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260804140333.797210-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260804140333.797210-5-vdonnefort@google.com>
Subject: [PATCH v4 04/18] tracing/remotes: Use a single per-remote polling work
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
2.55.0.571.g244d577d93-goog

