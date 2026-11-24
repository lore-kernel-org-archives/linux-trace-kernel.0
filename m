Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534179;
	b=and/CMasqTE98v4L4f78e8Pzw+qAqVM0A2YTdMdX9d83nOs/b7Am8S8Lq8jlw2xkJyVR
	 YcTHw55TEzynmtFvo7mXSDq1INjpJyb5/d2GShUtgB4mSy2yhLjJudaIah4iLRzNzkyCT
	 P3OZRGDcB2MuBQNBC5ctRalMLtbd1n36BdxMS7lqV0Hh65Iuuhxg4syTxunMrED5PFDFQ
	 s90W3zuXDXpEJDKbXo1FTjTbY3C9WKml8mY4LyRzgzk8sc/O32LYfOx1rNEMpg8Uux7Sp
	 zoP4rRfDSuvuUcBrIAAK7nQ+225dQL/V3+Dv15RBBAtI20s0ymLhE1BUC/TGRdMqTgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534179;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=T5hheb2oNnEOH3DX/CJK6Dfr7i5urP5k3HJbUopSOI0=;
	b=Vgyjq9slyuRIl6MspdDFqv1/yW9cYeqXxu/d/clMY8ux9u2tGKjrZYq+rk+v9fM+PtuI
	 r0ZfNxc8EmQszuV6y9vpshEJbzRbCWIZ2BtQgpRyThfb0hBEwN02/a7VhVOPCEX+f/aha
	 Ax5+zUxpPYzdXF1C9VtAp8vUMlAF0siBL6spLEZO9MnS8Kxojps2YUJsnHqC64a79pt4B
	 AFd6gikws6kGQAaRY16tRlQyAAlDah/a0nbgbyv3pr6RQBxaQQyWTNaSFkNuC1BI0mgXl
	 /+Jn2eCSeZku/fBIM0y+was2ZaK+6tmZFj+HVp/22WxAhhZfoXZafb/VxcoynSoy5gQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="isZ5FZ/8";
	arc=none smtp.remote-ip=209.85.128.70
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A2D60A5BCC
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 15:29:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38A2D60A5BCC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=isZ5FZ/8
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4bb8ae35aeaso39047225e9.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 07:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795534176; x=1796138976; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T5hheb2oNnEOH3DX/CJK6Dfr7i5urP5k3HJbUopSOI0=;
        b=isZ5FZ/8GuSa7ZeBkNcvH5h9mrgjoht8REkJmQRa7rlwozc9AYBm3EcmJNVcV5z0De
         T4Kp3xLuXT+VDwYfHHYwFX069bVa3nr8cD9BhA92qos6EauLVrKE9L1Oq/YFmGXDnb4K
         rz+ha89xgBjaazgQKmsdNtb7Rw0hl6aqfOJSlJdd+DyrKguJhlhb4QrpmUfsi2qdZiR2
         JhTIeCBNbpbcLh4KXepdlfzLwAJKC7GiA8wFi1nzohbuw5RsI4zbS6zPSQBjoLz8vHD8
         sdVescINrjgDgWFZuHH62pCWW+eRPiAD3o5DdFjFwkpYuU/C5bOWur9N/biX0+LZluzu
         GD0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795534176; x=1796138976;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T5hheb2oNnEOH3DX/CJK6Dfr7i5urP5k3HJbUopSOI0=;
        b=2si1l1cYfdApHwOuBmThi57jkJuuW+FP9seMgOF3BLNcJDRPViaUVEnCl2Q1i81IUJ
         VZ0Oz13mlJmkG7C6xwEMYEQJeOkTiiKRjuxWFwp0ClyzOXHK3UqAdo9bf4tC5Xmy/fUM
         UeQKVjUHayW7zJG2gQlUVmpoftJFbIIkzQLXbvI0h2JsdEhvbJ3GkxvI/XO4U8ywSPmW
         6IpnsqXvq00/BJnA3uc4LLnMi9zjvMVJ9lUbrE1BlXYh0Pj7aSlKyig/YyW/TOl54Ek2
         /J+Q365J1A9lblxSlJNLnCJ8OYRaLC3jbeutH+kUlssIOhq5YF84UNhNignA78pe9hs7
         s8tA==
X-Forwarded-Encrypted: i=1; AL+hErEYvruSdjn3sjiNhad+KhS7C7IEb5gkhFQ9dKUQK+CXDFeiWOMzJTjQpLaE26bATkIlicz8r84d7oYNrXZgIgwH7Tw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+FMxIBHbY+GCSrNlmSawcbTZ05UoFK7drDh87idfmtGWgjqtUX
	f7jEzzY21AAaqE/hdSxw9nZkeR8eydNY1wPddzIXOYsKMmlt0bz6l35seh8UtyLvWgXcT0l+84Y
	CX62p5VYJA/BkD1pQM1kqUw==
X-Received: from wmbz10.prod.google.com ([2002:a05:600c:c08a:b0:4a1:8bbb:59bd])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8184:b0:4a3:5a7b:6002 with SMTP id 5b1f17b1804b1-4bb8881e969mr287363775e9.28.1795534175885;
 Tue, 24 Nov 2026 07:29:35 -0800 (PST)
Date: Tue, 24 Nov 2026 15:28:42 +0000
In-Reply-To: <20261124152845.2233401-1-vdonnefort@google.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261124152845.2233401-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261124152845.2233401-19-vdonnefort@google.com>
Subject: [PATCH v9 18/21] tracing/remotes: Add poll_ms tracefs file
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a tracefs file to configure the trace remote polling period. Keep
the default value to 100ms.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 kernel/trace/trace_remote.c | 44 +++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index c7d33cb3d37f..0a899ed5b34b 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -1137,6 +1137,46 @@ static int dump_on_panic_show(struct seq_file *s, void *unused)
 }
 DEFINE_TRACE_REMOTE_ATTRIBUTE(dump_on_panic);
 
+static ssize_t poll_ms_write(struct file *filp, const char __user *ubuf, size_t cnt, loff_t *ppos)
+{
+	struct seq_file *seq = filp->private_data;
+	struct trace_remote *remote = seq->private;
+	unsigned int val;
+	int ret;
+
+	ret = kstrtouint_from_user(ubuf, cnt, 10, &val);
+	if (ret)
+		return ret;
+
+	if (!val)
+		return -EINVAL;
+
+	guard(mutex)(&remote->lock);
+
+	if (val == remote->poll_ms)
+		return cnt;
+
+	if (remote->poll_cnt)
+		cancel_delayed_work_sync(&remote->poll_work);
+
+	WRITE_ONCE(remote->poll_ms, val);
+
+	if (remote->poll_cnt)
+		schedule_delayed_work(&remote->poll_work, msecs_to_jiffies(val));
+
+	return cnt;
+}
+
+static int poll_ms_show(struct seq_file *s, void *unused)
+{
+	struct trace_remote *remote = s->private;
+
+	seq_printf(s, "%u\n", READ_ONCE(remote->poll_ms));
+
+	return 0;
+}
+DEFINE_TRACE_REMOTE_ATTRIBUTE(poll_ms);
+
 static int trace_remote_init_tracefs(const char *name, struct trace_remote *remote)
 {
 	struct dentry *remote_d, *percpu_d, *d;
@@ -1169,6 +1209,10 @@ static int trace_remote_init_tracefs(const char *name, struct trace_remote *remo
 	if (!d)
 		goto err;
 
+	d = trace_create_file("poll_ms", TRACEFS_MODE_WRITE, remote_d, remote, &poll_ms_fops);
+	if (!d)
+		goto err;
+
 	d = trace_create_file("buffer_size_kb", TRACEFS_MODE_WRITE, remote_d, remote,
 			      &buffer_size_kb_fops);
 	if (!d)
-- 
2.56.1.809.ga0b61035b5-goog

