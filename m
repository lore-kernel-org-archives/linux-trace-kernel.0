Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9729A33120D
	for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Jan 2026 10:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769424275; cv=none; b=SvRNV6zvVXnEFcG0JmRq+N4vGRcI4XE66Oqm4NR36wjBCLfxej/qnWWQpRS1tLBPekGhFddQR0vHlIkzI2Tm59ZSdOleR3JN5pr47PXywgRaJLTUXogCi4tSXqX1LonoKA8R1AO1XuCVJ+bOSQE53W1Go0z09pMA/qje7oCbi2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769424275; c=relaxed/simple;
	bh=vvi8qpGjNkMIPtIb6W8p79MsC1kM6v+aQRv35a7e8XI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I5xbkJ4fXZY/i2Nxg5DRUXjYzExqvoCU1bxt2lvshO9e30sOrRFY811SKokbR1Fl3DEOyb6eU3+OJNkAW1Ndc90MmEznKGZe9haPCoJYfSlxpaXOD1xGlqBqUl9bkts/hvDwfomAknvdPMAn7VLvybV6H383azhh3bHWBRv18bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kgqef0Rx; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kgqef0Rx"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4802bb29400so77856775e9.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Jan 2026 02:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769424272; x=1770029072; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gO4YNQJWWfD/ARRZWKWkjPHJll8Owsq1oA4pi9BzLQQ=;
        b=Kgqef0RxAgHBFu/UXI7ZubC1HB9qv2JIo4Q0nzpjibJkiHNqm2KLnkufFX5qxAQ+o6
         MD/NWfK0cVF6wBEVg+yBvbB/ScilgvBith4zbBLwsxo+xwzo5XwJP0fF/LSbsd1EgrsC
         3A145UHoB/g/5g1Y4J1NnAbaPWtREI9e1z1P4MJPRIo5s/bIS7HjXe9FSPUBVxXBDQCX
         VT04palxaEl3pq5h0lFO3AR3Crl/xd+c/JPDy4NSjzLu0OwmEYeP0V0sqn2KF+1g69Yw
         XEFyhs+o1RiMq/vdky3944htOYKwswlCY93Bj1t6fMsdlQx2mEguecxTD3sotpqKFzfe
         4TTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769424272; x=1770029072;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gO4YNQJWWfD/ARRZWKWkjPHJll8Owsq1oA4pi9BzLQQ=;
        b=L1xLtYUxrpWZh+eY9VpgMaqwZKhaeH46hkljWN23fOVFFcBjAYMYqVqbx8PsizAdae
         eO8yRhbL5y8YXSIEuNNz0SGdvaLV7Guw3pZkxRpLf608LS/HYZI5JcwST6mxBuuwi9i5
         t6rqwdmz6WdWSYKT5Ku3BwJUjBKbawnRpRfFU22gHuO78npZkY6iNhiKKYtStMk4Udqe
         PkU9D+p++nqtuCwFAiN7uFNgjnCqP4PCYm2/kaBzzBfPUhcIgOrOUMV6f3P7f4uiXLew
         fHBUviSYO3BAYiPQ0uwSJ6Vp3C7C+A1ZEmGrmYPR3dBnBhMofb5NnaJgeRKdZuSQpfst
         0JhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFCIUo4uKtQKseVw63Kh+/Rp5oNYqJ+y4a/fTWYFR3uQyefiU7k8C4QTRkTSqHGOqAg2hkDUDK4WNWxS7znrMvFOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX8x0WqUG4H8YldznDhAKQ2b2pVpOxAX7IaYuOQSX4A4UIK+wi
	bAlD7x/ERWolvnARjbZj3lV9qVMtC+BqMVrOUJ/2rrF5ObD01Hl7nwAZTkeIT8lm6fCbJjf1exD
	h2RTeDBxkMnK0feIfjKWJiw==
X-Received: from wmjx21.prod.google.com ([2002:a05:600c:21d5:b0:47d:86c6:ebc9])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3e1a:b0:477:7b16:5fb1 with SMTP id 5b1f17b1804b1-4805cd430c9mr70494535e9.7.1769424272078;
 Mon, 26 Jan 2026 02:44:32 -0800 (PST)
Date: Mon, 26 Jan 2026 10:43:55 +0000
In-Reply-To: <20260126104419.1649811-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260126104419.1649811-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260126104419.1649811-7-vdonnefort@google.com>
Subject: [PATCH v10 06/30] tracing: Add reset to trace remotes
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

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/include/linux/trace_remote.h b/include/linux/trace_remote.h
index feb3433c2128..55754ef78104 100644
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
 
 /**
diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index 3d80ff98fd90..49c4ae127533 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -63,6 +63,7 @@ static int trace_remote_load(struct trace_remote *remote)
 	rb_remote->desc = remote->trace_buffer_desc;
 	rb_remote->swap_reader_page = remote->cbs->swap_reader_page;
 	rb_remote->priv = remote->priv;
+	rb_remote->reset = remote->cbs->reset;
 	remote->trace_buffer = ring_buffer_alloc_remote(rb_remote);
 	if (!remote->trace_buffer) {
 		remote->cbs->unload_trace_buffer(remote->trace_buffer_desc, remote->priv);
@@ -136,6 +137,21 @@ static int trace_remote_disable_tracing(struct trace_remote *remote)
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
@@ -410,6 +426,26 @@ static const struct file_operations trace_pipe_fops = {
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
 	struct dentry *remote_d, *percpu_d;
@@ -440,7 +476,9 @@ static int trace_remote_init_tracefs(const char *name, struct trace_remote *remo
 	    !trace_create_file("buffer_size_kb", TRACEFS_MODE_WRITE, remote_d, remote,
 			       &buffer_size_kb_fops) ||
 	    !trace_create_file("trace_pipe", TRACEFS_MODE_READ, remote_d, remote,
-			       &trace_pipe_fops))
+			       &trace_pipe_fops) ||
+	    !trace_create_file("trace", TRACEFS_MODE_WRITE, remote_d, remote,
+			       &trace_fops))
 		goto err;
 
 	percpu_d = tracefs_create_dir("per_cpu", remote_d);
@@ -462,7 +500,9 @@ static int trace_remote_init_tracefs(const char *name, struct trace_remote *remo
 		}
 
 		if (!trace_create_cpu_file("trace_pipe", TRACEFS_MODE_READ, cpu_d, remote, cpu,
-					   &trace_pipe_fops))
+					   &trace_pipe_fops) ||
+		    !trace_create_cpu_file("trace", TRACEFS_MODE_WRITE, cpu_d, remote, cpu,
+					   &trace_fops))
 			goto err;
 	}
 
-- 
2.52.0.457.g6b5491de43-goog

