Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D641466B57
	for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Jul 2026 10:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784630185; cv=none; b=WGkFy8FZDn+SuNkc+/XMKRWc2ch9wPQ1iDD6mSi+TR34F7qiHKBSRWjNTGBPIFor6kZf5+KeE8RR8u5xdgat1udyCRhuyYEOJIWmfYRwGOdf34ZJgEePBUqG9SE2RhqopMbZnYlifnGpozDWfxp7BsIgrgftuJtufSHa62AWJkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784630185; c=relaxed/simple;
	bh=4RzvMYYUmcC8a7WFEXI43GURgwb4D9e+URDbH/zkWFs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lvy8sxZ+yOZUJR6UWf3KjQOfhF75beWPwn4yR6YCwMOtg8FDXgRnK+mCYSk+xqpNXH1sYCL64/7MDDsoGlvufogcDoTOl/25TSR+mw6VXNmrko87CViuHaGl/gNWv0tS2zlhEcUz8jcKwAAW8/Kb/fNanhbFZCZABA/FTiyGjIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YBorFi5J; arc=none smtp.client-ip=209.85.128.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YBorFi5J"
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49544a639e9so28162095e9.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Jul 2026 03:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784630182; x=1785234982; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9NCFlRVcFoYdXmcFJ9HcykWhunLn7iTEPdOs8lRZiyY=;
        b=YBorFi5JP9BX+9jX+Lw6ObvpVUgqQrMR9A+D/zTViIfPfm7ar64wZeC2fmv9ekVzyF
         mwxyNMhtDeZF0S5YTQRqmPIKyFd4sKxFY1xVXzxFkOupd9PECHa5+idcw4SO8PX7igTJ
         fLeAk1tHKwDrtoNybA2NO8w9yhVlvR69JSuBChE6/JqmY0nDmw4R4JgEaB7ux/3sH6RF
         e5sX5/kLWcjnhCXPWegneRNzeY/Jxz7safxSLI4feLi5TDKJ+K6ENNgVyLCTI+iBkmUu
         0XdjbmOUbiTIfFQraefZfOweNxhQ89ci7I6QtKzUufVSHhWftUxf4SLgVDRNV0CDghwv
         Q9Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784630182; x=1785234982;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9NCFlRVcFoYdXmcFJ9HcykWhunLn7iTEPdOs8lRZiyY=;
        b=Yy2qrNhIRlp0RoWwxQKZIrZikBZfN2gag5yaqAuf1dZYF6PDtQFr55+Sl0vSSWaXOM
         5clm8VeevSrdQxvNmgFq+U3Zc8fZUetaVorJHtoSe4zcSo51+AbXyRKsXSJAgiDPohga
         aPNvFd8KRew+luuZGqMXOtwHZWAXPTRs7z0//6BFcNAqH9VGP+At3sP1fDBYzmSCy/fG
         ArAdJOGCdXN6HMppK8MlDp3oHJdGaF/16ECHc0BSsDNHiItxttWYvya2U/LUtQ8f2C94
         JeWMftdzdWn/2vUFCezdmUKo93jRCnEA+L4PdqYy+PA2gnllwHlnA2rnuQa2M9688s5u
         EgkA==
X-Forwarded-Encrypted: i=1; AHgh+RrvaoOeAIF1Bl0Pv0y+ykvb6iIOEwkTHLjxP7nEaYX2KX7PWug9rjLiW7FhYO8clzpRhOP8PTWo6fnHVHXSjPFPWAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUIozl9IggAT5K+fjCR9Hoqk5NgKrbNs7718nux0nC84xujMw4
	EWlMyYbRgFJEvS3fMDdP1CkxRgt8OsOQObYwmvS6CHRm2OO76OgxvCuncZXJL8VgUD1dTO1//Wo
	6TpElQ42MM2qgxT9b9vOiBA==
X-Received: from wmbel22.prod.google.com ([2002:a05:600c:3e16:b0:493:bccc:32b3])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1987:b0:495:518a:5cbf with SMTP id 5b1f17b1804b1-495518a5e95mr159303295e9.32.1784630181518;
 Tue, 21 Jul 2026 03:36:21 -0700 (PDT)
Date: Tue, 21 Jul 2026 11:35:46 +0100
In-Reply-To: <20260721103603.342266-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260721103603.342266-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260721103603.342266-2-vdonnefort@google.com>
Subject: [PATCH v3 01/18] tracing/remotes: Gate tracefs files opening on trace
 remote registration
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently, if a remote fails to register, its resources will leak and
will not be properly tear-downed.

To prevent a user accessing a remote tracefs that is about to be
destroyed, keep track of the registered remotes in a global list,
similarly to trace instances. Gate the tracefs to open function based on
the presence of the remote in that list.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index 0f6ef5c36d84..522f3e67f17b 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -39,6 +39,7 @@ struct trace_remote_iterator {
 };
 
 struct trace_remote {
+	struct list_head		node;
 	struct trace_remote_callbacks	*cbs;
 	void				*priv;
 	struct trace_buffer		*trace_buffer;
@@ -57,6 +58,9 @@ struct trace_remote {
 	bool				tracing_on;
 };
 
+static DEFINE_MUTEX(trace_remotes_lock);
+static LIST_HEAD(trace_remotes);
+
 static bool trace_remote_loaded(struct trace_remote *remote)
 {
 	return !!remote->trace_buffer;
@@ -170,6 +174,60 @@ static void trace_remote_reset(struct trace_remote *remote, int cpu)
 	trace_remote_try_unload(remote);
 }
 
+static int trace_remote_tracefs_open(struct inode *inode, struct file *filp)
+{
+	void *i_private = inode->i_private;
+	struct trace_remote *r;
+
+	if (!i_private)
+		return -ENODEV;
+
+	guard(mutex)(&trace_remotes_lock);
+
+	/* i_private is either a struct trace_remote or a struct remote_event */
+	list_for_each_entry(r, &trace_remotes, node) {
+		if (r == i_private)
+			return 0;
+		if (!r->events)
+			continue;
+		if (i_private >= (void *)r->events &&
+		    i_private < (void *)(r->events + r->nr_events))
+			return 0;
+	}
+
+	return -ENODEV;
+}
+
+#define DEFINE_TRACE_REMOTE_ATTRIBUTE_FUNCS(__name)			\
+static int __name ## _open(struct inode *inode, struct file *file)	\
+{									\
+	int ret = trace_remote_tracefs_open(inode, file);		\
+									\
+	if (ret)							\
+		return ret;						\
+									\
+	return single_open(file, __name ## _show, inode->i_private);	\
+}
+
+#define DEFINE_TRACE_REMOTE_ATTRIBUTE(__name)				\
+DEFINE_TRACE_REMOTE_ATTRIBUTE_FUNCS(__name)				\
+static const struct file_operations __name ## _fops = {			\
+	.open		= __name ## _open,				\
+	.read		= seq_read,					\
+	.write		= __name ## _write,				\
+	.llseek		= seq_lseek,					\
+	.release	= single_release,				\
+}
+
+#define DEFINE_TRACE_REMOTE_SHOW_ATTRIBUTE(__name)			\
+DEFINE_TRACE_REMOTE_ATTRIBUTE_FUNCS(__name)				\
+static const struct file_operations __name ## _fops = {			\
+	.open		= __name ## _open,				\
+	.read		= seq_read,					\
+	.llseek		= seq_lseek,					\
+	.release	= single_release,				\
+}
+
 static ssize_t
 tracing_on_write(struct file *filp, const char __user *ubuf, size_t cnt, loff_t *ppos)
 {
@@ -198,7 +256,7 @@ static int tracing_on_show(struct seq_file *s, void *unused)
 
 	return 0;
 }
-DEFINE_SHOW_STORE_ATTRIBUTE(tracing_on);
+DEFINE_TRACE_REMOTE_ATTRIBUTE(tracing_on);
 
 static ssize_t buffer_size_kb_write(struct file *filp, const char __user *ubuf, size_t cnt,
 				    loff_t *ppos)
@@ -235,7 +293,7 @@ static int buffer_size_kb_show(struct seq_file *s, void *unused)
 
 	return 0;
 }
-DEFINE_SHOW_STORE_ATTRIBUTE(buffer_size_kb);
+DEFINE_TRACE_REMOTE_ATTRIBUTE(buffer_size_kb);
 
 static int trace_remote_get(struct trace_remote *remote, int cpu)
 {
@@ -593,6 +651,11 @@ static int trace_pipe_open(struct inode *inode, struct file *filp)
 	struct trace_remote *remote = inode->i_private;
 	struct trace_remote_iterator *iter;
 	int cpu = tracing_get_cpu(inode);
+	int ret;
+
+	ret = trace_remote_tracefs_open(inode, filp);
+	if (ret)
+		return ret;
 
 	guard(mutex)(&remote->lock);
 
@@ -734,22 +797,26 @@ static int trace_open(struct inode *inode, struct file *filp)
 	int cpu = tracing_get_cpu(inode);
 	int ret;
 
+	ret = trace_remote_tracefs_open(inode, filp);
+	if (ret)
+		return ret;
+
 	if (!(filp->f_mode & FMODE_READ))
 		return 0;
 
+	ret = seq_open(filp, &trace_sops);
+	if (ret)
+		return ret;
+
 	guard(mutex)(&remote->lock);
 
 	iter = trace_remote_iter(remote, cpu, TRI_NONCONSUMING);
-	if (IS_ERR(iter))
+	if (IS_ERR(iter)) {
+		seq_release(inode, filp);
 		return PTR_ERR(iter);
-
-	ret = seq_open(filp, &trace_sops);
-	if (ret) {
-		trace_remote_iter_free(iter);
-		return ret;
 	}
 
-	((struct seq_file *)filp->private_data)->private = (void *)iter;
+	((struct seq_file *)filp->private_data)->private = iter;
 
 	return 0;
 }
@@ -932,8 +999,12 @@ int trace_remote_register(const char *name, struct trace_remote_callbacks *cbs,
 	}
 
 	ret = cbs->init ? cbs->init(remote->dentry, priv) : 0;
-	if (ret)
+	if (ret) {
 		pr_err("Init failed for trace remote '%s' (%d)\n", name, ret);
+	} else {
+		guard(mutex)(&trace_remotes_lock);
+		list_add(&remote->node, &trace_remotes);
+	}
 
 	return ret;
 }
@@ -1070,7 +1141,7 @@ static ssize_t remote_event_enable_write(struct file *filp, const char __user *u
 
 	return count;
 }
-DEFINE_SHOW_STORE_ATTRIBUTE(remote_event_enable);
+DEFINE_TRACE_REMOTE_ATTRIBUTE(remote_event_enable);
 
 static int remote_event_id_show(struct seq_file *s, void *unused)
 {
@@ -1080,7 +1151,7 @@ static int remote_event_id_show(struct seq_file *s, void *unused)
 
 	return 0;
 }
-DEFINE_SHOW_ATTRIBUTE(remote_event_id);
+DEFINE_TRACE_REMOTE_SHOW_ATTRIBUTE(remote_event_id);
 
 static int remote_event_format_show(struct seq_file *s, void *unused)
 {
@@ -1109,7 +1180,7 @@ static int remote_event_format_show(struct seq_file *s, void *unused)
 
 	return 0;
 }
-DEFINE_SHOW_ATTRIBUTE(remote_event_format);
+DEFINE_TRACE_REMOTE_SHOW_ATTRIBUTE(remote_event_format);
 
 static int remote_event_callback(const char *name, umode_t *mode, void **data,
 				 const struct file_operations **fops)
@@ -1184,6 +1255,7 @@ static ssize_t remote_events_dir_enable_read(struct file *filp, char __user *ubu
 }
 
 static const struct file_operations remote_events_dir_enable_fops = {
+	.open = trace_remote_tracefs_open,
 	.write = remote_events_dir_enable_write,
 	.read = remote_events_dir_enable_read,
 };
@@ -1208,6 +1280,7 @@ remote_events_dir_header_page_read(struct file *filp, char __user *ubuf, size_t
 }
 
 static const struct file_operations remote_events_dir_header_page_fops = {
+	.open = trace_remote_tracefs_open,
 	.read = remote_events_dir_header_page_read,
 };
 
@@ -1231,6 +1304,7 @@ remote_events_dir_header_event_read(struct file *filp, char __user *ubuf, size_t
 }
 
 static const struct file_operations remote_events_dir_header_event_fops = {
+	.open = trace_remote_tracefs_open,
 	.read = remote_events_dir_header_event_read,
 };
 
-- 
2.55.0.229.g6434b31f56-goog

