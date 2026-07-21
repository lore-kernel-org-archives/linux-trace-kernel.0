Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADED4DA539
	for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Jul 2026 10:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784630200; cv=none; b=Tlj7qPpcmiTwRYpVm7x667uAy2RkTJQPK/I5JSvOCZ+7sbfHThBzneI1Ouva3Tk5s9Eh7SVAblOaM96TN4gn+Fb7H+cpoIbUb3qzbc0zggQOPUaYXVEie24kKsjVQJHVh4zyAH7SjH4d+vnlTsBu8iUJh5cPcN0+DQ1pnsVqIbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784630200; c=relaxed/simple;
	bh=SJGMeMo7vdlJj4KTIcysWz2tTR5MAgYq2iGHZXVnUss=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RsT28BiqQ7XITezBgbsh2iOePJElHd9YKoKFlnzRdt6k8LP3N4dPLlMapE3fFQpnw0l3TiPX3H1MMUEeiZq1lgqn6ZWnHYDDrB5MmFNHZBMrYrwrNmLUOgLSKqrTuIYupOUJOUwIWR8KTA7ItHmKKGUqGPfHj7GZXFA9Xfmxo54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rmsyw+Ra; arc=none smtp.client-ip=209.85.128.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rmsyw+Ra"
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49559af7b97so17660765e9.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Jul 2026 03:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784630197; x=1785234997; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MUV8gsS7qAbohm6KrsxERDLgclwo/eDof24HSs0KbKY=;
        b=rmsyw+Ra50aTL1ElxAIQDe2XFblRTK9MStr2XxbMvWZwuTln+YKJafPy1fGHdIYh/I
         JP1sKTu+/ad2yHz0M77/uJ27e/QhTmChPRlhK0N6iF7aOyNmSgAX89DsUdKzW+lX6C1i
         GkzLk5aDg4UXl+OL+BUbuz0QeBmm5kgTskR1rGSdRmJ0YO9AA0TbgNb6goy8kq0UKWei
         rcpIQPmt5lAisU+vIPfs/6tAsVa5W+xPCpEL7RUWQ+pPN0FBIMLaeLm3W3hAjbTAOnfA
         7uuAFi+LFDtN4f+VdH+8y6Z26oPRVIZnfsUzbUmpjIT63EgSmz81LmJvvI/yF2rcR5jn
         T5hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784630197; x=1785234997;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MUV8gsS7qAbohm6KrsxERDLgclwo/eDof24HSs0KbKY=;
        b=FkdUy37rHESESKOW4qavjZ8yiUyGAMJKCHyyu6TcdFxZolMIz8ZYRcJv/NZP5vmGnR
         QkrGC18NJ8dJ9UuNji+yZTX6N+8LcjyiTAPDh3ODA/p/UucD3ewFatFj/0z972TD82Z0
         3bySQkslEH2WTNM+MoZjsLYTk9cmWzsH/hu+6kv3k8iuJNme+rNer9YPaXyAYbPSHbW8
         sBs6eAOt/2m/or/w+2cKH9RXX2g6uRegJNFBVbn66G6ZplxH6DAkTRBh5rf/C8eZQHhG
         Q4eQ9DxgM4FRCRKfWBswiLmoeG9+CBcUMgUQBngeMMQqYqivLZ5qFi2sywoZUjd+hzon
         D96A==
X-Forwarded-Encrypted: i=1; AHgh+RoNxwszH+A6ndlvboFYCAi5RJk7gU+nSHhrZ3aqjlfVxE0B++XAa/H6tdYBlhg1Xl6pCAwaoRnRRTYsHXXuZhilmnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMOMGxttbxgIld6EKqZPIRuaCmcYQKvgNIHCR+abTCIuKL6B94
	vkj8j8lXOMq39/bGJpuwfZ+DEAeJyv8q5C6FTyK7Lu2bmWUYgnVkUHmgLzI/IQ1RwvvDfMxL5K4
	zSJvArI0TO3/KLbA4Qy9XyQ==
X-Received: from wmbdx13.prod.google.com ([2002:a05:600c:63cd:b0:495:5bab:557])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b24:b0:493:e79e:da6b with SMTP id 5b1f17b1804b1-4954a41148amr211833505e9.21.1784630197264;
 Tue, 21 Jul 2026 03:36:37 -0700 (PDT)
Date: Tue, 21 Jul 2026 11:36:00 +0100
In-Reply-To: <20260721103603.342266-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260721103603.342266-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260721103603.342266-16-vdonnefort@google.com>
Subject: [PATCH v3 15/18] tracing/remotes: Add poll_ms tracefs file
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
index d109b2503db9..33dd3333b90a 100644
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
2.55.0.229.g6434b31f56-goog

