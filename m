Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCEB47D92C
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 16:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786551244; cv=none; b=hgNkzyBlD6ZZIdKK4DTC3sQrHB1JTE1NNBIwYZ1ICCLRCGkIemBLfPEjLXN+UlOefHguqG+II8bPTIGerNuawsi9agjA0kx1BzY2/riTNAluQy199slAxWMGlEVoKgXoXsFvkGk0sSqSZHxvhz5XAA64KKD5Ii/lGTH3L2dSeAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786551244; c=relaxed/simple;
	bh=KQXYG4dQLmajubphkjzm7faIARfFOt3a2ixF3t14YKs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Xw50/cCKv79aR4mPOdN3i9hxwKqnbrHob+d9NyvITcjSiPoCx3gxI9tFSZqsQZ7p+BPrz2Jmv2Am2/JMfa4d8ezjlrk++K2AJK0JNacQieId7yQybjdsu9oS1f/IMJ/xU1bOhymoe8/bvuelwA4nU3S9C9/7LdC52qlhdQySRLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l0Z4bOmb; arc=none smtp.client-ip=209.85.128.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l0Z4bOmb"
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4955fd77c18so7900075e9.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 09:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786551241; x=1787156041; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e+GVxKyuJSQs8K8X+QmDjnrEoeu/d32uCTwHE/kG2+E=;
        b=l0Z4bOmbBE4mBgu2ffl5PfT4guysdkzQ5X5DS0EE8/vnedSKSjfveQXAF4St3pnpEe
         r6WxC5Xr7BDcSx88G93/SCRJBxM+9GH3fvqEsNQuL9t3MEpRqGXEl27pS//AVko2U3FT
         2OKwmnWXkNGKOcBgmocB00HpboYyFdOKbtRr25FRKFE/eODWT/owOotvXn8lk32i4/Hx
         Kc9fvUQLaLbgEp9CJXYbCEt7/LpJ7kkUGz9orgs4GVAnQokvW8aqFFZbagYpytU/hjmj
         g59c7D8UI1ELnh5V+EF1T+/tVyt6/NTMLVl48QsU9fJNRi1k5GKP++Mv7GRw+PqRE17Z
         ozeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786551241; x=1787156041;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e+GVxKyuJSQs8K8X+QmDjnrEoeu/d32uCTwHE/kG2+E=;
        b=tNMTN86IMXvD9H/C9OxgfHbjFkf9YEW1fbEFW99Vp9RqBQluiYz1BpcXo+07KKFUVK
         iCPizmDgqm26CXdUMtGfQ7oCPuwabDIys6umCbg7ipRKQ31Dk+A5pIeRST0TCePphnCm
         UPs4CD9wylmGlELNOaXHQEk3Rs3QegUdMeBPy2yI7049MnmovMy8kXAavF/zH9Pnpdaj
         e5f09BniwyrywUQVPsCRf7s+YtfXOVXJDJZWtYoQlJD3tjuktXsd+SwvH9fELndSCnPO
         8/pEURnhi9+HoAjAzdqpDRwjQvD1X+yQdsJqNDCPjQKiLlP22VPubGDlriCfUFkZeqgc
         olWg==
X-Forwarded-Encrypted: i=1; AHgh+RrrzzRnMrLW+RTZA3Cvr/au3uz41Fh/qkW0fBByWFyIVf8+hjuD2tVPeGWVFEeS+/rhC0ZblPcrbK7DuTQ5Ru8zxFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwScm7xOKvnMRhzuQoeYfLK9veZ9r2Te6JDF5C5SrlHp7b5Np2C
	d9TxNhxokowNsNEZWpsEAYcqmyboUvmFb62dtafE+FCanfjjjo75+kAXR7dEnAXklF7i8yMU0X+
	iaFkQWlbhoz0dczpKss1o6Q==
X-Received: from wmlv15.prod.google.com ([2002:a05:600c:214f:b0:495:48af:c5b4])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8b52:b0:493:e365:7630 with SMTP id 5b1f17b1804b1-4997c147d7emr101323095e9.14.1786551240764;
 Wed, 12 Aug 2026 09:14:00 -0700 (PDT)
Date: Wed, 12 Aug 2026 17:13:37 +0100
In-Reply-To: <20260812161340.2417322-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260812161340.2417322-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260812161340.2417322-16-vdonnefort@google.com>
Subject: [PATCH v5 15/18] tracing/remotes: Add poll_ms tracefs file
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
index 5536e0df4379..b1c75666ab63 100644
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
2.55.0.691.gc56d675ccc-goog

