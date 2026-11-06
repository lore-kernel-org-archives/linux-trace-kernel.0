Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793988485;
	b=vnqUJboxdKX8rs8ynNTOYmsfD5hx7P94yUIIi/Ga7heUzStJrUJe9jydBfcBwZ1Sy6lX
	 lpQYq9rfy1oZb9RtfEo/PleCbK0s7atpjaEpv/QHgC5ruQkEw7crcJR5GHkWZXqy56a24
	 1kIvMSMnvfj1//iBaFjWqr29ICZEo63rZKKrOzkJLH/JAuOgnZZdzK62JQ9t6ObpM0UPx
	 87o5jgLu8iDFpiFiEC367DPXuaxEvAfECVkL/fYWUgqkOdDOfP01OSYZNne1swZc/vw59
	 TIAr+00d2GPD5oy7KyeDrrWt1shx4DmKvBuJDCIz8EZAC//upCKDsKk4gRgWy6s6Epw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793988485;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=OcW0ehiseo0kKW3D8JtxdTJVWEOauFOo1Zzj6IjMz44=;
	b=DY5W/p9BO+TnjOXii9b0EmPbe9dXQhPYvkjFUOpR+RKBIowfKE36chk8eL81yb6xPrXd
	 UxHXwjrSqnKRYLRgRjdLEVZmZbfVXduwQq9YZ5c+59exNmSGoS15AfJRA5nslFIP1Uw1d
	 NCFwVE/47y8TLiczAp68ym6TBSHyImQgS7o/Tu6Wf4PtOWabhP5e/IiLKASN8DHkLICXN
	 G0HjkFhofSQE1ffQu51IlNfvtjZicpNQXomJonJJZyConjVYOD3JEtg8IuD0gxgUbgGma
	 KvD3niOZ86LHpEYTb1ATF5drQsT04eAyfwuSeOgd6ufHj+3oB4/yQF5wwcgxBG/6UgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="J8L/wgzS";
	arc=none smtp.remote-ip=209.85.221.71
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E0D6083603
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Nov 2026 18:08:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55E0D6083603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=J8L/wgzS
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4916bd6e3baso930828f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 06 Nov 2026 10:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793988484; x=1794593284; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OcW0ehiseo0kKW3D8JtxdTJVWEOauFOo1Zzj6IjMz44=;
        b=J8L/wgzSRtmhLZTZuPdVcRu0A4DLH2OlcrwXzeSIZceKrX/d/ufM+Svob43UTOTS71
         l3zRXwS7TrHJn+fe+d3+SNyAPuVbudRM9ZLLFb5XVhrLxGbXrPKJdbQ48saG65LxzGmo
         7gyM9/FMSONvpO+miidiPEEHyYIJM25WqXpJL5Vp74bh2jk227KVhdjgpRF4hJ9KNN6R
         lvBsJUj629+MiuttVPcYY1Fr0kfVhl2XjNO2jLng0bIclcqQkZG48lBxcWRrP7Xl8/0o
         LT8uCEVfV4/lYZCOJHndR3mpsgp3UXwviWLhXJV63Zut86YtA65R4EFEkc3fzcXNjPaL
         0ABg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793988484; x=1794593284;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OcW0ehiseo0kKW3D8JtxdTJVWEOauFOo1Zzj6IjMz44=;
        b=MlZllR6I5Hp6ZtzV51k9/QddAU4om66/JM7TSGcsjDzsOY782IITZyjKt4Jn47XCEG
         J4rdUjo4EamaukUrALRx4OMS/Ar+hVGRperZfHq2aLokfm1WZ/+7ma16MLW8612zD1/J
         TDmJkd6VItJd8jscyY7Oqa4vWr7ChQXmR0lMvLf+kLvYBl/inUiPGxd5YAEh1/w8H31M
         PfNQLd06oK+5ati77F2gDZr1xqBzcWYEZUI1+JiuMR6Gzkjfeq+YIkPyOBi1CtYKtFG/
         n6x6aDWVwyF+M5WvYCzM9vUIFM9SihdcbdAhDFeICpQ6lIlpzyf57oYYQrvS5iTvWV2F
         AvDg==
X-Forwarded-Encrypted: i=1; AKwUvBwE6DDD1xqmK7IceMv6Cz0qFBetb27QPxbmGnodXZCwbpgjVQaFmj7C6fHyToI67PP+saAmXe+elhko8pxSK7oJWI0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+YwUSMfoEPOt6nt7OOFgeKYcKhuXB3lDM7DbsH/tcIQzsIV0fa
	I3bi1Ka8Z8t6UFsUsyP0BPy+XT62eg8jXLD5V70O6HgoLJ4zcGrj9BJ5r6SxO7zWcVY433bsHhT
	EeHrD5xliNMIZgzY24WcP+A==
X-Received: from wmdd1.prod.google.com ([2002:a05:600c:a201:b0:4a1:811f:6de2])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4694:b0:4a2:994:575c with SMTP id 5b1f17b1804b1-4b6e0454d69mr60811855e9.34.1793988483632;
 Fri, 06 Nov 2026 10:08:03 -0800 (PST)
Date: Fri,  6 Nov 2026 18:06:54 +0000
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
Message-ID: <20261106180657.2460376-19-vdonnefort@google.com>
Subject: [PATCH v8 18/21] tracing/remotes: Add poll_ms tracefs file
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
index 2946f263c79c..ebfc2dd67b79 100644
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
2.56.0.455.g6c5a503b38-goog

