Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E993431E7
	for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Feb 2026 15:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771513408; cv=none; b=lQFnRz4ElbV44dhOLumH3EUc1OmfHgY672KJbpzI2ZRPvTTP306o6n8m8vFHorEqbYZWlCunY+to907qWHSXA87hV7zwNzpp79F/tvFHBGO9dtDaF42LOpRmLQQmZIr5LyvZhgoVUrnDYU2LYlRJXQ4/wdpzy59N3M6KRhBN7VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771513408; c=relaxed/simple;
	bh=Ia5GvWXuWKlkAsI1yDBlSrW60G/OSv3BnAiALWJuitM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G1b4YjlWvF78rpL5/hiKtH7e3MNYVzZVrUpQLtvUR6mhFk/h5BzNXAKouQHdhSJZD+wYUQMi2L4uhvrO3zQCU+ZVAc8vWoKD7LkyuRUTmM2NJU0lYP3bpHrCBGBeoqEJCNRoKzLlv81T1MViWdLnguUIgm0r4u+0U5ATHImVWq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HvxbzcGE; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HvxbzcGE"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4837907ec88so16684825e9.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Feb 2026 07:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771513404; x=1772118204; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jrhhrmHzIsZI2KCLr8Q8iAPC9xtikp6+6Y5SdjRW0GY=;
        b=HvxbzcGEgGo4FlnhJjF3KA9xTs5HIbg1EZZzGbZdBEF8xov3Kygla4aC18jbc6WhY3
         DCVnTPLA+W+79TlpBISJArqHTX4OZM6/F272Ahdct2S10GdCocAnK3EeLunF6H0qC/dQ
         N/LWJRxTroREvkXgnLj873dGpHSBz8kceYk8+/yS+xL+rhPBk05lXqyDNvpMztvVHHCN
         rx6BOuRzJAYqYXxESd/KWJUjQwkrnuunBBzZo6kPhtN7eEvohXUCZOirJi3+YaHDNYJ5
         VuPGYz4Sf+UCZJydvo0UQFov2ptdFneV/lO3nYDatd8nxtAkR0q8fe7b/t5ujS/m+FvG
         9lMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771513404; x=1772118204;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jrhhrmHzIsZI2KCLr8Q8iAPC9xtikp6+6Y5SdjRW0GY=;
        b=wDjDqXOVO6T2PZRIPGfI8vpAkUne0D8eem/JhwoVGBVphJogbXsd9dz9pF7vrq1B62
         hjKJm/ongd4u0C7WVvmiuWiqMED4+2eZkB7hC6N6H63daVlPaCULuh3tBQ2uh5auH72i
         zHenzx3Dv364TuY8gEirz3+o6dWuItOQD2e1kSHNslPsGIT83IE6raXYuzkCfNJ7iZd5
         aeNVrP+7PwbXMa5XHWcEnCAk6M5X6iyM+UGDq+UuFUJI8+8DW6rR3GIaDnCE/xMgwUwM
         Hwyrn4tjcdw0AJuDl3aW3LJKTUhcW7lcwZJyeDPRIzIwO/mAKk/jcXyApDdleLtGSbs7
         BGqg==
X-Forwarded-Encrypted: i=1; AJvYcCXCRKEULCfD3ngYOh2cnMnrSS5Lz39w3pRRDdj+54kiMXjqLO4B/kZ5hrXhJ63LTCCqp4knPnJbRDA7kPAFynHyHFc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5iyqxVAsoKCSIkAVrTgeOo2O+gJgp2CGnPW7BxSmIS9URAwas
	teAciANjfJ+p71N68Bg4CB03hFkEdrDhfurnGXxyyMnYSTCKaFkVMTURqRkz73ZxdB4Te4oe+qY
	g+CuJwZJI/mUTPV1FWwttyA==
X-Received: from wmbes20.prod.google.com ([2002:a05:600c:8114:b0:483:6fc1:fcdb])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600d:6443:10b0:483:8062:b43 with SMTP id 5b1f17b1804b1-48380620d3amr203528975e9.19.1771513404539;
 Thu, 19 Feb 2026 07:03:24 -0800 (PST)
Date: Thu, 19 Feb 2026 15:02:43 +0000
In-Reply-To: <20260219150307.14538-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260219150307.14538-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.53.0.335.g19a08e0c02-goog
Message-ID: <20260219150307.14538-7-vdonnefort@google.com>
Subject: [PATCH v12 06/30] tracing: Add reset to trace remotes
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
index 65b7e7b8267c..10ca03dc192b 100644
--- a/include/linux/trace_remote.h
+++ b/include/linux/trace_remote.h
@@ -17,6 +17,8 @@
  *			remote to allow writing.
  * @swap_reader_page:	Called when Tracefs consumes a new page from a
  *			ring-buffer. It is expected from the remote to isolate a
+ * @reset:		Called on `echo 0 > trace`. It is expected from the
+ *			remote to reset all ring-buffer pages.
  *			new reader-page from the @cpu ring-buffer.
  */
 struct trace_remote_callbacks {
@@ -24,6 +26,7 @@ struct trace_remote_callbacks {
 	void	(*unload_trace_buffer)(struct trace_buffer_desc *desc, void *priv);
 	int	(*enable_tracing)(bool enable, void *priv);
 	int	(*swap_reader_page)(unsigned int cpu, void *priv);
+	int	(*reset)(unsigned int cpu, void *priv);
 };
 
 int trace_remote_register(const char *name, struct trace_remote_callbacks *cbs, void *priv);
diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index 7015280cc9d3..83593fb8b425 100644
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
2.53.0.335.g19a08e0c02-goog

