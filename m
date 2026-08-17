Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F409A43FD05
	for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 13:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786974945; cv=none; b=ni0CEApX3TgdGUOsfyJcD2QzIs0O2erYiPlq+4PNd1OeTV116UdOvF6JUgJSSiCmDy55TE6iPENK0Esuk3hBuTHheWQsZzrAaEYL8+ixpLfDVNwzn3KeHRU8xNzmVHKMnIwZ1pbd/+Ytjdfeu2by/WXlVKU3hU0mdlI365uNiHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786974945; c=relaxed/simple;
	bh=qvUAtkhlVHecjZayHyKAMbQyCbva4L5NN4803pWTYdw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=av1F9eheKbmUjEyesY8i3laL0IOFP+jeibG3pqr/FzuYvEWjdse0tU5yRFI9a3LM0fGbNHU0c44KWF1zZBmvv8HF7dGwthJ1SSYZYppnKi9EuJZXacKfX46vq2tSrgLhysHc+KNl2OlDA4qvmrobxnl4Ql2yZoiGLE25ZNk9hD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vIoWWLDT; arc=none smtp.client-ip=209.85.128.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vIoWWLDT"
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4957287363bso20675165e9.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 06:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786974937; x=1787579737; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LNqvtCq/uMgXx2zwNqvBGhcYIw2tCNo7KWfr9c5oNT0=;
        b=vIoWWLDThSsX6Xd2QGxs2IU3hHq3d2b3AI1oIYjz/F2ncpeT/vRiwZ0n7ZcyjNnTWJ
         xXtgOinBtCemv76hGcRQuyMwBtuvvoLKYsYozE9Y4vi/izVanFG0sjK+6SP5TV/Mik2q
         Sgx3LYqyf7Too6A9LQL2BEpY/jkqQR3vChZKRGd7hO9VM0juxrwxPnUvlLra0yXqaTlL
         qCdkYY7DOJtYmw2a/8fa5alKtKD+G7nLp0N3pSgd9OudkvxiQAilc3GQ84/XLV0gjEIk
         Qvd1/jXry+OsM7aeHZA0m+jGiWAXxzH4oW5teD7cckpUN1Slbziwecz/5nrHEoPSJRDQ
         cniQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786974937; x=1787579737;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LNqvtCq/uMgXx2zwNqvBGhcYIw2tCNo7KWfr9c5oNT0=;
        b=Ig+RjOMZphSKsi59bjthIo/lZNO5zgm8ThGfxZ9IpAtTNZqDgUZRl72GQZ/ilVbjYN
         GlMhW+rE5ODx6K7mwCzN1xzo9g4euR/Qx4euvfc0/FNo1WXKpsyU477tG8PfOd9kTxUM
         oUatknsAs/NCb8GeH90tBtKTij2tvtxRDkObvc/12plPsiWoOiG77RNEbJKoXPjw3TUB
         J03Uy4aAiTiDp+itG2EPk0hEc1jSxdAduOsWtszYhlYOWjo5HGOz4LFQgTvdldvG00vF
         5I3dUXd9W8arR55pwJU3qu3/vj60L7BgJij9BI4UGjEpSxyni4fv8N07RaUY1MYvYvhc
         yUCQ==
X-Forwarded-Encrypted: i=1; AHgh+RruNY8stcEVtE9m4ai1XMkjcfdHFC/zS0LtBywxgKD53uT1VTbXs/B87KbqGhy7zfTtZtK+d0DxQ86j7to3FoEPnxc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/U1QnBJpt5AhthC3tsMflpiGDW5tm/rALw9xxKCUq/UfVf/KB
	9+jYiqyTyv1pyhzP+GELxdvQDX2y8pDMsLtVfHl9wbqbkZ+Ef/K19xjfLuSAiIoUFg2MJ/tdL9k
	QXopk5EqfnljReTOBITfWLg==
X-Received: from wmbfl22.prod.google.com ([2002:a05:600c:b96:b0:495:6902:b647])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b1d:b0:499:79b9:e226 with SMTP id 5b1f17b1804b1-49988057986mr375957705e9.0.1786974936939;
 Mon, 17 Aug 2026 06:55:36 -0700 (PDT)
Date: Mon, 17 Aug 2026 14:55:14 +0100
In-Reply-To: <20260817135517.3919534-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260817135517.3919534-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260817135517.3919534-16-vdonnefort@google.com>
Subject: [PATCH v6 15/18] tracing/remotes: Add poll_ms tracefs file
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a tracefs file to configure the trace remote polling period. Keep
the default value to 100ms.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index 5536e0df4379..204d5bef7a8c 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -425,7 +425,8 @@ static void trace_remote_do_poll(struct trace_remote *remote)
 
 	ring_buffer_poll_remote(remote->trace_buffer, RING_BUFFER_ALL_CPUS);
 	yield = trace_remote_do_dmesg(remote);
-	schedule_delayed_work(&remote->poll_work, yield ? 0 : msecs_to_jiffies(remote->poll_ms));
+	schedule_delayed_work(&remote->poll_work,
+			      yield ? 0 : msecs_to_jiffies(READ_ONCE(remote->poll_ms)));
 }
 
 static void __poll_remote(struct work_struct *work)
@@ -1135,6 +1136,40 @@ static int dump_on_panic_show(struct seq_file *s, void *unused)
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
+	if (val < remote->poll_ms && remote->poll_cnt)
+		mod_delayed_work(system_percpu_wq, &remote->poll_work, msecs_to_jiffies(val));
+
+	WRITE_ONCE(remote->poll_ms, val);
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
@@ -1167,6 +1202,10 @@ static int trace_remote_init_tracefs(const char *name, struct trace_remote *remo
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
2.55.0.691.gc56d675ccc-goog

