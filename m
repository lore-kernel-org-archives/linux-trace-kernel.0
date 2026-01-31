Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE533542C6
	for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Jan 2026 13:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769866171; cv=none; b=ZoFwlVkE7DWEHxQ/962syRAOV+jALYze0Eqp4gT5XW8afS1OE1RTILc0QrqX6bvYSoNxgo5uP0hU1AIOhMy3eUfd/20xPgbdkwcAIdtveaBpPiIydEATit9m5R34UQffaPZJ/EvE3ZkUqNnQH3DOrJJbHF1/Bt637FEhhRSSXPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769866171; c=relaxed/simple;
	bh=2ARo2SiydEoEnxginXLlK5ytsAnPW1RAxdvwdzQPGBc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pvN/WdYzNRVISxQgEFTFeQJveCocWqHv/9FN1Z+Zr/ydqi/d3sLmn+JBhztT/4WVe2zoNKtTvrizMjYMBtQvhuqtjOGh8SrLnR+QBnKUu5+MacY/E69rodojRuMf2zlov9Rj4K1vaD4FxMg/KNs6SZnLW1/Fz4t4qhQP0FBvZ6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p54A7Sj/; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p54A7Sj/"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-48071615686so22052215e9.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Jan 2026 05:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769866167; x=1770470967; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ERRzO3AEMEo0ywt1F8tEw+KoWErOg0ckwY8dacZ6eiw=;
        b=p54A7Sj/2HN0Fmi7hlvkFHS3i4v/vQ/YK4S6jksbAZJOTtHW9i11jbxGNVtHI+bJxn
         e3CBdjMrmLXKS2PDEM7PH8ZJn+IclxSsii1EC8kkYPKI2orn4e6XAAAScdrlekgECi+P
         XSEKraGTs05v3cBryokKrT2IZp3+yXPgsSY9aZhWhv+JKmnnCTVJO4KZBT0sMaslD0jh
         vJ4lORHsgYBM1HNzpO17Z7Qo9u5uY3rFLK6ER/wX/NralghqlLXkSGyWBLWuGJeEDxWc
         /y+FWveOFyE9JaaI10Vc87epoe9AEHiwfu2vd9q7u8FI1P1r0W+R1GO8jEVdqwWay6rL
         z9VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769866167; x=1770470967;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ERRzO3AEMEo0ywt1F8tEw+KoWErOg0ckwY8dacZ6eiw=;
        b=vyV7RcORvlphWTtNfnLaejs63BSxtAkvz5z58VYooVOeAvn0OEKSbVkKetzgXOWGua
         5SFWArFmx7T7/H1uKv5fe8YvCTppKvcF8rTfYZLt4/VQ3Ggc06fnnK7kxv8+ESD6dp93
         tpJQEiThf32QAKzhwjTC0OHKVZZUd+5sJIjxay4KsFemr34tiRKFOOhAcBLE6SJB6Dl/
         C1dSBEclkneq1rZF152YJ55ZMOhX19ZMsyRUASxemeoIQQRVoWT6hburSeig4Iq+fyTT
         ZFJWKtmKPXR8jGWm6vkHAd0H8Srf648Mme71Bsvy11Ut31kgSyfUkONXrgyk7hltIbfK
         oUyw==
X-Forwarded-Encrypted: i=1; AJvYcCX00cbBgYiOwVC0xEFVvYME4/Nm6is1aNXdHNFHD4t333il75Mv4iL+FZyQDuc+3VU/5BGKVr+iZdLGsl5TRcBD4qM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPGqmK0VvFDrYzVvhYOnGzbwyTpaxDX9ahPDgBN8BugQwoJPQO
	bMm1BFh7yh8j8GGDtEq9Nl+5lzaoPgU1mZCo0xDlNhPzTMIUFHkO7zxAX55XSbCuQKPS5YZI3a2
	n/J+QDYohM3MSq/sSCzIEMA==
X-Received: from wmqu15.prod.google.com ([2002:a05:600c:19cf:b0:477:a0a1:eae8])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1e24:b0:480:6a46:3616 with SMTP id 5b1f17b1804b1-482db448890mr79441815e9.4.1769866167109;
 Sat, 31 Jan 2026 05:29:27 -0800 (PST)
Date: Sat, 31 Jan 2026 13:28:24 +0000
In-Reply-To: <20260131132848.254084-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260131132848.254084-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260131132848.254084-7-vdonnefort@google.com>
Subject: [PATCH v11 06/30] tracing: Add reset to trace remotes
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	aneesh.kumar@kernel.org, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Allow to reset the trace remote buffer by writing to the Tracefs "trace"
file. This is similar to the regular Tracefs interface.

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/include/linux/trace_remote.h b/include/linux/trace_remote.h
index bd327a8184a0..7fb5271a8c30 100644
--- a/include/linux/trace_remote.h
+++ b/include/linux/trace_remote.h
@@ -18,6 +18,8 @@
  *			remote to allow writing.
  * @swap_reader_page:	Called when Tracefs consumes a new page from a
  *			ring-buffer. It is expected from the remote to isolate a
+ * @reset:		Called on `echo 0 > trace`. It is expected from the
+ *			remote to reset all ring-buffer pages.
  *			new reader-page from the @cpu ring-buffer.
  */
 struct trace_remote_callbacks {
@@ -25,6 +27,7 @@ struct trace_remote_callbacks {
 	void	(*unload_trace_buffer)(struct trace_buffer_desc *desc, void *priv);
 	int	(*enable_tracing)(bool enable, void *priv);
 	int	(*swap_reader_page)(unsigned int cpu, void *priv);
+	int	(*reset)(unsigned int cpu, void *priv);
 };
 
 int trace_remote_register(const char *name, struct trace_remote_callbacks *cbs, void *priv);
diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index f8ab328df70a..82060bb19ba1 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -63,6 +63,7 @@ static int trace_remote_load(struct trace_remote *remote)
 	rb_remote->desc = desc;
 	rb_remote->swap_reader_page = remote->cbs->swap_reader_page;
 	rb_remote->priv = remote->priv;
+	rb_remote->reset = remote->cbs->reset;
 	remote->trace_buffer = ring_buffer_alloc_remote(rb_remote);
 	if (!remote->trace_buffer) {
 		remote->cbs->unload_trace_buffer(desc, remote->priv);
@@ -138,6 +139,21 @@ static int trace_remote_disable_tracing(struct trace_remote *remote)
 	return 0;
 }
 
+static void trace_remote_reset(struct trace_remote *remote, int cpu)
+{
+	lockdep_assert_held(&remote->lock);
+
+	if (!trace_remote_loaded(remote))
+		return;
+
+	if (cpu == RING_BUFFER_ALL_CPUS)
+		ring_buffer_reset(remote->trace_buffer);
+	else
+		ring_buffer_reset_cpu(remote->trace_buffer, cpu);
+
+	trace_remote_try_unload(remote);
+}
+
 static ssize_t
 tracing_on_write(struct file *filp, const char __user *ubuf, size_t cnt, loff_t *ppos)
 {
@@ -414,6 +430,26 @@ static const struct file_operations trace_pipe_fops = {
 	.release	= trace_pipe_release,
 };
 
+static ssize_t trace_write(struct file *filp, const char __user *ubuf, size_t cnt, loff_t *ppos)
+{
+	struct inode *inode = file_inode(filp);
+	struct trace_remote *remote = inode->i_private;
+	int cpu = RING_BUFFER_ALL_CPUS;
+
+	if (inode->i_cdev)
+		cpu = (long)inode->i_cdev - 1;
+
+	guard(mutex)(&remote->lock);
+
+	trace_remote_reset(remote, cpu);
+
+	return cnt;
+}
+
+static const struct file_operations trace_fops = {
+	.write		= trace_write,
+};
+
 static int trace_remote_init_tracefs(const char *name, struct trace_remote *remote)
 {
 	struct dentry *remote_d, *percpu_d, *d;
@@ -452,6 +488,10 @@ static int trace_remote_init_tracefs(const char *name, struct trace_remote *remo
 	if (!d)
 		goto err;
 
+	d = trace_create_file("trace", TRACEFS_MODE_WRITE, remote_d, remote, &trace_fops);
+	if (!d)
+		goto err;
+
 	percpu_d = tracefs_create_dir("per_cpu", remote_d);
 	if (!percpu_d) {
 		pr_err("Failed to create tracefs dir "TRACEFS_DIR"%s/per_cpu/\n", name);
@@ -474,6 +514,11 @@ static int trace_remote_init_tracefs(const char *name, struct trace_remote *remo
 					  &trace_pipe_fops);
 		if (!d)
 			goto err;
+
+		d = trace_create_cpu_file("trace", TRACEFS_MODE_WRITE, cpu_d, remote, cpu,
+					  &trace_fops);
+		if (!d)
+			goto err;
 	}
 
 	return 0;
-- 
2.53.0.rc1.225.gd81095ad13-goog

