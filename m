Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52EA46AA68
	for <linux-trace-kernel@vger.kernel.org>; Tue,  4 Aug 2026 14:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785852236; cv=none; b=rDUVcetZCDkP1yy4r+2nxHlRyMHJf1G0eFVdkazPwo+et5zP/mYnaL2DVO+Ko5moSSkujJI7ZqQWcNC/lS3oWqgaKWMhvzJIpYizmdJ1C2W3UN0Qs8u+X9LmJmqolEf9/xHPbm192NGs7fn+2aW334osWu2Q2/5v38dt3K863o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785852236; c=relaxed/simple;
	bh=6qDvctFwiRtQnW9hh5pPZSo3OigRO4Spf8WVxLaSAFY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HkD6yhvZvGwDLKs9uDT6RfxmeDNys+IWMJ3s4m3MULsXhjtSdCCVbgjFdeVf6OSB+D1ZNspWGe8ody6LeFDTWf6kqbvoEF72Bzzkp9Tyuo/K29Z/TSJqHV/NZbZZziDWN81HzSPw1QQBBcwBWKklefqZzfTa8ftGqwJV8uH8G64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PQzycZa0; arc=none smtp.client-ip=209.85.128.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PQzycZa0"
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49571407d1dso23394315e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 04 Aug 2026 07:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785852233; x=1786457033; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+8opRsT5LzS+GIuqYDwGNkUMU0tmiiRh3ZQ9mQy9bPg=;
        b=PQzycZa0yA7r0jpZEGx2nKorTdXiR7KCVReL0uhH+Svqae3ce6urF0haHgjmA1z0KD
         9j5R8fGmdbq1I1aEGVm6oEuw4A0E5wf6EqDLXRC8TtbojvuYpLjcsYMgLTWiqCJ12tWS
         CmAT9Tp1/Mg/9Ctx8i4A8SVlHJoLkKssohP06wVN6hMyDxxBxwmg7VScLwZuWsn+5cpy
         UfVtaaHzVsjmcKZnJoh0fbekCKw1rnBT9dL9bKH+LUJDLstoys2pp/fekTy5FDt6WEWA
         rtR6fEpvwgObf5K+8lnZ5d1psWnTEA61yPyS23V41ewHkwBXSqG3t0GMMSM2AZ5EyfBW
         2n4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785852233; x=1786457033;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+8opRsT5LzS+GIuqYDwGNkUMU0tmiiRh3ZQ9mQy9bPg=;
        b=nuUlTlvAkRNjcVoLCdk92r8d6Q/aTwUB6NYyIS8wBmf8gyq/Zws2aBN7I5MGe2sf4P
         XcWUWOUYBRsy/j0tfyY2RjrjyexJh3WmFg+8whB1ARmLsQkmSSgeqK/cKNcm1CVc3ovd
         cwAUEgnKWNf+oZxdnZc2SiEM2Nqb08spm/Rv4ZuDu7OUtyYCu2ZGYSDuBOVGgUYjb/78
         E4TlWq5od9cnqu/g73ibfFBPtIavFAsfNf0Vl9biYnJyj213Y5b/6X1I2rlUe8YODGq8
         ed/4f6CbUzHz7HG6omhS0e0xaO0sUddnbyXIJasMqt9d/d8ez17ywUvKPp3kBTF2q58y
         YYEg==
X-Forwarded-Encrypted: i=1; AHgh+RodyFCY0k4rFQCZdSasBSxndNWgt+6y4vsf6GMNWahmwSCJhXKlhwqgmhsDe0Eb5izCdVXLGy1FCAE5iQOpzMCPIxI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylo+S5mrzXbnf7/AwySAZy2acnmZHrOdnk0JIBZfyGQxWhzrml
	lDC23cm95JUk0eLy17LXF0Dd0IzJy9GToLvgGVwR3Ik9qVo+lg/Md6kJiCMZPUDVnt8O1eaMZtZ
	A6kRBkuW1UiRTps0s2cLqjA==
X-Received: from wmbhi18.prod.google.com ([2002:a05:600c:5352:b0:495:4728:580])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6209:b0:495:6396:8b67 with SMTP id 5b1f17b1804b1-4980c649f67mr365562795e9.4.1785852232284;
 Tue, 04 Aug 2026 07:03:52 -0700 (PDT)
Date: Tue,  4 Aug 2026 15:03:16 +0100
In-Reply-To: <20260804140333.797210-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260804140333.797210-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260804140333.797210-2-vdonnefort@google.com>
Subject: [PATCH v4 01/18] tracing/remotes: Gate tracefs files opening on trace
 remote registration
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently, if a remote fails to register, its resources will leak and
will not be properly torn down.

To prevent a user accessing a remote tracefs that is about to be
destroyed, keep track of the registered remotes in a global list,
similarly to trace instances. Gate the tracefs open function based on
the presence of the remote in that list.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index e6724f947170..ce2d517183b7 100644
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
@@ -1069,7 +1140,7 @@ static ssize_t remote_event_enable_write(struct file *filp, const char __user *u
 
 	return count;
 }
-DEFINE_SHOW_STORE_ATTRIBUTE(remote_event_enable);
+DEFINE_TRACE_REMOTE_ATTRIBUTE(remote_event_enable);
 
 static int remote_event_id_show(struct seq_file *s, void *unused)
 {
@@ -1079,7 +1150,7 @@ static int remote_event_id_show(struct seq_file *s, void *unused)
 
 	return 0;
 }
-DEFINE_SHOW_ATTRIBUTE(remote_event_id);
+DEFINE_TRACE_REMOTE_SHOW_ATTRIBUTE(remote_event_id);
 
 static int remote_event_format_show(struct seq_file *s, void *unused)
 {
@@ -1108,7 +1179,7 @@ static int remote_event_format_show(struct seq_file *s, void *unused)
 
 	return 0;
 }
-DEFINE_SHOW_ATTRIBUTE(remote_event_format);
+DEFINE_TRACE_REMOTE_SHOW_ATTRIBUTE(remote_event_format);
 
 static int remote_event_callback(const char *name, umode_t *mode, void **data,
 				 const struct file_operations **fops)
@@ -1194,6 +1265,7 @@ static ssize_t remote_events_dir_enable_read(struct file *filp, char __user *ubu
 }
 
 static const struct file_operations remote_events_dir_enable_fops = {
+	.open = trace_remote_tracefs_open,
 	.write = remote_events_dir_enable_write,
 	.read = remote_events_dir_enable_read,
 };
@@ -1218,6 +1290,7 @@ remote_events_dir_header_page_read(struct file *filp, char __user *ubuf, size_t
 }
 
 static const struct file_operations remote_events_dir_header_page_fops = {
+	.open = trace_remote_tracefs_open,
 	.read = remote_events_dir_header_page_read,
 };
 
@@ -1241,6 +1314,7 @@ remote_events_dir_header_event_read(struct file *filp, char __user *ubuf, size_t
 }
 
 static const struct file_operations remote_events_dir_header_event_fops = {
+	.open = trace_remote_tracefs_open,
 	.read = remote_events_dir_header_event_read,
 };
 
-- 
2.55.0.571.g244d577d93-goog

