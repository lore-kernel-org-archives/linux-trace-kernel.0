Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE5548A2AA
	for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Jul 2026 10:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784630189; cv=none; b=mMUopyf5+B3e826N7cWhOocKWz2uRMguiIuOqFCxBUd2iF9erBTDXDwLyAi/D7TST0dBUGaB7KCv5Be4rmijnS6Nsv6Sef9AN/k507Rmqkk+jKwpxol4hJdqPEoZamS/htfEA35AxJAwUmCVAN5UpmqfslMnW3oELX08/fQjl30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784630189; c=relaxed/simple;
	bh=eNvMobeckHummo6OuRU1yJ1V7UEVB0TuMql0oe3RVBc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JgC5LvMPAq6T+FUv4E4e2g/a9l9cCWX/bA9bh/Bc6ozpPQP8slT2vh2KGwkhJRq8QTElzaf4FTWqjPA+0UN3Iucqs4lUoa4B4HEMz5i9XtWnEY4XqyypcDqH6fRSo4HbjJB9FBkxdbCta8/AQFk2C93R98z64XNCogkfog9HbHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kw8W/AT2; arc=none smtp.client-ip=209.85.221.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kw8W/AT2"
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47f835ac1aeso38509f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Jul 2026 03:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784630185; x=1785234985; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KyvHAr0k6o95tnwTjqs59suhUZJ5rFpQdbhaJDbut0A=;
        b=kw8W/AT2OX571l73/Wpo55mt4qhNl9UiSoL0CJt4OymwizsQzh5ni7MmoGyBMb3Ha4
         R0AX8Qh43eAeolXOxrqGgVZ4BIz0TC882zT0NlFYAUP/XFk8vH5gDVgQNmUqOLkaHrlM
         WiDXo/g2WIV5wcD7M3SWX1Thb3KPLj4j7iIsZOL6EbJREkDfWH89mmVWWLW/bk/UGzfn
         nIaWEVo0I5mFRT2aFEYdxteywY0++BeAZH7F9dbehA1Df071ZPl1He6UTsQlhykL7w01
         28lYB/x5YEf9oHX3F+Vt9OzwftgecBRtmTPMiuIGkf6dKhR+ho25rT2WUU16EU8H1P26
         vvfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784630185; x=1785234985;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KyvHAr0k6o95tnwTjqs59suhUZJ5rFpQdbhaJDbut0A=;
        b=Dbu+XKg2CENBssi8De0UxqyIdEUQPWJm3Q8tL3Hk0fPYkKRnwkM6DctUsXb4+2PBca
         U3XeFQHO7NTjzA7bb0kr4h6da7N2smANJUsXB7FguNs55Z26ZgX7YWOlLrSBIOXc22g5
         hT0Yw+o6RUl0KX+VlPqGvx0XA3PXgAWxAA4VWJ9AfvIrNLTCh99jeMUQKThp5rtnTpL4
         vCg1sFgoLj42qlcrpSTDavTDFFLJGBhmOZsPL6OvUL3ihJeE5LL83pSyenjk0THlSBqR
         wQQsvqNxqGmoVAfPCACUHaRbMpEkBhC3ejt1ovvTOU3ucKvNVBEYKmq91MZDXOBGMWmG
         MGsA==
X-Forwarded-Encrypted: i=1; AHgh+RrpjOC1v3brgVNy7aP2Ef+HoVWJlMbX2EdSSwoK5WlOVb5J5XqP1wPPPR/aux7u02KBXAApwEBlqjwHsDmcQgJXcJk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1Yed+ZfV+iBNjy/oPff+ygzpIjBQVSzneDKkv0/6rUJEq/V7K
	vWOOM1Gc6FGN/mWeGFBCbatzk2t/r6xufB44yBSr7yBIr3OW5v559YMZM/rrkru0Q6xLqxwbsYb
	MNcwffW1EZ4c24lvx9Uh7AQ==
X-Received: from wrbdd29.prod.google.com ([2002:a05:6000:161d:b0:463:5fb:6441])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2083:b0:47f:5d5c:1ca3 with SMTP id ffacd0b85a97d-47f623052dcmr20416496f8f.8.1784630185093;
 Tue, 21 Jul 2026 03:36:25 -0700 (PDT)
Date: Tue, 21 Jul 2026 11:35:49 +0100
In-Reply-To: <20260721103603.342266-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260721103603.342266-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260721103603.342266-5-vdonnefort@google.com>
Subject: [PATCH v3 04/18] tracing/remotes: Use a single per-remote polling work
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
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
index 94a52445cff9..3af622c94784 100644
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
2.55.0.229.g6434b31f56-goog

