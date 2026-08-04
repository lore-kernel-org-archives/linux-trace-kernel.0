Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CCC35AC3E
	for <linux-trace-kernel@vger.kernel.org>; Tue,  4 Aug 2026 14:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785852255; cv=none; b=hUVUphEV3uTiI5KTNPJO92KKHuaVWIK8GCrAVeC/TdbXoYmLol/xqjRuGVgyK6YMJ8jXdb1vRDdcJu3u6fHkBcKXcTECb0ElMptefBGRwknYAB2UifERszi5YsKhlBNDecVlEg5GpYC3v0BtP0KJSTyHTM9wffVhWh0WeA4HmyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785852255; c=relaxed/simple;
	bh=Rsr0i0dDdJIYNoD8Z03LDLqAh0hp2erPBukv7STbabg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qQRwYBHlD2ps+Zck/lnrNmOHsQMRDoq6LneaCt3NGf6gG7xsv+SQDyKw7fUEoINg0Ug8X6dATQ4/y+iw3XnJE8LmmLY8lPCCJqA6DWnrh1bgtw3x8XKUgtvxbDO0+AvSOWLOgczwld4dSZFfT8gWo5HkQ0YiJYzaD4RHQFqDXEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k5w2IdmD; arc=none smtp.client-ip=209.85.221.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k5w2IdmD"
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47162f83c75so605304f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 04 Aug 2026 07:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785852253; x=1786457053; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aHqNy0wjPtzBzS5QIsFKiwFAmxFzEHWqj++yLrbz6Yg=;
        b=k5w2IdmDrQ7IsoVC9bjzf7AwdCSCkWaEnuNEu10xQ45/sGltbQ0Ody8ocx0fCPOBtf
         PhIRMUZ4SyS6tUPDJfDLiOXCNc1vi/jiY58e/YjqyeFY8/HAtcwCz6dcW8vAbDiiTEFZ
         17gBoCm05Nnk9h1VwULCdS1VlfPrYZMgyzX3FpnkfT6x8Wy7ZymWWqf+yytK6X6Wma3o
         k+/RvnVhwvDp0mEGstltaU4KZaVBdkWGKxNK49NcLgC8mzgyMoKn3d9aDsf365Cpq4dQ
         UaCE9VpsKbdhOfIdWuXjGXQafVp35zeLQpkRX033B3N+MvreKXjVKxvZWh7MD0kD1YSt
         lG5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785852253; x=1786457053;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aHqNy0wjPtzBzS5QIsFKiwFAmxFzEHWqj++yLrbz6Yg=;
        b=kXic4Ljsw2MI2CMlUogClIjmVZ6kzdGEYlf1fsFY6exLjwSlDCvmcb7inLWcsWcot3
         ChDHqtGWCCWtwVoq+kerwskjM2C0Mwtj9yO8ozUsg02UlRSMRsJZzvV/z0cuV31sGl94
         AAi8bR2Rd9Oa0LGSOA9+Q5Jrc1c50rT1Aht4ZvzOD6AMF0hhSwmrRzQbn+PnHyR3UVjL
         Z7l3T5bHzz+UVsktruhDnlvlI/pSw3/rI+lezrgVsUeZmVTy/3cCIUiWX5oBfeGdj6ji
         slJ0Ybri78ZDCJsPX1pS/v81r5w5C4+9OVVe1hv8GNtaMoEBh7kN8kHZiX8oYHwa9H+s
         0wQg==
X-Forwarded-Encrypted: i=1; AHgh+RoSrLdtaPw2xqHfjOhi3L01ULqEXoeUVs8t0C7v0be8Dz9ArjG1HwVZiUdO/Jvt+1hquUQHT4Dc0TBwtN53mk8h1pA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIhILyGG9nnQlpo4FC/mceFGyebyi/m9+xKdaoXm1ndDqmh8e3
	ml8qGCXDhzUpNZbbm4wuC2R2F03COal7NpuyppAyiUKlU3VbGz2LZxFu+JsBlYkr7B6dGpBDcbr
	977eT//BtySh4ZI4+HHpsMw==
X-Received: from wmej10.prod.google.com ([2002:a05:600c:42ca:b0:495:66f2:4250])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1d22:b0:495:3c6f:7c18 with SMTP id 5b1f17b1804b1-4994a0f67e5mr83424055e9.3.1785852249644;
 Tue, 04 Aug 2026 07:04:09 -0700 (PDT)
Date: Tue,  4 Aug 2026 15:03:30 +0100
In-Reply-To: <20260804140333.797210-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260804140333.797210-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260804140333.797210-16-vdonnefort@google.com>
Subject: [PATCH v4 15/18] tracing/remotes: Add poll_ms tracefs file
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
index 9077b488e584..ccdac9fa106a 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -1135,6 +1135,40 @@ static int dump_on_panic_show(struct seq_file *s, void *unused)
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
+	remote->poll_ms = val;
+
+	return cnt;
+}
+
+static int poll_ms_show(struct seq_file *s, void *unused)
+{
+	struct trace_remote *remote = s->private;
+
+	seq_printf(s, "%u\n", remote->poll_ms);
+
+	return 0;
+}
+DEFINE_TRACE_REMOTE_ATTRIBUTE(poll_ms);
+
 static int trace_remote_init_tracefs(const char *name, struct trace_remote *remote)
 {
 	struct dentry *remote_d, *percpu_d, *d;
@@ -1167,6 +1201,10 @@ static int trace_remote_init_tracefs(const char *name, struct trace_remote *remo
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
2.55.0.571.g244d577d93-goog

