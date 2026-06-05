Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DAF388E64
	for <linux-trace-kernel@vger.kernel.org>; Fri,  5 Jun 2026 16:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780677595; cv=none; b=QE8aNt+CamlquIo3xqhukibjsNmJkSJu+Gxw4ZHchmL6UNzTjnm5RA+ukEQAMLLtsy37rtlamorIDUupx/FrScQLtjGQlOG08NWUrOE03bezZYvQT0IK4wbC0xifwejdOnaj11Y1ByU8hIcyZntjudqRXoSDaMVMcGC5sOR52rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780677595; c=relaxed/simple;
	bh=00WrbL+qC++juy3mRxcciqsSEaz5mpzzlJJXNcnEw9E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W6LxHZ+mLvya8AXyj6Y26w3cMMIi2NPHW99eVLiI74Yc4OC6rLvOSKeGx6jARp45mLUp7SXMvYRfJX75kNM7s/K0aF4JUt+5/bHdHkO3vpGJP7ZsSydsWjzHlEu+eo8zYrl97Usmh8J4gn/Y6CHBQrQKyYw9nEDCVWn/SWqvrhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NWe5dORc; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NWe5dORc"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-bef1e83c990so194984966b.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 05 Jun 2026 09:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780677591; x=1781282391; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=A2LHKq5mEAFuwFPcckcFCn8LsvodpkOolH8tM9hbq18=;
        b=NWe5dORcO4z8MWKM77iHpgp2wRsu7QEUHWs/DVdON2v2hW7fdBnvhhTLWUTsRQiffB
         r1E+7lecN1oZRcf1n982S6/cz1sCULeateZL11e3Wq+M7bN/iuW72/k82YaphwgfiDP8
         frMm8I6qXl5cUK0MRGhToSXMFuJ3QyEZ7xgZ1yr4+lhe6haB/MRz9VWXz/sS3nDBhXO3
         s1Ufbsv9Sc0arsXCjmQPKpl6TaHx/mUbOUfVJ/uHW5LrHibkiUh9dTeDro8TXJwYiGet
         SnhVxEiHMbBy+Bek9bGLEv6W5it6ghwJLCOP2fsXtKT1W+opMrr2atOyfUd3IjpiB8j8
         0/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780677591; x=1781282391;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A2LHKq5mEAFuwFPcckcFCn8LsvodpkOolH8tM9hbq18=;
        b=FmOFYKUm/ZN7Dal1q6zCwAf5tx/wrc52FYkkUpsPEftQy5E/VYqI3bxsryEuNgaVoe
         /9dayQi9v6YVvHCmpV3dOARyrXdwPKiOJXb8+Pn1K3fruaw2a04hPTq35Sqq83dVX4iD
         6+5Kw+JZ1kZ4TjRgwj3HM0AvwVDihm9PFQLSbfRV/EE4Z/OW0IVyfn1kxAF4KgltxeaB
         lMgTyzLqRLV5iCawpJCbSxGlyr/eEO11cGwWv/n04QDpS6RIWS/vwQeWgZrs2ryncsx6
         wkAm4Z9YvYGKqAXqZxr2BdtibH7CHtCNaDizBipBO5fLi3PqC9vblryI0XPxk4qZMRoT
         MXxw==
X-Forwarded-Encrypted: i=1; AFNElJ/1WDwK6D8d1A3DEFaNKfbs2s3CIOeb7YLJkt5LDkR4I5qYPsjNZtYIkAWcdLao6Ge8RD9ifwUjiNKgaZ7PQ5REGig=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLBmOO/F1JLhI4BNu8IWED9SOm//vETsgMIPGJ+VqEGiCvtU/d
	1QuG8WxS+CF62QUswyfRRB4QKPwww820rj5bLNRDE0IyApCDHTnYSn+Wh9gv9skEVXeGJTFY7yL
	lJ7wnZMScX/1O7cihQm2MEQ==
X-Received: from ejcqs4.prod.google.com ([2002:a17:906:4584:b0:beb:d121:a74b])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:948e:b0:bf1:a59e:653f with SMTP id a640c23a62f3a-bf371e4379dmr234104066b.28.1780677591267;
 Fri, 05 Jun 2026 09:39:51 -0700 (PDT)
Date: Fri,  5 Jun 2026 17:38:22 +0100
In-Reply-To: <20260605163825.1762953-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260605163825.1762953-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260605163825.1762953-16-vdonnefort@google.com>
Subject: [PATCH v2 15/18] tracing/remotes: Add poll_ms tracefs file
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a tracefs file to configure the trace remote polling period. Keep
the default value to 100ms.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index cf99752e1cd5..f72fc862ae7f 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -1133,6 +1133,40 @@ static int dump_on_panic_show(struct seq_file *s, void *unused)
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
@@ -1165,6 +1199,10 @@ static int trace_remote_init_tracefs(const char *name, struct trace_remote *remo
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
2.54.0.1032.g2f8565e1d1-goog

