Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793988470;
	b=H87W3VuToA26rXlP3nSoz+jxC52MW02jV/pUVOhJKzN9oVVbBbVr6zl10c3ySRBHs1qV
	 Hfappj1mHmyxx8Raez9euUdbnqUeq8Y3t5FUVChYsBp9JW4YAWTf5t65ZYsxQtD99M32/
	 WFIHbAZCBMsYN6BnKiQVUH2HEDM0fvdjzezLlsg1YCUXlScDECgcqG8YBygO+vO+PFd+i
	 lwQgsRVFL1PHSNpsQqPLl3EPwGA8ySUPYoF8H9QkBcIgd8jZLlDFn9H2XlnkOI8YUlDJM
	 f0hZmQsWCcOhnXP1sweuGtnPWMKYluOAHLiDUhNZjRklu2vleMl8YLUqIhI46vK1sLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793988470;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=eIuOB+R74nHFqJL84M+rPTd8vIKzgwcyRKbdbMo64WU=;
	b=mjR/Ft9Mz7b7tJlkEr8+JA6fgCslSWJTUZiyNfzG57+cAlgW8YnJzfUPcmlU4JSAtQxM
	 ArFeGNn5clMQoWwJnGTYzST40b9bgJO2PRz3Dr7pqykzTpDq5w/4CfEK1XpjumAmfzRYO
	 Z5uTJuVQ49Xvjis40NMcIRKecbhefLoCjscZ8JOsO9KsvUolejC86KbnNo77IgksUngKa
	 52+tAawU0Wwj6wSHlSDOW9rq0tQbU2vyvNNIHkGxmMHs/E9FaO1ke9bDQbGYB4a5/PVxz
	 GUySMRMyLPHrqRFPuBmqfAG6kp5NzMuOdIYFnT66+wiNoDrjR4BjIUHpPQPW8rWfaCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=YFMmjH8a;
	arc=none smtp.remote-ip=209.85.128.69
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222F9606A332
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Nov 2026 18:07:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 222F9606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=YFMmjH8a
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49953abe51fso7315705e9.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 06 Nov 2026 10:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793988468; x=1794593268; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eIuOB+R74nHFqJL84M+rPTd8vIKzgwcyRKbdbMo64WU=;
        b=YFMmjH8aOUAp2cfdMCJDAikey0Sb8xnQQulPm4dQp5tv/KoZAOAxMDDGyAwcMmNYzt
         DJeildY4n5Uzh5rDXcqpi8jFsfC9bHFVXhE0eO5F6lLXmxvVPgUOWWtkN37je8ZwaCW6
         S0c4nfcY29QlFPScNJGHHvjouNrwgSsIo7nsW3Qvwm92cj+2PmYCnh9AiqfjCdBVubIx
         UtCtxnTHPTuacQQ0WCXKIUpMxp4lzkmes/HL4YpS8EJk2KBaC7xwAiSCpYzmJim5rqGt
         UMJ/U1HgbvBOcjET5Hs60gSE8RmxjLwPBMpXjwKwzBc2OcrnR/ZNl8xA6otLMxZADWDQ
         HwkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793988468; x=1794593268;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eIuOB+R74nHFqJL84M+rPTd8vIKzgwcyRKbdbMo64WU=;
        b=JVEiqBQ2h2seV0r5CsYsWtdof+Rk2YBsWMAPKZQZS7QbAnZuuhNAklAg4+b6oN41zn
         VvfuY0sqFoGCai5KaCT8XNRFL3R4ADq7tDkNuVgw8XElmVl/xrGIy1zPHyaRkj3Id0zd
         /Yl4t1sZBgzEkjSb/TR/6B4aSGHndKT8xnianqPhDhopgCDJiPzIrPtpjmeV+E0Pwvlu
         y+i2o1Ry7oSY/1XDKcG/ReCSLyF57c2qJYar9dNYTdymYcaP647mM563RPnr4kOJxCOl
         41PnTIxt2ZxGul5vdbGos6mC2ptLRsMGQHgulIkNiAIG8+fllNxR14bEXr7RArJgDke5
         SLBQ==
X-Forwarded-Encrypted: i=1; AKwUvBw4eFMXA37qHt5k0jr/aa3DRF9EWEXcK+3Gt5cQB+KJoZx5K8ZkbJ7xxkBWj1K6BlHNI9i6RlkYz+fdaRBDWOJgbEE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9u8JEMFVvi/vQi/MsXEWxmN5q0NzGAUZ5OmFleSFTKla/C2gzZ
	+fPZLOfwa2GEE4pYqh5R5JoiwqDkWkvkLk/rC8RVYmM0Tz5nqd1Ky2y5qJ4pQwUEMgw+ilaeLlA
	c6/hsJLKvd2HmBE3Hygf/RQ==
X-Received: from wmbh3.prod.google.com ([2002:a05:600c:a103:b0:4a1:d8be:ba51])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:609b:b0:4a1:cef3:fb3a with SMTP id 5b1f17b1804b1-4b6ddee327bmr58744495e9.9.1793988468304;
 Fri, 06 Nov 2026 10:07:48 -0800 (PST)
Date: Fri,  6 Nov 2026 18:06:41 +0000
In-Reply-To: <20261106180657.2460376-1-vdonnefort@google.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261106180657.2460376-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261106180657.2460376-6-vdonnefort@google.com>
Subject: [PATCH v8 05/21] tracing/remotes: Annotate remote shared fields with READ_ONCE/WRITE_ONCE
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

tracing_on_show(), remote_event_enable_show(), and buffer_size_kb_show()
read remote->tracing_on, evt->enabled, and remote->trace_buffer_size
without holding remote->lock, while the corresponding write and cmdline
functions modify them under the lock.

While this is unlikely to cause issues in practice, annotate the accesses
with READ_ONCE() and WRITE_ONCE() to keep KCSAN happy.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 kernel/trace/trace_remote.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index 317ba3124343..a677b093fa07 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -136,7 +136,7 @@ static int trace_remote_enable_tracing(struct trace_remote *remote)
 		return ret;
 	}
 
-	remote->tracing_on = true;
+	WRITE_ONCE(remote->tracing_on, true);
 
 	return 0;
 }
@@ -155,7 +155,7 @@ static int trace_remote_disable_tracing(struct trace_remote *remote)
 		return ret;
 
 	ring_buffer_poll_remote(remote->trace_buffer, RING_BUFFER_ALL_CPUS);
-	remote->tracing_on = false;
+	WRITE_ONCE(remote->tracing_on, false);
 	trace_remote_try_unload(remote);
 
 	return 0;
@@ -250,11 +250,12 @@ tracing_on_write(struct file *filp, const char __user *ubuf, size_t cnt, loff_t
 
 	return cnt;
 }
+
 static int tracing_on_show(struct seq_file *s, void *unused)
 {
 	struct trace_remote *remote = s->private;
 
-	seq_printf(s, "%d\n", remote->tracing_on);
+	seq_printf(s, "%d\n", READ_ONCE(remote->tracing_on));
 
 	return 0;
 }
@@ -281,7 +282,7 @@ static ssize_t buffer_size_kb_write(struct file *filp, const char __user *ubuf,
 	if (trace_remote_loaded(remote))
 		return -EBUSY;
 
-	remote->trace_buffer_size = val;
+	WRITE_ONCE(remote->trace_buffer_size, val);
 
 	return cnt;
 }
@@ -290,7 +291,7 @@ static int buffer_size_kb_show(struct seq_file *s, void *unused)
 {
 	struct trace_remote *remote = s->private;
 
-	seq_printf(s, "%lu (%s)\n", remote->trace_buffer_size >> 10,
+	seq_printf(s, "%lu (%s)\n", READ_ONCE(remote->trace_buffer_size) >> 10,
 		   trace_remote_loaded(remote) ? "loaded" : "unloaded");
 
 	return 0;
@@ -1131,7 +1132,7 @@ trace_remote_enable_event(struct trace_remote *remote, struct remote_event *evt,
 	if (ret)
 		return ret;
 
-	evt->enabled = enable;
+	WRITE_ONCE(evt->enabled, enable);
 
 	return 0;
 }
@@ -1140,7 +1141,7 @@ static int remote_event_enable_show(struct seq_file *s, void *unused)
 {
 	struct remote_event *evt = s->private;
 
-	seq_printf(s, "%d\n", evt->enabled);
+	seq_printf(s, "%d\n", READ_ONCE(evt->enabled));
 
 	return 0;
 }
-- 
2.56.0.455.g6c5a503b38-goog

